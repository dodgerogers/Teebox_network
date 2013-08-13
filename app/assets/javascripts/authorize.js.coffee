$(document).ajaxError (event, response, settings, error) ->
  alert("You need to sign in or sign up before continuing.") if response.status is 401
