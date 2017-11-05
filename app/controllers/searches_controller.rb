class SearchesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_params

  def index
    @discovered = Search.find(@query, @division) if @query && @division
  end

  private

  def set_params
    @query = params[:query]
    @division = params[:division]
  end
end
