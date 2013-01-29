class Ability
  include CanCan::Ability

  def initialize(user, current_conference)
    user ||= User.new # guest user (not logged in)

    # Guests
    can :read, Conference
    can :read, Participant
    can :read, Report
    can :read, NewsArticle
    can :read, Material
    can :create, Feedback

    if user.admin?
      can :manage, :all
      #can :manage, Conference
      #can :manage, NewsArticle
      #can :manage, Feedback
      #can :manage, User
    elsif user.registred?
      can :create, Conference

      # Conference site permissions
      unless current_conference.nil?
        can :create, Participant
        can :create, Report
        # participant
        if current_conference.has_guest?(user)
          can :create, Material
        end
        # organizer
        if current_conference.has_organizer?(user)
          can :manage, Material
          can :manage, Material
          can :moderate, Conference
        end
      end
    end

  end
end
