class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :manage, User
    else
      can :create, User
      can :show, User, id: user.id
      can :update, User, id: user.id
      can :destroy, User, id: user.id
    end
  end
end
