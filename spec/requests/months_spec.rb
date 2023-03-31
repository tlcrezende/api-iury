require 'rails_helper'

RSpec.describe "Months", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/months/index"
      expect(response).to have_http_status(:success)
    end
  end

end
