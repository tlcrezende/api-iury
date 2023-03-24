class RenameUserVencimentoToDiaVencimento < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :vencimento
    add_column :users, :dia_vencimento, :integer
  end
end
