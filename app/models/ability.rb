class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :update, [Question, Answer], user: user
    can :destroy, [Question, Answer], user: user
    can :create, [Question, Comment, Answer]

    can :up_vote, [Question, Answer].each do |votable|
      !user.author_of(votable) && !user.was_voting(votable)
    end
    can :down_vote, [Question, Answer].each do |votable|
      !user.author_of(votable) && !user.was_voting(votable)
    end
    can :revote, [Question, Answer].each do |votable|
      user.was_voting(votable)
    end
  end
end
