class MailboxController < ApplicationController
  before_filter :authenticate_user!

  def reply
  end

  def inbox
    @inbox = current_user.mailbox.inbox
  end

  def sentbox
  end

  def show
    mailbox ||= current_user.mailbox
    @conversation ||= mailbox.conversations.find(params[:id])
    @receipts = @conversation.receipts_for current_user
    @subject = @conversation.subject
  end

  def destroy
    puts params
  end

  def trash
  end
end
