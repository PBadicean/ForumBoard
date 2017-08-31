class User < ApplicationRecord

  has_many :votes
  has_many :comments

  has_many :questions
  has_many :answers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def author_of(resources)
    resources.user_id == self.id
  end

  def was_voting(resources)
    resources.votes.where(user_id: id).exists?
  end

end
