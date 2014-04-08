class CreateLightsAndTimers < ActiveRecord::Migration
  def change

    create_table :lights do |t|
      t.integer :light_id
      t.string :name
    end

    add_index :lights, :light_id

    create_table :timers do |t|
      t.string :name, null: false
      t.string :at, null: false
      t.integer :frequency, null: false, default: 86400 # 1.day
      t.integer :bri, null: false
      t.integer :hue, null: false
      t.integer :sat, null: false
      t.boolean :active, null: false, default: true
    end

    add_index :timers, :name, unique: true

    create_join_table :lights, :timers
  end
end
