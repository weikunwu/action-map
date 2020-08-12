# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rating, type: :model do
    # pending 'add some examples to (or delete) #{__FILE__}'
    it 'should be defined' do
        expect { Rating }.not_to raise_error
    end
    before :each do
        @r_params0 = { ocdid: '123', name: 'name0', title: 'title0' }
        @representative0 = Representative.create(@r_params0)
        @news_item_params00 = { title: 'news0-0', link: 'link0-0', representative_id: @representative0.id }
        @news_item00 = @representative0.news_items.create(@news_item_params00)
        @rating00 = @news_item00.ratings.create(score: 1)
    end

    describe 'create new instance' do
        it 'contains necessary fields' do
            expect(@rating00.score).to eq 1
        end
    end

    describe 'association' do
        it 'belongs to a news item' do
            expect(@rating00.news_item).to eq(@news_item00)
            @rating00 = Rating.create(score: 1, news_item_id: @news_item00.id)
            expect(@rating00.news_item).to eq(@news_item00)
        end
    end
end
