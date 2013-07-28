class NotificationsController < ApplicationController
  def message
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
  end
end