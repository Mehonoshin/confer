class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Conference

    if user.registred?
      can :create, Conference
    end

  end
end
