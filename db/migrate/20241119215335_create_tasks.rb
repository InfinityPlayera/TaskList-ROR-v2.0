class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :completed
      t.integer :position

      t.timestamps
    end
  end
end
