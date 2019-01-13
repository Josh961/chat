include AttachmentUploader[:attachment]

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  after_create_commit :broadcast_message

  def attachment_name=(name)
    @attachment_name = name
  end

  def attachment_name
      @attachment_name
  end

  private

  def broadcast_message
    MessageBroadcastJob.perform_later(self)
  end
end
