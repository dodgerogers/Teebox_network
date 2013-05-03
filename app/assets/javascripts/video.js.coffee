$ ->
  $(".direct-upload").each ->
    form = undefined
    form = $(this)
    $(this).fileupload
      url: form.attr("action")
      type: "POST"
      autoUpload: true
      dataType: "xml"
      add: (event, data) ->
        $.ajax
          url: "/signed_urls"
          type: "GET"
          dataType: "json"
          data:
            doc:
              title: data.files[0].name

          async: false
          success: (data) ->
            form.find("input[name=key]").val data.key
            form.find("input[name=policy]").val data.policy
            form.find("input[name=signature]").val data.signature

        data.submit()

      send: (e, data) ->
        $(".progress, #dropzone").fadeIn()
        $.each data.files, (index, file) ->
      	  $('.well').html("").append("Uploading: " + file.name + '<br>' + "File size: " + (file.size / 1000000 ) + ' MB')

      progress: (e, data) ->
        percent = undefined
        percent = Math.round((e.loaded / e.total) * 100)
        $(".bar").css "width", percent + "%"
	
      fail: (e, data) ->
        console.log "fail"

      success: (data) ->
        url = undefined
        url = decodeURIComponent($(data).find("Location").text())
        $("#video_file").val url

      	done: (event, data) ->
		        $("#new_video").submit()
		        $(".progress").fadeOut 1200, ->
		          $(".bar").css "width", 0



