class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    @objects = [Question, Answer]
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
    can :update, @objects, user: user
    can :destroy, @objects, user: user
    can :create, [Question, Comment, Answer]

    can :up_vote, @objects.each do |votable|
      can_vote(votable)
    end
    can :down_vote, @objects.each do |votable|
      can_vote(votable)
    end
    can :revote, @objects.each do |votable|
      user.was_voting(votable)
    end

    can :accept, Answer do |answer|
      user.author_of(answer.question) && !answer.best?
    end

    can :destroy, Attachment do |attachment|
      user.author_of(attachment.attachable)
    end
  end

  def can_vote(votable)
    !user.author_of(votable) && !user.was_voting(votable)
  end
end
