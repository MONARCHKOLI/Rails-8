import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { conversationId: Number }
  static targets = ["messages", "input"]

  connect() {
    this.subscription = consumer.subscriptions.create(
      { channel: "ChatChannel", conversation_id: this.conversationIdValue },
      {
        received: data => this.appendMessage(data),
      }
    )
  }

  disconnect() {
    if (this.subscription) {
      consumer.subscriptions.remove(this.subscription)
    }
  }

  sendMessage(event) {
    event.preventDefault()
    const content = this.inputTarget.value.trim()
    if (content === "") return

    this.subscription.perform("send_message", {
      conversation_id: this.conversationIdValue,
      content: content
    })

    this.inputTarget.value = ""
  }

  appendMessage(data) {
    const messageElement = document.createElement("div")
    messageElement.textContent = `${data.user_name}: ${data.content}`
    this.messagesTarget.appendChild(messageElement)
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
  }
}
