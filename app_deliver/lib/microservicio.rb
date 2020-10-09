module Microservicio
  class Deliver_fedex
    TRANSLATE_RESPONSE = {
      'Shipment information sent to FedEx': 'CREATED',
      'At destination sort facility': 'ON_TRANSIT',
      'At FedEx destination facility': 'ON_TRANSIT',
      'Departed FedEx location': 'ON_TRANSIT',
      'At Pickup': 'ON_TRANSIT',
      'On FedEx vehicle for delivery': 'ON_TRANSIT',
      'Delivered': 'DELIVERED',
      'error': 'EXCEPTION',
    }.freeze

    def track_status(track_number)
      return "" if track_number.empty?
      require 'fedex'
      pre_connect
      begin
        retries ||= 0
        results = @fedex_connect.track(tracking_number: track_number)
        TRANSLATE_RESPONSE[:"#{results.first.status}"]
      rescue => error
        retry if (retries += 1) < 3
        TRANSLATE_RESPONSE[:error]
        #puts "Rescued: #{error.message}"
      end
    end

    private
    def pre_connect
      @fedex_connect = Fedex::Shipment.new(
        key: 'O21wEWKhdDn2SYyb',
        password: 'db0SYxXWWh0bgRSN7Ikg9Vunz',
        account_number: '510087780',
        meter: '119009727',
        mode: 'test')
    end

  end

  class Deliver_dhl
    def track_status(track_number)
      return "" if track_number.empty?
      "En Construccion..."
    end
  end

  class Delivers
    def self.for(deliver)
      case deliver
        when 'fedex'
          Deliver_fedex.new
        when 'dhl'
          Deliver_dhl.new
        else
          raise 'Deliver no soportado'
      end
    end
  end

  class Deliver
    def self.get(deliver, track_number)
      Delivers.for(deliver).track_status(track_number)
    end
  end
end
