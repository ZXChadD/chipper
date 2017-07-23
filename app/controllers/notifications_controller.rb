# frozen_string_literal: true

class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(recipient: current_user)
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to tweets_path(@notification)
  end

end
