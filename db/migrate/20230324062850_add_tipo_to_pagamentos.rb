class AddTipoToPagamentos < ActiveRecord::Migration[7.0]
  def change
    add_column :pagamentos, :tipo, :integer
  end
end
