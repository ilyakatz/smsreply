if ENV['REDISTOGO_URL']
  Resque.redis = ENV['REDISTOGO_URL']
end

Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }