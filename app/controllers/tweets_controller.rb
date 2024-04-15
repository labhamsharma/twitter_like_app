class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:update, :destroy]

  def index
    # Get the tweets of the current user and the users they follow
    followed_user_ids = current_user.following.pluck(:id) << current_user.id
    @tweets = Tweet.where(user_id: followed_user_ids).order(created_at: :desc)

    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save
      # Respond with Turbo Stream to append the new tweet
      render turbo_stream: turbo_stream.append('tweets', partial: 'tweet', locals: { tweet: @tweet })
    else
      render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @tweet.update(tweet_params)
      # Respond with Turbo Stream to update the tweet
      render turbo_stream: turbo_stream.update('tweet_' + @tweet.id.to_s, partial: 'tweet', locals: { tweet: @tweet })
    else
      render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet.destroy
    # Respond with Turbo Stream to remove the tweet
    render turbo_stream: turbo_stream.remove('tweet_' + @tweet.id.to_s)
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content, documents: [])
  end
end
