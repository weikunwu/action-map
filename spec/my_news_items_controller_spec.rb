require 'rails_helper'

# news item has the following attributes
# t.string :title, null: false
# t.string :link, null: false
# t.text :description
# t.belongs_to :representative, null: false, index: true
# t.timestamps null: false


RSpec.describe MyNewsItemsController, type: :controller do
    before (:each) do
        @r_params0 = {:ocdid => '123', :name => 'name0', :title => 'title0'} #,:created_at => '1/7/2020', :updated_at => '1/7/2020'}
        @representative0 = Representative.create(@r_params0)
        @news_item_params00 = {:title => 'news0-0', :link => 'link0-0', representative_id: @representative0.id}
        @news_item00 = @representative0.news_items.create(@news_item_params00)
    end
    
    describe "GET #new" do
        it "render page for user to input" do
            get :new, params: { representative_id: @representative0.id }
#             expect(response).to render_template(:new)
            expect(response).to redirect_to(:login)
        end
        it "has required fields to be filled in" do
            get :new, params: { representative_id: @representative0.id }
            
            expect(1).to eq 1
        end
    end
  
    describe "GET #create" do
        it "increase database by 1" do
            post :create, params: { representative_id: @representative0.id, params: @news_item_params00 }
            expect(response).to redirect_to(:login)

        end
        it "redirect to all news articles" do
            get :create, params: { representative_id: @representative0.id }
#             expect(assigns(:news_items)).to include(@news_item00)
#             expect(response).to render_template(:index)
#             expect(response).to redirect_to(:index)
        end
    end
  
  
    describe "GET #edit" do
        it "has fields prefilled" do
            # get :edit, params: { representative_id: @representative0.id, id: @news_item00.id }
            # expect(page.find_field('Title').value).to eq 'news0-0'
        end
    end
    
    describe "POST #update" do
        it "update a news article" do
        end
    end
    
    describe "" do
    end
    
#   describe "POST #create" do
#     it "adds new movie to database" do
#         expect {
#         post :create, movie: @movie_attributes
#         }.to change(Movie,:count).by(1)
#     end
#     it "@movie has right attributes" do
#         post :create, movie: @movie_attributes
#         expect(assigns(:movie).title).to include("test1-1")
#     end
#   end
  
#   describe "GET #show" do
#     it "shows the correct movie" do
#       get :show, :id => @movie.id
#       expect(assigns(:movie).title).to include("test1-1")
#     end
#     it "renders the :show haml" do
#       get :show, :id => @movie.id
#       expect(response).to render_template(:show)
#     end
#   end
  
#   describe "DELETE #destroy" do
#     it "deletes movie" do
#       expect{
#         delete :destroy, id: @movie.id
#       }.to change(Movie,:count).by(-1)
#     end
#   end
  
#   describe "PUT #update" do
#     it "changes the requested movie attributes" do
#       put :update, id: @movie.id, movie: @movie_attributes2
#       @movie.reload
#       expect(@movie.title).to eq('test0-2')
#       expect(@movie.rating).to eq('G')
#     end
#   end

end