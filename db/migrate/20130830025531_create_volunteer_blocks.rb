class CreateVolunteerBlocks < ActiveRecord::Migration
  def change
    create_table :volunteer_blocks do |t|
      t.integer :user_id, null: false
      t.date :on, null: false
      t.integer :hours, null: false

      t.timestamps
    end
  end
end
