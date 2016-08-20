class SearchController < ApplicationController
  def search
    search_params.includes(tabs: [:children])
  end
end
