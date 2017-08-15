module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def rating
    votes.liked_count - votes.disliked_count
  end
end
