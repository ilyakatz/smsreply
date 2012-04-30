class AwayCalendarsController < ApplicationController
  # GET /away_calendars
  # GET /away_calendars.json
  def index
    @away_calendars = current_user.away_calendars
    @phone_setup = current_user.phone_number_setups.find(params[:phone_number_setup_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @away_calendars }
    end
  end

  # GET /away_calendars/1
  # GET /away_calendars/1.json
  def show
    @away_calendar = current_user.away_calendars.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @away_calendar }
    end
  end

  # GET /away_calendars/new
  # GET /away_calendars/new.json
  def new
    @phone_setup = current_user.phone_number_setups.find(params[:phone_number_setup_id])
    @away_calendar = AwayCalendar.new(:phone_number_setup_id=>@phone_setup)

    respond_to do |format|
      format.html
    end
  end

  # GET /away_calendars/1/edit
  def edit
    @phone_setup = current_user.phone_number_setups.find(params[:phone_number_setup_id])
    @away_calendar = AwayCalendar.find(params[:id])
  end

  # POST /away_calendars
  # POST /away_calendars.json
  def create
    @phone_setup = current_user.phone_number_setups.find(params[:phone_number_setup_id])
    @away_calendar = AwayCalendar.new(params[:away_calendar])
    @away_calendar.phone_number_setup=@phone_setup

    respond_to do |format|
      if @away_calendar.save
        format.html { redirect_to [@phone_setup,@away_calendar], notice: 'Away calendar was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /away_calendars/1
  # PUT /away_calendars/1.json
  def update
    @away_calendar = current_user.away_calendars.find(params[:id])
    @phone_setup = current_user.phone_number_setups.find(params[:phone_number_setup_id])

    respond_to do |format|
      if @away_calendar.update_attributes(params[:away_calendar])
        format.html { redirect_to [@phone_setup,@away_calendar], notice: 'Away calendar was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /away_calendars/1
  # DELETE /away_calendars/1.json
  def destroy
    @away_calendar = AwayCalendar.find(params[:id])
    @away_calendar.destroy

    respond_to do |format|
      format.html { redirect_to away_calendars_url }
      format.json { head :no_content }
    end
  end
end
