class HospitalsController < ApplicationController
    load_and_authorize_resource
    before_action :set_hospital, only: %i[ show edit update destroy assign_treatment assign_doc remove_doctor ]

    def index
        @hospitals = Hospital.all
    end

    def show
    end

    def new
        @hospital = Hospital.new
    end

    def create
        @hospital = Hospital.new(hospital_params)
        respond_to do |format|
            if @hospital.save
                format.html { redirect_to hospital_url(@hospital), notice: "Hospital is successfully created." }
            else
                format.html { render :new }
            end
        end
    end

    def edit
    end
    
    def update
        # debugger
        respond_to do |format|
            if @hospital.update(hospital_params)
                format.html { redirect_to hospital_url(@hospital), notice: "Hospital is successfully updated." }
            else
                format.html { render :edit }
            end
        end
    end

    def destroy
        respond_to do |format|
            req = Request.where(user_id: @hospital.users.ids)

            if @hospital.destroy
                req.destroy_all

                format.html { redirect_to hospitals_url, notice: "Hospital is successfully destroyed." }
            else
                format.html { redirect_to hospitals_url }
            end
        end
    end

    def assign_treatment
    end

    def associate_treatment
        respond_to do |format|
            ht = HospitalTreatment.find_by(hospital_id: params[:id], treatment_id: params[:User][:treatment_id])
            if ht
                ht.update(price: params[:User][:price])
            else
                ht =  HospitalTreatment.create(hospital_id: params[:id], treatment_id: params[:User][:treatment_id], price: params[:User][:price])
            end

            if ht.save
                format.html { redirect_to hospital_url(@hospital), notice: "Hospital was successfully associated with the treatment" }
            else
                format.html { redirect_to assigntreatment_path(@hospital), notice: "Price should be greater than zero" }
            end
        end
    end

    # Remove a treatmenr from a hospital
    def remove_treatment
        h_id = params[:id]
        t_id = [params[:id2]]

        docs = User.where(hospital_id: h_id, treatment_id: t_id)
        req = Request.where(user_id: docs.ids)
        
        respond_to do |format|
            if HospitalTreatment.find_by(hospital_id: h_id, treatment_id: t_id).destroy
                docs.update_all(hospital_id: nil, treatment_id: nil)
                req.destroy_all
                format.html { redirect_to hospital_url(@hospital), notice: "Treatment is successfully Removed from this hospital."}
            else
                format.html { redirect_to hospital_url(@hospital), notice: "An error occured while removing the treatment."}
            end
        end
    end

    def remove_doctor
        doc = User.find(params[:id2])
        doc.update(hospital_id: nil, treatment_id: nil)
        req = Request.where(user_id: doc.id)
        respond_to do |format|
            if doc.save
                req.destroy_all
                format.html { redirect_to ondoctors_url, notice: "Doctor successfully removed." }
            else
                format.html { redirect_to ondoctors_url, notice: "An error occured while removing the doctor."}
            end
        end
    end

    def assign_doc
    end

    def associate_doc
        doc = User.find(params[:User][:doctor_id])
        doc.hospital_id = params[:id]
        doc.treatment_id = params[:User][:treatment_id]
        respond_to do |format|
            if doc.save
                format.html { redirect_to hospital_url(Hospital.find(params[:id])), notice: "Doctor successfully assigned." }
            else
                format.html { redirect_to doctors_url(Hospital.find(params[:id])), notice: "An error occured while assigning the doctor."}
            end
        end
    end

    private
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    def hospital_params
      params.require(:hospital).permit(:name, :city, :address)
    end

end
