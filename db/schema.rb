# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_22_204343) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "telefone", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.string "name"
    t.string "apelido"
    t.string "email"
    t.datetime "data_nascimento"
    t.string "telefone", null: false
    t.string "perfil", default: "aluno"
    t.string "tipo_sanguineo"
    t.string "tamanho_pe"
    t.string "tamanho_camisa"
    t.string "contato_emergencia_nome"
    t.string "contato_emergencia_telefone"
    t.string "responsavel_nome"
    t.string "responsavel_telefone"
    t.string "responsavel_parentesco"
    t.string "endereco"
    t.string "cep"
    t.string "foto_id"
    t.datetime "data_inicio"
    t.string "alergias"
    t.string "expo_push_token"
    t.integer "vencimento"
    t.integer "desconto"
    t.json "tokens"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["telefone"], name: "index_users_on_telefone", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
