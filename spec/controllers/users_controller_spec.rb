require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "renders the index page" do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    it "renders the new page" do
      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates presence of username and password" do
        post :create, user: { username: "mark" }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end

  context "with valid params" do
    it "redirects to user show page" do
      post :create, user: { username: "mark", password: "password" }

      expect(response).to redirect_to(user_url(User.last))
    end
    end
  end

  describe "GET #show" do
    it "renders show page" do
      User.create(username: "mark", password: "password")
      get :show, id: 1

      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)

    end
  end

end
