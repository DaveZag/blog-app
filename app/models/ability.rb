class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post

    return unless user.present?

    can :manage, Post, author: user # if the user is logged in, he can manage he's own posts
    can :create, Comment
    can :destroy, Comment, author: user

    return unless user.admin?

    can :manage, :all
  end
end
