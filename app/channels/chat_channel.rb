class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    conversation = Conversation.find(params[:conversation_id])
    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    conversation = Conversation.find(data["conversation_id"])
    message = conversation.messages.create!(
      user_id: current_user.id,
      content: data["content"]
    )
    ChatChannel.broadcast_to(conversation, message: message.as_json)
  end
end
