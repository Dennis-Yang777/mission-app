require 'rails_helper'

RSpec.describe MissionsController, type: :controller do
  describe "GET /index" do
    it 'asign @missions to render template' do
      mission1 = Mission.create(title: 'wash your dish', content: 'Wash the dish before you sleep.') 
      mission2 = Mission.create(title: 'write your homework', content: 'Before you play cellphone, finish your homework.')

      get :index

      expect(assigns[:missions]).to eq([mission1, mission2]) 
      expect(response).to render_template("index")  
    end
  end
end 
