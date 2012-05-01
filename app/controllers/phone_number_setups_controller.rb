class PhoneNumberSetupsController < ApplicationController
  # GET /phone_number_setups
  # GET /phone_number_setups.json
  def index
    @phone_number_setups = current_user.phone_number_setups

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phone_number_setups }
    end
  end

  # GET /phone_number_setups/1
  # GET /phone_number_setups/1.json
  def show
    @phone_number_setup = current_user.phone_number_setups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @phone_number_setup }
    end
  end

  # GET /phone_number_setups/new
  # GET /phone_number_setups/new.json
  def new
    @phone_number_setup = PhoneNumberSetup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @phone_number_setup }
    end
  end

  # GET /phone_number_setups/1/edit
  def edit
    @phone_number_setup = current_user.phone_number_setups.find(params[:id])
  end

  # POST /phone_number_setups
  # POST /phone_number_setups.json
  def create
    @phone_number_setup = PhoneNumberSetup.new(params[:phone_number_setup])
    @phone_number_setup.user = current_user

    respond_to do |format|
      if @phone_number_setup.save
        format.html { redirect_to @phone_number_setup, notice: 'Phone number setup was successfully created.' }
        format.json { render json: @phone_number_setup, status: :created, location: @phone_number_setup }
      else
        format.html { render action: "new" }
        format.json { render json: @phone_number_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /phone_number_setups/1
  # PUT /phone_number_setups/1.json
  def update
    @phone_number_setup = current_user.phone_number_setups.find(params[:id])

    respond_to do |format|
      if @phone_number_setup.update_attributes(params[:phone_number_setup])
        format.html { redirect_to @phone_number_setup, notice: 'Phone number setup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @phone_number_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_number_setups/1
  # DELETE /phone_number_setups/1.json
  def destroy
    @phone_number_setup = PhoneNumberSetup.find(params[:id])
    @phone_number_setup.destroy

    respond_to do |format|
      format.html { redirect_to phone_number_setups_url }
      format.json { head :no_content }
    end
  end
end
