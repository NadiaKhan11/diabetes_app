class CreatePages < ActiveRecord::Migration[5.2]
  def change
   create_table :records do |t|
      t.float :sugar_levels
      t.string :date 
      t.integer :user_id
    end

    create_table :reminders do |t|
      t.integer :time_of_day
      t.integer :user_id
    end

    create_table :users do |t|
      t.string :name
      t.integer :phone_number
    end

  end
end
