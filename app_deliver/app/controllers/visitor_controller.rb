class VisitorController < ApplicationController
  include Microservicio

  def index
    async_track_render(params[:track_number]) if params[:track_number].present?
  end

  def procces_json
    json_file_readed = params[:json_file].read
    JSON.parse(json_file_readed).each_with_index do |tracking,i|
      Thread.new{ async_track_render( tracking["tracking_number"]) }
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def async_track_render(number)
    ActionCable.server.broadcast "track_channel", content: {
      tracking_number: number,
      status: Deliver.get('fedex', number )
    }
  end

end
