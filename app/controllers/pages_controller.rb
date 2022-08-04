class PagesController < ApplicationController
  
  def Home
  end

  def doctors
    authorize! :view, :doctor
    @doctors = User.doctor.onboard
  end

end
