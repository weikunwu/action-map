# frozen_string_literal: true

class NewsItemsController < ApplicationController
    before_action :set_representative
    before_action :set_news_item, only: %i[show]
#     before_action :set_rating, only: %i[show]

    def index
        @news_items = @representative.news_items
    end

    def show
        # My Code #
        # @news_item = NewsItem.find(params[:id])
    end

    private

    def set_representative
        @representative = Representative.find(
            params[:representative_id]
        )
    end

    def set_news_item
        @news_item = NewsItem.find(params[:id])
    end
    
#     def set_rating
#         @rating = @news_item.ratings.find_by user_id: current_user.id
#     end
end
