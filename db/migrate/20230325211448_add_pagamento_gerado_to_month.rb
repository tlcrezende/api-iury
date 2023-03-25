class AddPagamentoGeradoToMonth < ActiveRecord::Migration[7.0]
  def change
    add_column :months, :pagamento_gerado, :boolean, default: false
  end
end
