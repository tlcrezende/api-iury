class RenameConfiguracoToConfiguracao < ActiveRecord::Migration[7.0]
  def change
    rename_table :configuracos, :configs
  end
end
