class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[7.0]
  def change
    
    create_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :name
      t.string :apelido
      t.string :email
      t.datetime :data_nascimento
      t.string :telefone, :null => false
      t.string :perfil, :default => "aluno"
      t.string :tipo_sanguineo
      t.string :tamanho_pe
      t.string :tamanho_camisa
      t.string :contato_emergencia_nome
      t.string :contato_emergencia_telefone
      t.string :responsavel_nome
      t.string :responsavel_telefone
      t.string :responsavel_parentesco
      t.string :endereco
      t.string :cep
      t.string :foto_id
      t.datetime :data_inicio
      t.string :alergias
      t.string :expo_push_token
      t.integer :vencimento
      t.integer :desconto

      ## Tokens
      t.json :tokens

      ## Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at 
      t.datetime :last_sign_in_at 

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
