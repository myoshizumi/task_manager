require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let! (:task){ FactoryBot.create(:task, name: 'task', expired_at: '02/19', status: "完了", priority: "低") }
  let! (:task_second){ FactoryBot.create(:task, name: 'task_second', expired_at: '02/17', status: "未着手", priority: "中") }
  let! (:task_third){ FactoryBot.create(:task, name: 'task_third',expired_at: '02/15', status: "", priority: "高") }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: "Anything"
        fill_in 'task_detail', with: "NothingToDo"
        fill_in 'task[expired_at]', with: '002020-10-06-10:10'
        sleep(3)
        select '完了'
        click_on 'commit'
        expect(page).to have_content 'task'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        current_path
        Task.count
        page.html
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        current_path
        task_name_list = all('.task_name')
        expect(task_name_list[0]).to have_content 'task_third'
        expect(task_name_list[1]).to have_content 'task_second'
        expect(task_name_list[2]).to have_content 'task'
      end
    end
    context 'Descending order of the column "expired_at"' do
      it 'will be the furthest deadline on the top' do
        visit tasks_path
        current_path
        click_on "終了期限"
        sleep(2)
        task_expired_at_list = all('.task_expired_at')
        expect(task_expired_at_list[0]).to have_content '02/19'
        expect(task_expired_at_list[1]).to have_content '02/17'
        expect(task_expired_at_list[2]).to have_content '02/15'
      end
    end
    context 'Descending order by the priority' do
      it 'will be the high priority on the top' do
        visit tasks_path
        current_path
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
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit task_path(task.id)
        current_path
        Task.count
        page.html
        expect(page).to have_content 'task'
       end
     end
  end
  describe 'Manage funciton for task', type: :system do
    describe 'search system' do
      before do
        # FactoryBot.create(:task, title: "task")
        # FactoryBot.create
        FactoryBot.create(:task, name: 'task', status: "完了")
        FactoryBot.create(:task, name: 'task_second', status: "未着手")
        FactoryBot.create(:task, name: 'task_third', status: "")
      end
      context 'search with vague letters for name field' do
        it 'will find specific names by the keywords' do
          visit tasks_path
          fill_in "task[search]", with: "ask"
          click_on "検索する"
          expect(page).to have_content "task"
        end
      end
      context 'search by the status' do
        it 'will find tasks by the status' do
          visit tasks_path
          select "未着手"
          click_on "検索する"
          expect(page).to have_content "second"
        end
      end
      context 'search with vague letters and the status' do
        it 'will find the tasks including the search letter and the status' do
          visit tasks_path
          fill_in "task[search]", with: "task"
          select "完了"
          click_on "検索する"
          # binding.pry
          expect(page).to have_content "task"
        end
      end
    end
  end
      
end