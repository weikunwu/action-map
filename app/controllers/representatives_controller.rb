# frozen_string_literal: true

class RepresentativesController < ApplicationController
    def index
        @representatives = Representative.all
    end

    def profile
        id = params[:representative_id]
        @representatives = Representative.find(id)
    end
end
