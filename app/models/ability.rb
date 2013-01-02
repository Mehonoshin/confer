class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Conference
    can :read, Participant
    can :read, Report

    if user.admin?
      can :manage, :all
    end

    if user.registred?
      can :create, Conference
      can :create, Participant
      can :create, Report
    end

  end
end
