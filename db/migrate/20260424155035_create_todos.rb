class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.string :content
      t.boolean :status, default: 0
      t.integer :priority
      t.integer :created_by

      t.timestamps
    end
  end
end
