$(document).ajaxError(function(event, response, settings, error) {
  if (response.status === 401) {
    return alert(error + ". You need to sign in or sign up before continuing. ");
  }
});