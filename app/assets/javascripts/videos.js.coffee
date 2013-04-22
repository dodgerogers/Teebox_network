jQuery ->
	$("#new_video").fileupload drop: (e, data) ->
  		$.each data.files, (index, file) ->
    		$('.well').append("Video file: " + file.name)
		

			jQuery ->
				$("#new_video").fileupload progress: (e, data) ->
			  	progress = parseInt(data.loaded / data.total * 100, 10)
				$("#progress .bar").css "width", progress + "%"
			  	

 
	
   