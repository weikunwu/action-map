# frozen_string_literal: true
require 'open-uri'
require 'json'

class MyNewsItemsController < SessionController
    before_action :set_representative
    before_action :set_representatives_list
    before_action :set_news_item, only: %i[edit update destroy]
    before_action :set_rating, only: %i[edit update destroy]
    before_action :set_rating_params, only: %i[update]

    def new
        if params[:news_item].nil?
            @news_item = NewsItem.new
        else
            if !params[:news_item][:title].nil?
                @news_item = NewsItem.new(:title => params[:news_item][:title].split[0..-2], :link => params[:news_item][:title].split[-1])
            else 
                @news_item = NewsItem.new(news_item_params)
            end
        end
        @all_issues = NewsItem.all_issues
    end

    def edit
        # My Code #
        # byebug
        @all_issues = NewsItem.all_issues
    end

    def create
        #@news_item = @representative.news_items.new(news_item_params)
        @news_item = NewsItem.new(news_item_params)
        if @news_item.save
            redirect_to representative_news_item_path(@representative, @news_item),
                        notice: 'News item was successfully created.'
        else
            render :new, error: 'An error occurred when creating the news item.'
        end

        # @rating = @news_item.ratings.create(score: rating_params[:score], user_id: current_user.id)
        @rating = Rating.create!(score: rating_params[:score], user_id: @current_user.id, news_item_id: @news_item.id)
    end

    def update
        rating_params[:user_id] = @current_user.id
        rating_params[:news_item_id] = @news_item.id
        if @rating.nil?
            @rating = Rating.create(rating_params)
        else
            @rating.update(score: rating_params[:score])
        end
        if @news_item.update(news_item_params)
            redirect_to representative_news_item_path(@representative, @news_item),
                        notice: 'News item was successfully updated.'
        else
            render :edit, error: 'An error occurred when updating the news item.'
        end
    end

    def autofill
        @representative = Representative.find(params[:news_item]["representative_id"])
        
        url = 'http://newsapi.org/v2/everything?'\
        'q=' + params[:news_item]["issue"] + ' AND ' + @representative.name + '&'\
        'from=2020-08-12&'\
        'sortBy=popularity&'\
        'apiKey=65366a4cea244d1083c6c20690ab4c55'

        req = open(url)
        articles = []
        response_body = JSON.parse(req.read)["articles"][0..4].each do |article|
            articles.append([article["title"], article["url"]])
        end
        #@news_articles = url
        @news_articles = articles
    end

    def extract
        list = params[:news_item]
        @news_item = NewsItem.new(news_item_params)
        @all_issues = NewsItem.all_issues
        # redirect_to representative_new_my_news_item_path(@representative)
    end

    def destroy
        # puts '*********************'
        # puts 'DEBUG: destroy called!'
        @news_item.destroy
        redirect_to representative_news_items_path(@representative),
                    notice: 'News was successfully destroyed.'
    end

    private

    def set_representative
        @representative = Representative.find(
            params[:representative_id]
        )
    end

    def set_representatives_list
        @representatives_list = Representative.all.map { |r| [r.name, r.id] }
    end

    def set_news_item
        @news_item = NewsItem.find(params[:id])
    end

    def set_rating
        @rating = @news_item.ratings.find_by user_id: @current_user.id
    end

    def set_rating_params
        rating_params[:user_id] = @current_user.id
        rating_params[:news_item_id] = @news_item.id
    end

    # Only allow a list of trusted parameters through.
    def news_item_params
        params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue, :rating)
    end

    def rating_params
        params.require(:rating).permit(:score)
    end
end
