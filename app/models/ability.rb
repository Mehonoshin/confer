class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Conference
    can :read, Participant
    can :read, Report

    if user.admin?
      can :manage, :all
      can :moderate, :all
    end

    if user.registred?
      can :create, Conference
      can :create, Participant
      can :create, Report

      # Organizers features
      can :moderate, Conference do |conference|
        conference.stuff.include?(user)
      end
    end

  end
end
