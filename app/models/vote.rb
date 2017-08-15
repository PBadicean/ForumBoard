class Vote < ApplicationRecord

  belongs_to :votable, polymorphic: true, optional: true
  belongs_to :user

  scope :liked_count, (-> { where(value: 1).count })
  scope :disliked_count, (-> { where(value: -1).count })
end
