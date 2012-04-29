class MessagesController < ApplicationController

  def index
    @start_date=3.days.ago
    @messages = Message.where("received > ?", @start_date)
  end

  def create

    file = data_from_verizon

    full_filename = save_verizon_data(file)


    CSV.foreach(full_filename, :col_sep =>"\t", :row_sep =>:auto) do |row|
      date, time, destination, origin, direction, type =row
      full_date = DateTime.strptime("#{date} #{time}", "%m/%d/%Y %H:%M %p") rescue nil

      if full_date
        debugger
        m = Message.where(:received=>full_date).where(:destination=>destination).where(:origin=>origin)
        if m.present?
          Rails.logger.info("Message already exists")
        else
          Message.create!(:received=>full_date,
                          :destination=>destination,
                          :origin=>origin,
                          :direction=>direction,
                          :message_type=>type)
        end
      end
    end

    redirect_to messages_path

  end

  private

  def save_verizon_data(file)
    filename="ilyakatz.xls"
    full_filename="#{Rails.root}/tmp/#{filename}"

    if File.exists?(full_filename)
      File.delete(full_filename)
    end
    file.save(full_filename)
    full_filename
  end

  def data_from_verizon
    vzlink = "https://nbillpay.verizonwireless.com/vzw/accountholder/unbilledusage/UnbilledMessaging.action?d-4019015-e=2&6578706f7274=1&mtn=9177745435&tab=messages"
    VerizonMessagesJob.perform(vzlink)
  end

end