class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :project_id
      t.string :status
      t.integer :priority
      t.datetime :deadline

      t.timestamps
    end
    add_index :tasks, [:project_id, :created_at, :priority]
  end
end
