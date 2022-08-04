class PagesController < ApplicationController
  
  def Home
  end

  def doctors
    authorize! :view, :doctor
    @doctors = User.doctor.onboard
  end

  def selected_treatment
    @hts = HospitalTreatment.where(treatment_id: params[:id])
  end

end
