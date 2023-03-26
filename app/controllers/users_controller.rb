class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  # before_action :authenticate_user!, except: :create

  def index
    @users = User.all.includes(%i[turmas turma_alunos])
    # @users = User.left_joins(:turma_aluno).where(perfil: 'aluno').group('users.id').select(
    #   'users.*',
    #   "array_agg(json_build_object(
    #     ''
    #   ))")
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.create!(params.permit(:telefone, :apelido, :responsavel_nome, :responsavel_telefone, :data_inicio,
                                       :dia_vencimento))
    @user.password = Time.zone.now
    @user.save
    render json: { aluno_id: @user.id }

    # render json: @user, status: :created if @user.save
    # render json: @user.errors, status: :unprocessable_entity unless @user.save
  end

  def firebase
    private_key_json_string = {
      type: 'service_account',
      project_id: 'ctis-91c72',
      private_key_id: '08399464acc2febc5c109e64574499d34fb8516b',
      private_key: "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDEKbi1chy3ie5u\nWxoBqq7OCS38lOBs21ju+LzE8i5hu+giQK7VUOPCGrxk7+RI8ml0ywsqz+lxcweU\nEesDTTyEsaGT5LPaLwuP3jC9p2+g3o1+iAkfb6zq5shbzNvnvDuaoBh8NH99ES6W\nztLpJDytGNutV8GcyrdU9ZK2SAezRGLU+G5MbrKn88D6yZ2Zg/ErofstFytA71ei\niFurjcZZfwn83EYrt/hVefzgpZPd1Sp7r6H60q6iWyuZVo/eeG16h5fdzPzhystS\nZ3FtFDWERCnJvY8qgEqysGQkyr0wSc2wa1oHMcUyxjCqq1aCS8b1j9bK9LTsvhyR\nFvxEisfVAgMBAAECggEAHg+TY0GZU1UbXqUDtMAD1BuFr8CJgz+6qWXL2Ss7NAtY\nP7Da5Ldl18/su/55OjvlMO/msQkLP1v/Ns/ndxTl0niS3XeoSiYjJvPH/gsD08rB\n3eNEm/aAsL9sx936eyZA72lbpzkM/80GGeKYYVWwyLQCV4DscOCDPM1PTjN2nqAg\nfKOZQI5yhwMXWW7rwfvwF74RCFnwzE8Lm70DiHqBOxDD0vf/knc18Awjmkqtv4NO\nTjmlGgTcMqh+tli5+yEMyCcl9goRQBJ58Avi9etLcjAgTSL4DKV3zTCQiV/9BGpD\n8mG08IW8f441vcfw8dhPvlELP5NLleWHp/4L4gwBNwKBgQD+x9kp4aPeEtgWsYWS\n91B7xWeP8mIcwosc4nPC8FPOFkqiMHfQcBh7lTgnMHeHMz0CLWcCFgzuUfhVYaXb\nPSBQP91OW2B0jCUaGTaOp3KwDSis91Gz68w9EwCMZfjCCnZZu5WuMkWnZ53goDhD\nuFt3GiE74bWOIOKlo77KqvPeGwKBgQDFGg5drZIo6a0vyySdtGMqVL4FU6d0M2mb\nEdYfTTTe5fD3UE/Q9DQZvLU2E3byDeFzMczHCa29B5LFDMIaRnI48Kk9OQd0BQ4P\nijphcwheSaGlU8sCjleQbyyk9UqqgiopHTTz+alg/Y3oea3Hj4Wc6PoVppkJro/n\nBvYEn/GQzwKBgHCOp9EJ31QnrRFxgdpoqkTT9Cmy4kdkZwLuxEeV1uBQFs7KbNRI\nAXjvdmxRzCyNpWFF36EbTsEms3g8+IH/4juxyzpnwhgbJfT+uIyTS2admZ+4b372\nKDe/IlnkXt6SsrB33+uiSAVqEGSBQ/ofA0F96LrEv2m3+4lD6vEsTyqLAoGAJoB6\nge4f+QH8pLNoCa5tGJ3JKL04nshUPshzLVYll80PDyCPFuA9NTHZrCCNQadYfOoj\neFX5rE1IbFmbqQpN0bWhOaZkQFOkdYCo+tQ/tDtp6iO+Klen3zz4WZjY5wnaNoHQ\nEECax6mACQOL4Mm2bfpMr+IFTxDcZ2LCuBCOXZ0CgYANso56Tte3o1LbaveVl4+U\nVyUbZFKmLXM31bWquIU/iIqUV694wbefwMFGsxitGABGCB/7C9gY+iDxVVDlzV7g\ngi+/544JlL6DMY3iUjee5/Eq1QhUixrg09nbyrVUwFTtl4tHQiguYB+z1BqLZHfL\ndBRzk9oQCy5LldFJw241gw==\n-----END PRIVATE KEY-----\n",
      client_email: 'firebase-adminsdk-t4kk7@ctis-91c72.iam.gserviceaccount.com',
      client_id: '113178703219604844153',
      auth_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_uri: 'https://oauth2.googleapis.com/token',
      auth_provider_x509_cert_url: 'https://www.googleapis.com/oauth2/v1/certs',
      client_x509_cert_url: 'https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-t4kk7%40ctis-91c72.iam.gserviceaccount.com'
    }

    base_uri = 'https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-t4kk7%40ctis-91c72.iam.gserviceaccount.com'
    firebase = Firebase::Client.new(base_uri, private_key_json_string.to_json)

    # ref = firebase.database

    # firebase.push('todos', {
    #                 name: 'Pick the milk',
    #                 created: Firebase::ServerValue::TIMESTAMP
    #               })

    teste = firebase.get('telefones')

    p teste.body

    byebug
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  # ALUNO
  def aluno_info
    render json: current_user
  end

  def aluno_update
    if current_user.update(user_params)
      render json: current_user
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :data_nascimento, :email, :tipo_sanguineo, :tamanho_camisa, :tamanho_pe, :desconto, :apelido,
                  :contato_emergencia_nome, :contato_emergencia_telefone, :responsavel_nome, :responsavel_parentesco,
                  :responsavel_telefone, :endereco, :cep, :foto_id, :data_inicio, :alergias, :expo_push_token, :dia_vencimento)
  end
end
