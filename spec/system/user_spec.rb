# require 'rails_helper'
# RSpec.describe 'タスク管理機能', type: :system do
#   let! (:task){ FactoryBot.create(:task, name: 'task', expired_at: '02/19', status: "完了", priority: "低") }
#   let! (:task_second){ FactoryBot.create(:task, name: 'task_second', expired_at: '02/17', status: "未着手", priority: "中") }
#   let! (:task_third){ FactoryBot.create(:task, name: 'task_third',expired_at: '02/15', status: "着手", priority: "高") }
#   before do
#     visit tasks_path
#   end
#   describe '新規作成機能' do
#     context 'タスクを新規作成した場合' do
#       it '作成したタスクが表示される' do
#         visit new_task_path
#         fill_in 'task_name', with: "Anything"
#         fill_in 'task_detail', with: "NothingToDo"
#         fill_in 'task[expired_at]', with: '002020-10-06-10:10'
#         sleep(1)
#         select '完了'
#         click_on 'commit'
#         expect(page).to have_content 'task'
#       end
#     end
#   end
#   describe '一覧表示機能' do
#     context '一覧画面に遷移した場合' do
#       it '作成済みのタスク一覧が表示される' do
#         visit tasks_path
#         current_path
#         Task.count
#         page.html
#         expect(page).to have_content 'task'
#       end
#     end
        