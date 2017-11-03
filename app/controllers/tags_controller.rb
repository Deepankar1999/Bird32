class TagsController < ApplicationController

  def index
    @tags = Tag.where(params[:id])
  end

  def show
    @tag = Tag.find(params[:id])
    @tweets = @tag.tweets.all
  end

end
