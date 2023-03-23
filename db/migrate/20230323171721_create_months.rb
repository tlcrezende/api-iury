class CreateMonths < ActiveRecord::Migration[7.0]
  def change
    create_table :months do |t|
      t.integer :mes_numero
      t.string :mes
      t.string :ano

      t.timestamps
    end
  end
end
