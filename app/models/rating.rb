# frozen_string_literal: true

class Rating < ApplicationRecord
    belongs_to :news_item
    belongs_to :user

    def self.rating_scale
        [1, 2, 3, 4, 5]
    end
end
