class CreateNubanks < ActiveRecord::Migration[7.0]
  def change
    create_table :nubanks do |t|
      t.references :pagamento, null: false, foreign_key: true
      t.string :status
      t.datetime :data_pagamento
      t.string :transaction_id

      t.timestamps
    end
  end
end
