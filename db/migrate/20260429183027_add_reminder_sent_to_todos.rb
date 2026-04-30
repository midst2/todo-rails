class AddReminderSentToTodos < ActiveRecord::Migration[8.1]
  def change
    add_column :todos, :reminder_sent, :boolean, default: false
  end
end
