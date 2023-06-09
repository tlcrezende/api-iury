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

ActiveRecord::Schema[7.0].define(version: 2023_03_25_211448) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_graphql"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "pgjwt"
  enable_extension "pgsodium"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "aal_level", ["aal1", "aal2", "aal3"]
  create_enum "factor_status", ["unverified", "verified"]
  create_enum "factor_type", ["totp", "webauthn"]
  create_enum "key_status", ["default", "valid", "invalid", "expired"]
  create_enum "key_type", ["aead-ietf", "aead-det", "hmacsha512", "hmacsha256", "auth", "shorthash", "generichash", "kdf", "secretbox", "secretstream", "stream_xchacha20"]

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.json "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "configs", force: :cascade do |t|
    t.string "last_processed_transaction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "months", force: :cascade do |t|
    t.integer "mes_numero"
    t.string "mes"
    t.string "ano"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "pagamento_gerado", default: false
  end

  create_table "nubanks", force: :cascade do |t|
    t.bigint "pagamento_id", null: false
    t.string "status"
    t.datetime "data_pagamento"
    t.string "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pagamento_id"], name: "index_nubanks_on_pagamento_id"
  end

  create_table "pagamentos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "qrcode"
    t.integer "dia_vencimento"
    t.float "valor"
    t.bigint "month_id", null: false
    t.datetime "data_pagamento"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tipo"
    t.index ["month_id"], name: "index_pagamentos_on_month_id"
    t.index ["user_id"], name: "index_pagamentos_on_user_id"
  end

  create_table "turma_alunos", force: :cascade do |t|
    t.bigint "turma_id", null: false
    t.bigint "user_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["turma_id"], name: "index_turma_alunos_on_turma_id"
    t.index ["user_id"], name: "index_turma_alunos_on_user_id"
  end

  create_table "turmas", force: :cascade do |t|
    t.string "sede"
    t.string "dia"
    t.string "horario"
    t.string "professor"
    t.float "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.integer "desconto"
    t.json "tokens"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dia_vencimento"
    t.index ["telefone"], name: "index_users_on_telefone", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "nubanks", "pagamentos"
  add_foreign_key "pagamentos", "months"
  add_foreign_key "pagamentos", "users"
  add_foreign_key "turma_alunos", "turmas"
  add_foreign_key "turma_alunos", "users"
end
