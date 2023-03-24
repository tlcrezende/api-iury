require "rails_helper"

RSpec.describe NubanksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/nubanks").to route_to("nubanks#index")
    end

    it "routes to #show" do
      expect(get: "/nubanks/1").to route_to("nubanks#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/nubanks").to route_to("nubanks#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/nubanks/1").to route_to("nubanks#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/nubanks/1").to route_to("nubanks#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/nubanks/1").to route_to("nubanks#destroy", id: "1")
    end
  end
end
