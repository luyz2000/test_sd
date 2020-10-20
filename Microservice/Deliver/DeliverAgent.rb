require_relative 'Agents/DeliverFedex'
require_relative 'Agents/DeliverDhl'

class DeliverAgent
  def self.for(deliver)
    case deliver
      when 'fedex'
        DeliverFedex.new
      when 'dhl'
        DeliverDhl.new
      else
        raise 'Deliver no soportado'
    end
  end
end
