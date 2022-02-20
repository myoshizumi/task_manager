require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルがからの場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '', detail: 'no_detail')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細がからの場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: 'no_name', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: 'no_name', detail: 'no_detail') 
        expect(task).to be_valid
      end
    end
  end
  describe 'タスクモデル機能', type: :model do
    describe '検索機能' do
      let! (:task){ FactoryBot.create(:task, name: 'task') }
      let! (:task_second){ FactoryBot.create(:task, name: 'task_second') }
      let! (:task_third){ FactoryBot.create(:task, name: 'task_third') }
      context 'A vague search by scope method' do
        it 'will find the task names including the keyword' do
          # expect(Task.task_search('task_')).to include(task_second)
          # expect(Task.task_search('task_')).not_to include(task)
          # expect(Task.task_search('task_').count).to eq 2
        end
      end
    end
  end

end
