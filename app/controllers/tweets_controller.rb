class TweetsController < ApplicationController

  before_action :authenticate_user!

  def index
    # For New Tweet Form
    @tweet = Tweet.new
    # For Tweet Table
    @tweets = Tweet.all.order("created_at DESC")
  end

  def create
    # Add tweet to current user
    @tweet = current_user.tweets.new(tweet_params)
    @tweet.save

    # Extracting Hashtags
    @tag_array = @tweet.body.scan(/#\w+\b/)

    # Running a loop that adds each hashtag association to the PostTag table
    unless @tag_array == []
      @tag_array.each do |tag|
        @tag = Tag.find_or_initialize_by(name: tag)
        @tag.save
        @tweet.tags << @tag
      end
    end

    redirect_to tweets_path
    flash[:notice] = "Thanks for posting!"
  end

  def destroy
    Tweet.destroy(params[:id])
    redirect_to tweets_path
  end

  private

    def tweet_params
      params.require(:tweet).permit(:body)
    end

end
