require "rails_helper"

RSpec.describe MissionsController do
  describe "GET index" do
    let(:user) { create(:user) }

    before { sign_in user }

    it "asign @missions" do
      mission1 = create(:mission, user: user) 
      mission2 = create(:mission, user: user)

      get :index

      expect(assigns(:missions)).to eq([mission1, mission2]) 
    end

    it "render template" do
      mission1 = create(:mission, user: user) 
      mission2 = create(:mission, user: user)

      get :index

      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    let(:user) { create(:user) }
    let(:mission) { create(:mission, user: user) }
    
    before do
      sign_in user
      get :show, params: { id: mission.id }
    end

    it "assigns @mission" do
      expect(assigns(:mission)).to eq(mission)
    end

    it "render template" do
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    let(:user) { create(:user) } 
    let(:mission) { build(:mission, user: user) } 
  
    context "when user login" do
      before do
        sign_in user
        get :new
      end

      it "assign @mission" do
        expect(assigns(:mission)).to be_a_new(Mission)
      end
  
      it "render template" do
        expect(response).to render_template("new")
      end
    end

    context "when user logout" do
      it "redirect_to new_user_session_path" do
        get :new
  
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST create" do
    let(:user) { create(:user) } 
    let(:mission) { build(:mission, user: user) }
    before { sign_in user }

    context "when mission has title" do
      it "create a new mission record" do
        expect do
          post :create, params: { mission: attributes_for(:mission) }
          # 帶入所有必要參數
        end.to change{ Mission.count }.by(1)
        # 不好對內容，改對數量變化
      end
  
      it "redirects to mission_path" do
        post :create, params: { mission: attributes_for(:mission) }
        expect(response).to redirect_to missions_path
      end

      it "creates a mission for user" do
        post :create, params: { mission: attributes_for(:mission) }
  
        expect(Mission.last.user).to eq(user)
      end
    end

    context "when mission doesn't have title" do
      it "can't create a new mission record" do
        expect do 
          post :create, params: { mission: { content: 'do your homework' }}
        end.to change { Mission.count }.by(0)
      end

      it "render new template" do
        post :create, params: { mission: { content: 'do your homework' }}

        expect(response).to render_template("new")
      end
    end
  end

  describe "GET edit" do
    let(:author) { create(:user) }
    let(:not_author) { create(:user) }
    let(:mission) { create(:mission, user: author) } 

    context "signed in as author" do
      before do
        sign_in author
        get :edit, params: { id: mission.id }
      end

      it "assign mission" do
        expect(assigns[:mission]).to eq(mission)
      end
  
      it "render template" do
        expect(response).to render_template("edit")
      end
    end

    context "signed in not as author" do
      before { sign_in not_author }

      it "raise an error" do
        expect do
          get :edit, params: { id: mission.id }
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end

  describe "PUT update" do
    let(:author) { create(:user) }
    let(:not_author) { create(:user) }
    let(:mission) { create(:mission, user: author) } 

    context "signed in as author" do
      before { sign_in author }

      context "when mission have a title" do
        before do
          put :update, params: { id: mission.id,  mission: { title: "Eat lunch", content: "I want to eat lunch." }}
        end
  
        it "assign @mission" do
          expect(assigns[:mission]).to eq(mission)
        end
    
        it "changes value" do
          expect(assigns[:mission].title).to eq("Eat lunch")
          expect(assigns[:mission].content).to eq("I want to eat lunch.")
        end
    
        it "redirects to mission_path" do
          expect(response).to redirect_to missions_path(mission)
        end
      end
  
      context "when mission have no title" do
        before do
          put :update, params: { id: mission.id,  mission: { title: "",content: "I want to eat lunch." }}
        end
  
        it "assign @mission" do
          expect(assigns[:mission]).to eq(mission)
        end
    
        it "changes value" do
          expect(mission.content).not_to eq("I want to eat lunch.")
        end
    
        it "redirects to mission_path" do
          expect(response).to render_template("edit")
        end
      end
    end

    context "signed in not as author" do
      before { sign_in not_author }

      it "raises an error" do
        expect do
          put :update, params: { id: mission.id,  mission: { title: "",content: "I want to eat lunch." }}
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE destroy" do
    let(:author) { create(:user) }
    let(:not_author) { create(:user) }
    let(:mission) { create(:mission, user: author) } 

    context "when sign in as author" do
      before { sign_in author }

      it "assigns @mission" do
        delete :destroy, params: { id: mission.id }
  
        expect(assigns[:mission]).to eq(mission)
      end
  
      it "deletes a record" do
        mission = create(:mission, user: author)
  
        expect do
          delete :destroy, params: { id: mission.id }
        end.to change { Mission.count }.by(-1)
      end
  
      it "redirects to mission_path" do
        delete :destroy, params: { id: mission.id }
  
        expect(response).to redirect_to missions_path
      end
    end

    context "when sign in not as author" do
      before { sign_in not_author }

      it "raises an error" do
        expect do
          delete :destroy, params: { id: mission.id }
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end 
