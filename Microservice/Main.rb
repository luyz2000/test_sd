require_relative 'Config/Gemfile'
require_relative 'Config/LoadEnv'
require_relative 'Deliver/DeliverAgent'

class Deliver
  def self.get(deliver, track_number)
    DeliverAgent.for(deliver).track_status(track_number)
  end
end

puts Deliver.get("fedex", "449044304137821")
