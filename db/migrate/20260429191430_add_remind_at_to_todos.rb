class AddRemindAtToTodos < ActiveRecord::Migration[8.1]
  def change
    add_column :todos, :remind_at, :datetime
  end
end
