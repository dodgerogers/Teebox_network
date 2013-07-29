require 'pusher'

Pusher.app_id = ENV['PUSHER_APP_ID']
Pusher.key = ENV['PUSHER_KEY']
Pusher.secret = ENV['PUSHER_SECRET']

data = {'message' => 'This is an HTML5 Realtime Push Notification!'}
Pusher['my_notifications'].trigger('notification', data)