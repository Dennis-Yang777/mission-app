require "rails_helper"

RSpec.describe MissionsController do
  describe "GET index" do
    it "asign @missions" do
      mission1 = create(:mission) 
      mission2 = create(:mission)

      get :index

      expect(assigns(:missions)).to eq([mission1, mission2]) 
    end

    it "render template" do
      mission1 = create(:mission) 
      mission2 = create(:mission)

      get :index

      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @mission" do
      mission = create(:mission)

      get :show, params: { id: mission.id }

      expect(assigns(:mission)).to eq(mission)
    end

    it "render template" do
      mission = create(:mission)

      get :show, params: { id: mission.id }

      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "assign @mission" do
      mission = build(:mission)

      get :new

      expect(assigns(:mission)).to be_a_new(Mission)
    end

    it "render template" do
      mission = build(:mission)

      get :new

      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "success" do
      it "create a new mission record" do
        mission = build(:mission)
  
        expect do
          post :create, params: { mission: attributes_for(:mission) }
        end.to change{ Mission.count }.by(1)
      end
  
      it "redirects to mission_path" do
        mission = build(:mission)
  
        post :create, params: { mission: attributes_for(:mission) }
        expect(response).to redirect_to missions_path
      end
    end

    context 'fails' do
      it "can't create a record when mission doesn't have a title" do
        expect do 
          post :create, params: { mission: { content: 'do your homework' }}
        end.to change { Mission.count }.by(0)
      end

      it "render new template when mission doesn't have title" do
        post :create, params: { mission: { content: 'do your homework' }}

        expect(response).to render_template("new")
      end
    end

  end
  
end 
