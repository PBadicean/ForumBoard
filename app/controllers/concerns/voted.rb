module Voted

  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:up_vote, :down_vote, :revote]
    before_action :check_voter, only: [:up_vote, :down_vote]
  end

  def up_vote
    @vote = @votable.votes.create(value: 1, user: current_user)
    render json: { votable: @votable, rating: @votable.rating }
  end

  def down_vote
    @vote = @votable.votes.create(value: -1, user: current_user)
    render json: { votable: @votable, rating: @votable.rating }
  end

  def revote
    return head :forbidden unless current_user.was_voting(@votable)
    @votable.destroy_vote(current_user)
    render json: { votable: @votable, rating: @votable.rating }
  end

  protected

  def check_voter
    head :forbidden if current_user.author_of(@votable) || current_user.was_voting(@votable)
  end

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end