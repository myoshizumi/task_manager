# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login ＆ Logout', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:admin)
  end
  describe 'New user registration' do
    context 'New registration' do
      it 'requires user name, email, and password(confirmation)' do
        visit new_user_path
        fill_in 'user_name', with: 'a'
        fill_in 'user_email', with: 'a@a.a'
        fill_in 'user_password', with: 'aaaaaa'
        fill_in 'user_password_confirmation', with: 'aaaaaa'
        click_on 'Create my account'
        expect(page).to have_content 'ログインしました'
      end
    end
    context 'User must login for the Task Index page' do
      it 'requires user login' do
        visit tasks_path
        expect(page).to have_content 'Login'
      end
    end
  end

  describe 'login system' do
    before do
      FactoryBot.create(:user, id: 2, email: 'nomore@errors.com', password: 'anymore')
      FactoryBot.create(:admin, id: 1)
    end
    context 'login' do
      it 'requires user email and password' do
        visit new_session_path
        fill_in 'session_email', with: 'nomore@errors.com'
        fill_in 'session_password', with: 'anymore'
        click_on 'Log in'
        expect(page).to have_content 'タスク'
      end
      it 'is possible to access my page' do
        visit new_session_path
        fill_in 'session_email', with: 'nomore@errors.com'
        fill_in 'session_password', with: 'anymore'
        click_on 'Log in'
        visit user_path(2)
        click_on 'Profile'
        expect(page).to have_content 'userのページ'
      end
      it "is impossible for user to access other's my page" do
        visit new_session_path
        fill_in 'session_email', with: 'nomore@errors.com'
        fill_in 'session_password', with: 'anymore'
        click_on 'Log in'
        visit user_path(1)
        expect(page).to have_content 'タスク一覧'
      end
      it 'is possible for user to logout' do
        visit new_session_path
        fill_in 'session_email', with: 'nomore@errors.com'
        fill_in 'session_password', with: 'anymore'
        click_on 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe 'admin system' do
    before do
      FactoryBot.create(:user, id: 2, email: 'nomore@errors.com', password: 'anymore', admin: false)
      FactoryBot.create(:admin, id: 1, email: 'no@errors.com', password: 'nomore', admin: true)
    end
    context 'login' do
      it 'is possible for admin to access admin pages' do
        visit new_session_path
        fill_in 'session_email', with: 'no@errors.com'
        fill_in 'session_password', with: 'nomore'
        click_on 'Log in'
        sleep(1)
        click_on 'ユーザー管理一覧に戻る'
        expect(page).to have_content 'ユーザーを新規登録する'
      end
      it 'is impossible for user to access admin page' do
        visit new_session_path
        fill_in 'session_email', with: 'nomore@errors.com'
        fill_in 'session_password', with: 'anymore'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません！'
      end
      it 'is possible for admin to register a new user' do
        visit new_session_path
        fill_in 'session_email', with: 'no@errors.com'
        fill_in 'session_password', with: 'nomore'
        click_on 'Log in'
        click_on 'ユーザー管理一覧に戻る'
        click_on 'ユーザーを新規登録する'
        fill_in 'user_name', with: 'a'
        fill_in 'user_email', with: 'a@a.a'
        fill_in 'user_password', with: 'aaaaaa'
        fill_in 'user_password_confirmation', with: 'aaaaaa'
        click_on '新規ユーザーを登録する'
        expect(page).to have_content 'ユーザーを新規登録しました。'
      end
      it "is possible for admin to check user's detail" do
        visit new_session_path
        fill_in 'session_email', with: 'no@errors.com'
        fill_in 'session_password', with: 'nomore'
        click_on 'Log in'
        click_on 'ユーザー管理一覧に戻る'
        click_on '詳細を確認する', match: :first
        expect(page).to have_content '管理者権限'
      end
      it "is possible for admin to edit user's info" do
        visit new_session_path
        fill_in 'session_email', with: 'no@errors.com'
        fill_in 'session_password', with: 'nomore'
        click_on 'Log in'
        click_on 'ユーザー管理一覧に戻る'
        click_on 'ユーザーを編集する', match: :first
        fill_in 'user_name', with: 'a'
        fill_in 'user_email', with: 'a@a.a'
        fill_in 'user_password', with: 'aaaaaa'
        fill_in 'user_password_confirmation', with: 'aaaaaa'
        click_on 'ユーザーを編集する'
        expect(page).to have_content 'ユーザーを編集しました。'
      end
      it "is possible for admin to delete user's page" do
        visit new_session_path
        fill_in 'session_email', with: 'no@errors.com'
        fill_in 'session_password', with: 'nomore'
        click_on 'Log in'
        click_on 'ユーザー管理一覧に戻る'
        click_on 'ユーザーを削除する', match: :first
        expect(page).to have_content 'ユーザーを削除しました。'
      end
    end
  end
end
