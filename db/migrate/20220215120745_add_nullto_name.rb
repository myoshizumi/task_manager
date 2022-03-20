# frozen_string_literal: true

class AddNulltoName < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:tasks, :name, false)
  end
end
