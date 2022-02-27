require 'rails_helper'

RSpec.describe 'Label Function', type: :system do
  describe 'Labelling system' do
    let!(:user_a) { FactoryBot.create(:user_a)}
    let!(:task) { FactoryBot.create(:task, user: user_a, name: 'task', expired_at: '02/19', status: "完了", priority: "低")}
    let!(:label) {FactoryBot.create(:label)}
    let!(:label_second) {FactoryBot.create(:label_second)}
    context 'User can check(add) label when they register their task' do
      it 'will contain the label name in the Task index' do
        visit new_session_path
        fill_in 'session_email', with: "a@a.a"
        fill_in 'session_password', with: "anymore"
        click_on 'Log in'
        visit new_task_path
        fill_in 'task_name', with: "Anything"
        fill_in 'task_detail', with: "NothingToDo"
        fill_in 'task[expired_at]', with: '002020-10-06-10:10'
        check 'private'
        sleep(1)
        select '完了'
        click_on 'commit'
        sleep(1)
        expect(page).to have_content 'private'
      end
    end
    context 'User can check(add) label when they edit their task' do
      it 'will contain multiple label names in the Task index' do
        visit new_session_path
        fill_in 'session_email', with: "a@a.a"
        fill_in 'session_password', with: "anymore"
        click_on 'Log in'
        visit new_task_path
        fill_in 'task_name', with: "Anything"
        fill_in 'task_detail', with: "NothingToDo"
        fill_in 'task[expired_at]', with: '002020-10-06-10:10'
        check 'private'
        sleep(1)
        select '完了'
        click_on 'commit'
        sleep(1)
        click_on 'タスクを編集する', match: :first
        page.accept_confirm do
          'タスクを編集する'
        end
        # page.driver.browser.switch_to.alert.accept
        fill_in 'task_name', with: "Anything"
        fill_in 'task_detail', with: "NothingToDo"
        fill_in 'task[expired_at]', with: '002020-10-06-10:10'
        check 'family'
        sleep(1)
        select '完了'
        click_on 'commit'
        expect(page).to have_content 'family'
      end
    end
    context 'User can check(add) label when they edit their task' do
      it 'will contain multiple label names in the Task index' do
        visit new_session_path
        fill_in 'session_email', with: "a@a.a"
        fill_in 'session_password', with: "anymore"
        click_on 'Log in'
        visit new_task_path
        fill_in 'task_name', with: "Anything"
        fill_in 'task_detail', with: "NothingToDo"
        fill_in 'task[expired_at]', with: '002020-10-06-10:10'
        check 'private'
        sleep(1)
        select '完了'
        click_on 'commit'
        sleep(1)
        click_on 'タスクを編集する', match: :first
        page.accept_confirm do
          'タスクを編集する'
        end
        fill_in 'task_name', with: "Anything"
        fill_in 'task_detail', with: "NothingToDo"
        fill_in 'task[expired_at]', with: '002020-10-06-10:10'
        check 'family'
        sleep(1)
        select '完了'
        click_on 'commit'
        select "family"
        click_on "検索する"
        sleep(1)
        expect(page).to have_content 'family'
      end
    end
  end
end