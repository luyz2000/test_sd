class DeliverFedex
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
    pre_connect
    begin
      retries ||= 0
      results = @fedex_connect.track(tracking_number: track_number)
      TRANSLATE_RESPONSE[:"#{results.first.status}"]
    rescue => error
      retry if (retries += 1) < 3
      'EXCEPTION'
      TRANSLATE_RESPONSE[:error]
      #puts "Rescued: #{error.message}"
    end
  end

  private
  def pre_connect
    require 'fedex'
    @fedex_connect = Fedex::Shipment.new(
      key: ENV['fedex_key'],
      password: ENV['fedex_password'],
      account_number: ENV['fedex_account_number'],
      meter: ENV['fedex_meter'],
      mode: ENV['fedex_mode']
    )
  end

end
