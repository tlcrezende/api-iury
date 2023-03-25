class RemoveTurmaIdFromPagamentos < ActiveRecord::Migration[7.0]
  def change
    remove_column :pagamentos, :turma_id
  end
end
