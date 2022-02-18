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
end
