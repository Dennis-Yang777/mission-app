require "rails_helper"

RSpec.describe MissionsController do
  describe "GET index" do
    it "asign @missions" do
      mission1 = create(:mission) 
      mission2 = create(:mission)
      # 有做設定，不用加主詞(support裡面)
      get :index

      expect(assigns(:missions)).to eq([mission1, mission2]) 
      # 回傳的物件(assigns)
    end

    it "render template" do
      mission1 = create(:mission) 
      mission2 = create(:mission)

      get :index

      expect(response).to render_template("index")
      # 回應(response)、渲染畫面(render_template)
    end
  end

  describe "GET show" do
    it "assigns @mission" do
      mission = create(:mission)

      get :show, params: { id: mission.id }
      # 使用動詞加上要去的action，以及要帶入的params
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
      # 要處於正在建立狀態
      get :new

      expect(assigns(:mission)).to be_a_new(Mission)
      # 一個新實體be_a_new(Model)
    end

    it "render template" do
      mission = build(:mission)

      get :new

      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "when mission have a title" do
      it "create a new mission record" do
        mission = build(:mission)
  
        expect do
          post :create, params: { mission: attributes_for(:mission) }
          # 帶入所有必要參數
        end.to change{ Mission.count }.by(1)
        # 不好對內容，改對數量變化
      end
  
      it "redirects to mission_path" do
        mission = build(:mission)
  
        post :create, params: { mission: attributes_for(:mission) }
        expect(response).to redirect_to missions_path
        # 轉址(redirect_to)
      end
    end

    context "when mission doesn't have a title" do
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
    it "assign mission" do
      mission = create(:mission)

      get :edit, params: { id: mission.id }

      expect(assigns[:mission]).to eq(mission)
    end

    it "render template" do
      mission = create(:mission)

      get :edit, params: { id: mission.id }

      expect(response).to render_template("edit")
    end
  end

  describe "PUT update" do
    context "when mission have a title" do
      it "assign @mission" do
        mission = create(:mission)
  
        put :update, params: { id: mission.id,  mission: { title: "Eat lunch", content: "I want to eat lunch." }}
  
        expect(assigns[:mission]).to eq(mission)
      end
  
      it "changes value" do
        mission = create(:mission)
  
        put :update, params: { id: mission.id,  mission: { title: "Eat lunch", content: "I want to eat lunch." }}
  
        expect(assigns[:mission].title).to eq("Eat lunch")
        expect(assigns[:mission].content).to eq("I want to eat lunch.")
      end
  
      it "redirects to mission_path" do
        mission = create(:mission)
  
        put :update, params: { id: mission.id,  mission: { title: "Eat lunch", content: "I want to eat lunch." }}
  
        expect(response).to redirect_to missions_path(mission)
      end
    end

    context "when mission have no title" do
      it "assign @mission" do
        mission = create(:mission)
        
        put :update, params: { id: mission.id,  mission: { title: "",content: "I want to eat lunch." }}

        expect(assigns[:mission]).to eq(mission)
      end
  
      it "changes value" do
        mission = create(:mission)
  
        put :update, params: { id: mission.id,  mission: { title: "",content: "I want to eat lunch." }}

        expect(mission.content).not_to eq("I want to eat lunch.")
        # 不等於(not_to)
      end
  
      it "redirects to mission_path" do
        mission = create(:mission)
  
        put :update, params: { id: mission.id,  mission: { title: "",content: "I want to eat lunch." }}
  
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "assigns @mission" do
      mission = create(:mission)

      delete :destroy, params: { id: mission.id }

      expect(assigns[:mission]).to eq(mission)
    end

    it "deletes a record" do
      mission = create(:mission)

      expect { delete :destroy, params: { id: mission.id }}.to change { Mission.count }.by(-1)
    end

    it "redirects to mission_path" do
      mission = create(:mission)

      delete :destroy, params: { id: mission.id }

      expect(response).to redirect_to missions_path
    end
  end
end 
