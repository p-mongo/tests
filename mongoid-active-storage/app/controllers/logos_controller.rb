class LogosController < ApplicationController
  before_action :set_logo, only: %i[ show edit update destroy ]

  # GET /logos or /logos.json
  def index
    @logos = Logo.all
  end

  # GET /logos/1 or /logos/1.json
  def show
  end

  # GET /logos/new
  def new
    @logo = Logo.new
  end

  # GET /logos/1/edit
  def edit
  end

  # POST /logos or /logos.json
  def create
    @logo = Logo.new(logo_params)

    respond_to do |format|
      if @logo.save
        format.html { redirect_to @logo, notice: "Logo was successfully created." }
        format.json { render :show, status: :created, location: @logo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @logo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logos/1 or /logos/1.json
  def update
    respond_to do |format|
      if @logo.update(logo_params)
        format.html { redirect_to @logo, notice: "Logo was successfully updated." }
        format.json { render :show, status: :ok, location: @logo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @logo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logos/1 or /logos/1.json
  def destroy
    @logo.destroy
    respond_to do |format|
      format.html { redirect_to logos_url, notice: "Logo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logo
      @logo = Logo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def logo_params
      params.fetch(:logo, {}).permit!
    end
end
