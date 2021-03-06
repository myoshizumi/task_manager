# frozen_string_literal: true

class AddTimestampToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :created_at, :datetime
    add_column :tasks, :updated_at, :datetime
  end
end
