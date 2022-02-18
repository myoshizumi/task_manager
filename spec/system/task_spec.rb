require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let! (:task){ FactoryBot.create(:task, name: 'task', expired_at: '02/19') }
  let! (:task_second){ FactoryBot.create(:task, name: 'task_second', expired_at: '02/17') }
  let! (:task_third){ FactoryBot.create(:task, name: 'task_third',expired_at: '02/15') }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: "Anything"
        fill_in 'task_detail', with: "NothingToDo"
        fill_in 'task[expired_at]', with: :expired_at
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
        click_on "終了期限でソートする"
        task_expired_at_list = all('.task_expired_at')
        expect(task_expired_at_list[0]).to have_content '02/19'
        expect(task_expired_at_list[1]).to have_content '02/17'
        expect(task_expired_at_list[2]).to have_content '02/15'
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