require 'pusher'

Pusher.app_id = '50498'
Pusher.key = '9f2de1d5ad50d4662010'
Pusher.secret = '012cf02f89cb69d5f365'

data = {'message' => 'This is an HTML5 Realtime Push Notification!'}
Pusher['my_notifications'].trigger('notification', data)