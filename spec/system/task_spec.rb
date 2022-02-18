require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let! (:task){ FactoryBot.create(:task, name: 'task') }
  let! (:task_second){ FactoryBot.create(:task, name: 'task_second') }
  let! (:task_third){ FactoryBot.create(:task, name: 'task_third') }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: "Anything"
        fill_in 'task_detail', with: "NothingToDo"
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
        task_list = all('.task_name')
        expect(task_list[0]).to have_content 'task_third'
        expect(task_list[1]).to have_content 'task_second'
        expect(task_list[2]).to have_content 'task'
        # expect(task_list).to be {Task.all.order(updated_at: :asc)}
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
end