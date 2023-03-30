require 'rails_helper'

RSpec.describe "Estatisticas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/estatistica/index"
      expect(response).to have_http_status(:success)
    end
  end

end
