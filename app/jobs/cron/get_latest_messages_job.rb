class Cron::GetLatestMessagesJob

  def self.perform
    PhoneNumberSetup.all.each do |phone|
      if phone.provider.name == Provider::VERIZON
        Resque.enqueue(Providers::VerizonMessagesJob, phone.id)
      end
    end
  end

end