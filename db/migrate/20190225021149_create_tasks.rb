class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string     :name, null: false
      t.text       :description
      t.references :user, null: false
      t.integer    :state, default: 0
      t.string     :attachment

      t.timestamps
    end
  end
end
