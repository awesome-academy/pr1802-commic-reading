class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.integer :rate
      t.references :user, forgein_key: true
      t.references :comic, forgein_key: true

      t.timestamps
    end
  end
end
