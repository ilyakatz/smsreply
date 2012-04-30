class AwayCalendarsController < ApplicationController
  # GET /away_calendars
  # GET /away_calendars.json
  def index
    @away_calendars = current_user.away_calendars

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @away_calendars }
    end
  end

  # GET /away_calendars/1
  # GET /away_calendars/1.json
  def show
    @away_calendar = AwayCalendar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @away_calendar }
    end
  end

  # GET /away_calendars/new
  # GET /away_calendars/new.json
  def new
    @away_calendar = AwayCalendar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @away_calendar }
    end
  end

  # GET /away_calendars/1/edit
  def edit
    @away_calendar = AwayCalendar.find(params[:id])
  end

  # POST /away_calendars
  # POST /away_calendars.json
  def create
    @away_calendar = AwayCalendar.new(params[:away_calendar])

    respond_to do |format|
      if @away_calendar.save
        format.html { redirect_to @away_calendar, notice: 'Away calendar was successfully created.' }
        format.json { render json: @away_calendar, status: :created, location: @away_calendar }
      else
        format.html { render action: "new" }
        format.json { render json: @away_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /away_calendars/1
  # PUT /away_calendars/1.json
  def update
    @away_calendar = AwayCalendar.find(params[:id])

    respond_to do |format|
      if @away_calendar.update_attributes(params[:away_calendar])
        format.html { redirect_to @away_calendar, notice: 'Away calendar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @away_calendar.errors, status: :unprocessable_entity }
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
