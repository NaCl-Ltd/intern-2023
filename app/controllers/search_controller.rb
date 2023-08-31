class SearchController < ApplicationController
    def search 
        @Search_data = Search.search(params[:query])
    end

end