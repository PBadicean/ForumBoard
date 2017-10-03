module Voted

  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:up_vote, :down_vote, :revote]
  end

  def up_vote
    authorize! :up_vote, @votable
    @vote = @votable.votes.create(value: 1, user: current_user)
    render json: { votable: @votable, rating: @votable.rating }
  end

  def down_vote
    authorize! :down_vote, @votable
    @vote = @votable.votes.create(value: -1, user: current_user)
    render json: { votable: @votable, rating: @votable.rating }
  end

  def revote
    authorize! :revote, @votable
    @votable.destroy_vote(current_user)
    render json: { votable: @votable, rating: @votable.rating }
  end

  protected

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end
