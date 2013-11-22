class MailboxController < ApplicationController
  before_filter :authenticate_user!

  def reply
    puts params[:id]
    body = params[:body]
    conversation = current_user.mailbox.conversations.find(params[:id])
    current_user.reply_to_conversation(conversation, body)
    flash[:notice] = "Message envoyé"
    redirect_to mailbox_show_path(conversation)
  end

  def write
    @user = User.find(params[:id])
  end

  def new
    user = User.find(params[:to])
    current_user.send_message(user, params[:body], params[:subject])
    flash[:notice] = "Message envoyé à #{user.full_name}"
    redirect_to mailbox_show_path(current_user.mailbox.sentbox.last)
  end

  def inbox
    @inbox = current_user.mailbox.inbox
  end

  def sentbox
    @sentbox = current_user.mailbox.sentbox
  end

  def show
    mailbox ||= current_user.mailbox
    @conversation ||= mailbox.conversations.find(params[:id])
    @receipts = @conversation.receipts_for current_user
    @subject = @conversation.subject
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def destroy
    if mailbox.conversations.exists? params[:id]
      mailbox.conversations.find(params[:id]).move_to_trash current_user
      flash[:notice] = "Message supprimé"
    end
    redirect_to mailbox_inbox_path
  end
  def undestroy
    if mailbox.conversations.exists? params[:id]
      mailbox.conversations.find(params[:id]).untrash current_user
      flash[:notice] = "Message restauré"
    end
    redirect_to mailbox_inbox_path
  end

  def trash
    @trash = current_user.mailbox.trash
  end
end
