class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :bin
      t.integer :last_four
      t.string :brand
      t.string :schema
      t.string :name
      t.date :expires_at
      t.string :status
      t.date :expiration_month
      t.date :expiration_year

      t.timestamps
    end
  end
end
