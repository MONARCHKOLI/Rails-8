import consumer from "./consumer"

consumer.subscriptions.create({ channel: "OrderStatusChannel", order_id: 1 }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Order update:", data)
    // Called when there's incoming data on the websocket for this channel
  }
});
