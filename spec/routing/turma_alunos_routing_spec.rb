require "rails_helper"

RSpec.describe TurmaAlunosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/turma_alunos").to route_to("turma_alunos#index")
    end

    it "routes to #show" do
      expect(get: "/turma_alunos/1").to route_to("turma_alunos#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/turma_alunos").to route_to("turma_alunos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/turma_alunos/1").to route_to("turma_alunos#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/turma_alunos/1").to route_to("turma_alunos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/turma_alunos/1").to route_to("turma_alunos#destroy", id: "1")
    end
  end
end
