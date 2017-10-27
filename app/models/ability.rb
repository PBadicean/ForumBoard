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
    can :update, [Question, Answer], user_id: user.id
    can :destroy, [Question, Answer], user_id: user.id
    can :create, [Question, Comment, Answer]

    can :up_vote, [Question, Answer].each do |votable|
      can_vote(votable)
    end
    can :down_vote, [Question, Answer].each do |votable|
      can_vote(votable)
    end
    can :revote, [Question, Answer].each do |votable|
      user.was_voting(votable)
    end

    can :accept, Answer do |answer|
      user.author_of(answer.question) && !answer.best?
    end

    can :destroy, Attachment do |attachment|
      user.author_of(attachment.attachable)
    end

    can :subscribe, Question do |question|
      !user.subscribed?(question)
    end
  end

  private

  def can_vote(votable)
    !user.author_of(votable) && !user.was_voting(votable)
  end
end
