require 'rails_helper'

RSpec.describe Task, type: :model do
  
  describe 'バリデーションのテスト' do
    before do
      FactoryBot.create(:user, id:1, name: "a", email: "s@s.s", password:"aaaaaa")
      FactoryBot.create(:task, id:1, user: user)
    end
    context 'タスクのタイトルが空の場合' do
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
        task = Task.new(name: 'no_name', detail: 'no_detail', expired_at: '01/01 11:11', user_id: 1) 
        expect(task).to be_valid
      end
    end
  end
  describe 'タスクモデル機能', type: :model do
    describe '検索機能' do
      let! (:task){ FactoryBot.create(:task, name: 'task', status: '未着手') }
      let! (:task_second){ FactoryBot.create(:task, name: 'task_second', status: '着手') }
      let! (:task_third){ FactoryBot.create(:task, name: 'task_third', status: '完了') }
      context 'A vague search by scope method' do
        it 'will find the task names including the keyword' do
          expect(Task.task_search('task_')).to include(task_second)
          expect(Task.task_search('task_')).not_to include(task)
          expect(Task.task_search('task_').count).to eq 2
        end
      end
      context 'The status search by scope method' do
        it 'will find the tasks with matched status' do
          expect(Task.task_status('完了')).to include(task_third)
          expect(Task.task_status('着手')).not_to include(task_third)
          expect(Task.task_status('未着手').count).to eq 1
        end
      end
      context 'The status search & a vague search by scope method' do
        it 'will find the tasks with matched status' do
          expect(Task.task_status('完了')).to include(task_third)
          expect(Task.task_search('task')).to include(task_third)
          expect(Task.task_status('完了').count).to eq 1
          expect(Task.task_search('task').count).to eq 3
        end
      end
    end
  end
end
