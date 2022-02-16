require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:second_task)
  # end
  # background do
    # FactoryBot.create(:task, name: '付け加えた名前１')
    # FactoryBot.create(:task, name: '付け加えた名前２')
    # FactoryBot.create(:second_task, name: '付け加えた名前3', detail: '付け加えた詳細')
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # task = FactoryBot.create(:task, title: 'task')
        # visit tasks_path
        # binding.irb
        # current_path
        # Task.count
        # page.html
        # expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do

       end
     end
  end
end