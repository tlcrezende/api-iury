class CreatePagamentos < ActiveRecord::Migration[7.0]
  def change
    create_table :pagamentos do |t|
      t.references :turma, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :qrcode
      t.integer :dia_vencimento
      t.float :valor
      t.references :month, null: false, foreign_key: true
      t.datetime :data_pagamento
      t.string :status

      t.timestamps
    end
  end
end
