class RequestsController < ApplicationController
    def requests_info
        authorize! :view, :requestinfo
        @pend_requests = Request.pending.where(patient_id: current_user.id)
        @rejc_requests = Request.rejected.where(patient_id: current_user.id)    
        @acpt_requests = Request.accepted.where(patient_id: current_user.id)
    end

    def requests
        authorize! :view, :requests
        @pend_requests = Request.pending.where(user_id: current_user.id)
        @acpt_requests = Request.accepted.where(user_id: current_user.id)
    end

    def accept
        req = Request.find(params[:id])
        req.status = 'accepted'
        respond_to do |format|
            if req.save
                format.html { redirect_to requests_url, notice: "Request accepted."}
            else
                format.html { redirect_to requests_url, notice: "Error accepting the request"}
            end
        end
    end

    def reject
        req = Request.find(params[:id])
        req.status = 'rejected'
        respond_to do |format|
            if req.save
                format.html { redirect_to requests_url, notice: "Request rejected."}
            else
                format.html { redirect_to requests_url, notice: "Error rejecting the request"}
            end
        end
    end

    def set_appointment
        respond_to do |format|
            if Request.pending.where(user_id: params[:id], patient_id: current_user.id).count == 0
                if Request.create(user_id: params[:id], patient_id: current_user.id)
                    format.html { redirect_to requestsinfo_url, notice: "Appointment request sent to doctor."}
                else
                    format.html { redirect_to requestsinfo_url, notice: "An error occured while sending an appointment request" }
                end
            else
            format.html { redirect_to selectedtreatment_url(User.find(params[:id]).treatment), notice: "You already have a pending request for this treatment." }        
            end
        end
    end
end