class TreatmentsController < ApplicationController
    load_and_authorize_resource
    before_action :set_treatment, only: %i[ show edit update destroy ]

    def index
        @treatment = Treatment.all
    end

    def show
    end

    def new
        @treatment = Treatment.new
    end

    def create
        @treatment = Treatment.new(treatment_params)
        respond_to do |format|
            if @treatment.save
                format.html { redirect_to treatment_url(@treatment), notice: "Treatment is successfully created." }
            else
                format.html { render :new }
            end
        end
    end

    def edit
    end
    
    def update
        respond_to do |format|
            if @treatment.update(treatment_params)
                format.html { redirect_to treatment_url(@treatment), notice: "Treatment is successfully updated." }
            else
                format.html { render :edit }
            end
        end
    end

    def destroy
        respond_to do |format|
            req = Request.where(user_id: @treatment.users.ids)

            if @treatment.destroy
                req.destroy_all
    
                format.html { redirect_to treatments_url, notice: "Treatment is successfully deleted." }
            else
                format.html { redirect_to treatments_url }
            end
        end
    end

    private
    def set_treatment
      @treatment = Treatment.find(params[:id])
    end

    def treatment_params
      params.require(:treatment).permit(:name)
    end

end
