jQuery ->
  $('#new_video').fileupload()
	dataType: "script"
	add: (e, data) ->
		data.context = $(tmpl("template-upload", data.files[0]))
		$('#new-video').append(data.context)
		data.submit()
	progress: (e, data) ->
		if data.context
			progress = parseInt(data.loaded / data.total * 100, 10)
			data.context.find('.bar').css('width', progress + '%')
    
	
   