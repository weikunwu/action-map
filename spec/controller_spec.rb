require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before (:each) do
    @movie_attributes = {:title => 'test1-1', :release_date => '20/7/2020', \
        :director => 'someone1', :rating => 'PG'}
    @movie_attributes2 = {:title => 'test0-2', :release_date => '1/7/2020', \
        :director => 'someone2', :rating => 'G'}
    @movie_attributes3 = {:title => 'test0-!', :release_date => '2/7/2020', \
        :rating => 'PG-13'}
    @movie = Movie.create(@movie_attributes)
    @movie2 = Movie.create(@movie_attributes2)
    @movie3 = Movie.create(@movie_attributes3)
  end
  
  describe "GET #index" do
    it "shows all movies" do
      get :index
      expect(assigns(:movies).all).to include(@movie)
      expect(response).to render_template(:index)
    end
    
    it "sorts all movies by title" do
      get :index, :sort => 'title'
      response.status.should be(302)
    end
    
    it "sorts all movies by date" do
      get :index, :sort => 'release_date'
      response.status.should be(302)
    end
    
    it "finds similar movies by director" do
      get :index, :movie_id_with_director => @movie2.id
      expect(assigns(:movies).all).to include(@movie2)
    end
    
    it "finds similar movies without director" do
      get :index, :movie_id_with_director => @movie3.id
      assigns(:movies).all.should include(@movie3)
      assigns(:movies).all.should include(@movie)
    end
  end
  
  
  describe "POST #create" do
    it "adds new movie to database" do
        expect {
        post :create, movie: @movie_attributes
        }.to change(Movie,:count).by(1)
    end
    it "@movie has right attributes" do
        post :create, movie: @movie_attributes
        expect(assigns(:movie).title).to include("test1-1")
    end
  end
  
  describe "GET #show" do
    it "shows the correct movie" do
      get :show, :id => @movie.id
      expect(assigns(:movie).title).to include("test1-1")
    end
    it "renders the :show haml" do
      get :show, :id => @movie.id
      expect(response).to render_template(:show)
    end
  end
  
  describe "DELETE #destroy" do
    it "deletes movie" do
      expect{
        delete :destroy, id: @movie.id
      }.to change(Movie,:count).by(-1)
    end
  end
  
  describe "PUT #update" do
    it "changes the requested movie attributes" do
      put :update, id: @movie.id, movie: @movie_attributes2
      @movie.reload
      expect(@movie.title).to eq('test0-2')
      expect(@movie.rating).to eq('G')
    end
  end

end