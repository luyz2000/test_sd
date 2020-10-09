App.track = App.cable.subscriptions.create("TrackChannel", {

  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log("Conectado al Explorador");
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    var map_badges = {
              'CREATED': 'info',
              'ON_TRANSIT': 'primary',
              'DELIVERED': 'success',
              'EXCEPTION': 'danger'}
    
    $("#track_numbers_container").append(`
      <div class="col-4 mb-3 num_${data.content.tracking_number}" style="display: none">
        <div class="card">
          <div class="card-body">
            Numero de Guia Ingresado:
            ${data.content.tracking_number}
          </div>
          <div class="card-footer">
            Estatus:
            <span class="badge badge-lg badge-${map_badges[data.content.status]}">
              ${data.content.status}
            </span>
          </div>
        </div>
      </div>
    `)
    $('.num_'+data.content.tracking_number).show('slow');

  }

});
