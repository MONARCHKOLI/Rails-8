import consumer from "./consumer"

const conversationId = 1

consumer.subscriptions.create({channel: "ChatChannel", conversation_id: conversationId}, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("New message:", data)
    // Called when there's incoming data on the websocket for this channel
  },

  send_message(content) {
    this.perform("send_message", { conversation_id: conversationId, content: content })
  }
});
