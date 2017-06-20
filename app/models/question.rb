class Question < ApplicationRecord
  has_many :answers, :dependent => true
  validates :title, :body, presence: true
end
