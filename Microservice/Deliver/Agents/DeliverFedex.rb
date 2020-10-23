class DeliverFedex

  def track_status(track_number)
    return "" if track_number.empty?
    pre_connect
    begin
      retries ||= 0
      results = @fedex_connect.track(tracking_number: track_number)
      TRANSLATE["fedex"][results.first.status]
    rescue => error
      retry if (retries += 1) < 3
      TRANSLATE["fedex"]["error"]
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
