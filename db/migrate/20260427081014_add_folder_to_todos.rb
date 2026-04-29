class AddFolderToTodos < ActiveRecord::Migration[8.1]
  def change
    add_column :todos, :folder, :string
  end
end
