class CreateTodoItems < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_items do |t|
      t.references :td_list, foreign_key: true
      t.string :name
      t.boolean :is_done

      t.timestamps
    end
  end
end
