require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    describe '新規作成機能' do
      before do
        FactoryBot.create(:user, id: 2, email: "nomore@errors.com", password: "anymore")
      end
      context 'タスクを新規作成した場合' do
        it '作成したタスクが表示される' do
          visit new_session_path
          fill_in 'session_email', with: "nomore@errors.com"
          fill_in 'session_password', with: "anymore"
          click_on 'Log in'
          visit new_task_path
          fill_in 'task_name', with: "Anything"
          fill_in 'task_detail', with: "NothingToDo"
          fill_in 'task[expired_at]', with: '002020-10-06-10:10'
          sleep(1)
          select '完了'
          click_on 'commit'
          sleep(2)
          expect(page).to have_content 'Anything'
        end
      end
    end
    describe '一覧表示機能' do
      before do
        FactoryBot.create(:user, id: 2, email: "nomore@errors.com", password: "anymore")
      end
      context '一覧画面に遷移した場合' do
        it '作成済みのタスク一覧が表示される' do
          visit new_session_path
          fill_in 'session_email', with: "nomore@errors.com"
          fill_in 'session_password', with: "anymore"
          click_on 'Log in'
          visit new_task_path
          fill_in 'task_name', with: "Anything"
          fill_in 'task_detail', with: "NothingToDo"
          fill_in 'task[expired_at]', with: '002020-10-06-10:10'
          sleep(1)
          select '完了'
          click_on 'commit'
          visit tasks_path
          sleep(1)
          expect(page).to have_content "NothingToDo"
        end
      end
      context 'タスクが作成日時の降順に並んでいる場合' do
        it '新しいタスクが一番上に表示される' do
          visit new_session_path
          fill_in 'session_email', with: "nomore@errors.com"
          fill_in 'session_password', with: "anymore"
          click_on 'Log in'
          visit new_task_path
          fill_in 'task_name', with: "task_second"
          fill_in 'task_detail', with: "NothingToDo"
          fill_in 'task[expired_at]', with: '002020-10-06-10:10'
          sleep(1)
          select '完了'
          click_on 'commit'
          visit new_task_path
          fill_in 'task_name', with: "task_third"
          fill_in 'task_detail', with: "NothingToDo"
          fill_in 'task[expired_at]', with: '002020-10-06-10:10'
          sleep(1)
          select '完了'
          click_on 'commit'
          # binding.pry        
          visit tasks_path
          current_path
          task_name_list = all('.task_name')
          expect(task_name_list[0]).to have_content 'task_third'
          expect(task_name_list[1]).to have_content 'task_second'
        end
      end
      context 'Descending order of the column "expired_at"' do
        it 'will be the furthest deadline on the top' do
          visit new_session_path
          fill_in 'session_email', with: "nomore@errors.com"
          fill_in 'session_password', with: "anymore"
          click_on 'Log in'
          visit new_task_path
          fill_in 'task_name', with: "task_second"
          fill_in 'task_detail', with: "NothingToDo"
          fill_in 'task[expired_at]', with: '002020-10-11-10:10'
          sleep(1)
          select '完了'
          click_on 'commit'
          visit new_task_path
          fill_in 'task_name', with: "task_third"
          fill_in 'task_detail', with: "NothingToDo"
          fill_in 'task[expired_at]', with: '002020-10-06-10:10'
          sleep(1)
          select '完了'
          click_on 'commit'

          visit tasks_path
          click_on "終了期限"
          sleep(2)
          task_expired_at_list = all('.task_expired_at')
          expect(task_expired_at_list[0]).to have_content '10/11'
          expect(task_expired_at_list[1]).to have_content '10/06'
        end
      end
      context 'Descending order by the priority' do
        let!(:user_a) { FactoryBot.create(:user_a)}
        let!(:task) { FactoryBot.create(:task, user: user_a, name: 'task', expired_at: '02/19', status: "完了", priority: "低")}
        let!(:task_second) { FactoryBot.create(:task, user: user_a, name: 'task_second', expired_at: '02/17', status: "未着手", priority: "中")}
        let!(:task_third) { FactoryBot.create(:task, user: user_a, name: 'task_third',expired_at: '02/15', status: "着手", priority: "高")}
        it 'will be the high priority on the top' do
          visit new_session_path
          fill_in 'session_email', with: "a@a.a"
          fill_in 'session_password', with: "anymore"
          click_on 'Log in'

          visit tasks_path
          click_on "優先順位"
          sleep(2)
          

          task_priority_list = all('.task_priority')
          expect(task_priority_list[0]).to have_content '高'
          expect(task_priority_list[1]).to have_content '中'
          expect(task_priority_list[2]).to have_content '低'
        end
      end
    end
    describe '詳細表示機能' do
      let!(:user_a) { FactoryBot.create(:user_a)}
      let!(:task) { FactoryBot.create(:task, user: user_a, name: 'task', expired_at: '02/19', status: "完了", priority: "低")}
      let!(:task_second) { FactoryBot.create(:task, user: user_a, name: 'task_second', expired_at: '02/17', status: "未着手", priority: "中")}
      let!(:task_third) { FactoryBot.create(:task, user: user_a, name: 'task_third',expired_at: '02/15', status: "着手", priority: "高")}
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          visit new_session_path
          fill_in 'session_email', with: "a@a.a"
          fill_in 'session_password', with: "anymore"
          click_on 'Log in'
          visit tasks_path
          click_on '詳細を確認する', match: :first
          expect(page).to have_content 'タスク詳細'
          sleep(2)
        end
      end
    end
    describe 'Manage funciton for task', type: :system do
      let!(:user_a) { FactoryBot.create(:user_a)}
      let!(:task) { FactoryBot.create(:task, user: user_a, name: 'task', expired_at: '02/19', status: "完了", priority: "低")}
      let!(:task_second) { FactoryBot.create(:task, user: user_a, name: 'task_second', expired_at: '02/17', status: "未着手", priority: "中")}
      let!(:task_third) { FactoryBot.create(:task, user: user_a, name: 'task_third',expired_at: '02/15', status: "着手", priority: "高")}
      describe 'search system' do
        context 'search with vague letters for name field' do
          it 'will find specific names by the keywords' do
            visit new_session_path
            fill_in 'session_email', with: "a@a.a"
            fill_in 'session_password', with: "anymore"
            click_on 'Log in'
            visit tasks_path
            fill_in "task[search]", with: "sec"
            click_on "検索する"
            sleep(1)
            expect(page).to have_content "task_second"
           
          end
        end
        context 'search by the status' do
          it 'will find tasks by the status' do
            visit new_session_path
            fill_in 'session_email', with: "a@a.a"
            fill_in 'session_password', with: "anymore"
            click_on 'Log in'
            visit tasks_path
            select "未着手"
            click_on "検索する"
            sleep(1)
            expect(page).to have_content "second"
          end
        end
        context 'search with vague letters and the status' do
          it 'will find the tasks including the search letter and the status' do
            visit new_session_path
            fill_in 'session_email', with: "a@a.a"
            fill_in 'session_password', with: "anymore"
            click_on 'Log in'
            visit tasks_path
            fill_in "task[search]", with: "task"
            select "完了"
            click_on "検索する"
            expect(page).to have_content "task"
          end
        end
      end
    end
end