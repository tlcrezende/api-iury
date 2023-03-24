class CreateConfiguracos < ActiveRecord::Migration[7.0]
  def change
    create_table :configuracos do |t|
      t.string :last_processed_transaction

      t.timestamps
    end
  end
end
