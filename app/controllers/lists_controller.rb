class ListsController < ApplicationController
  def index
    @lists = Movie.all
  end

  def show
    @list = Movie.find(params[:id])
  end
end
