class Ability
  include CanCan::Ability

  def initialize(user)
    if not user.nil?
      if user.admin?
        can :manage, Hospital
        can :manage, Treatment
        can :view, :doctor
      elsif user.doctor?
        can :view, :requests
      elsif user.patient?
        can :read, Treatment
        can :view, :requestinfo
      end
    end
   
  end
end
