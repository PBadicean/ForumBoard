class User < ApplicationRecord

  has_many :votes
  has_many :comments
  has_many :questions
  has_many :answers
  has_many :authorizations, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  def author_of(resources)
    resources.user_id == self.id
  end

  def was_voting(resources)
    resources.votes.where(user_id: id).exists?
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info.email
    user = User.where(email: email).first
    password = Devise.friendly_token[0, 20]
    user ||= User.new(email: email, password: password, password_confirmation: password)
    user.skip_confirmation!
    user.save!
    user.authorizations.create(provider: auth.provider, uid: auth.uid)
    user
  end
end
