# frozen_string_literal: true

require 'rails_helper'

# news item has the following attributes
# t.string :title, null: false
# t.string :link, null: false
# t.text :description
# t.belongs_to :representative, null: false, index: true
# t.timestamps null: false

RSpec.describe NewsItemsController, type: :controller do
    before :each do
        @r_params0 = { ocdid: '123', name: 'name0', title: 'title0' }
        @representative0 = Representative.create(@r_params0)
        @news_item_params00 = { title: 'news0-0', link: 'link0-0', representative_id: @representative0.id }
        @news_item00 = @representative0.news_items.create(@news_item_params00)
    end

    describe 'GET #index' do
        it 'shows news items of a representative' do
            get :index, params: { representative_id: @representative0.id }
            expect(assigns(:news_items)).to include(@news_item00)
            expect(response).to render_template(:index)
        end
    end

    describe 'GET #show' do
        it 'shows detail of a news item' do
            get :show, params: { representative_id: @representative0.id, id: @news_item00.id }
            expect(assigns(:news_item).title).to eq 'news0-0'
            expect(response).to render_template(:show)
        end
    end
end
