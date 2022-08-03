class PagesController < ApplicationController
  
  def Home
  end

  def doctors
    authorize! :view, :doctor
    @doctors = User.doctor.onboard
  end

  def patient
    authorize! :view, :patient
    @treatments = Treatment.all
  end

  def selected_treatment
    @hts = HospitalTreatment.where(treatment_id: params[:id])
  end

end
