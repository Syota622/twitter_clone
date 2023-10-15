# frozen_string_literal: true

class MessagesController < ApplicationController
  # メッセージ部屋一覧
  def index
    # ログインユーザー（自分自身）以外のユーザーとメッセージのやり取りをする
    @users = User.where.not(id: current_user.id)
    # どのユーザーとメッセージのやり取りをするかを指定した場合
    return unless params[:user_id]

    @recipient = User.find_by(id: params[:user_id])
    if @recipient
      @messages = Message.where(sender_id: [current_user.id, @recipient.id],
                                recipient_id: [current_user.id, @recipient.id])
    else
      # 初期画面でユーザーを選択しなかった場合は、メッセージ一覧画面に遷移する
      redirect_to messages_path
    end
  end

  # メッセージの送信
  def create
    @message = current_user.sent_messages.build(message_params)
    @message.recipient_id = params[:user_id]
    # メッセージ送信後にメッセージ一覧画面に遷移するために、@recipientを定義
    if @message.save
      redirect_to messages_path(user_id: @message.recipient_id)
    else
      redirect_to messages_path
    end
  end

  private

  # 投稿メッセージを取得する
  def message_params
    params.require(:message).permit(:content)
  end
end
