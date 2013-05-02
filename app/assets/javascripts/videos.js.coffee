jQuery ->
	$("#new_video").fileupload drop: (e, data) ->
  		$.each data.files, (index, file) ->
    		$('.well').append("Video file: " + file.name + '<br>' + "File size: " + (file.size / 1000000 ) + ' MB')
			
		
	jQuery ->
		$("#new_video").fileupload progressall: (e, data) ->
		 progress = parseInt(data.loaded / data.total * 100, 10)
			$('#progress').show()
			$("#progress .bar").css "width", progress + "%"
			
							  


 
	
