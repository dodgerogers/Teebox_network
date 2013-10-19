jQuery ->
 $(".direct-upload").each (data) ->
   form = $(this)
   $(this).fileupload 
     url: form.attr("action")
     type: "POST"
     autoUpload: true
     dataType: "xml"
     add: (event, data) ->
      types = /(\.|\/)(ogg|ogv|3gp|mp4|m4v|webm|mov)$/i
      file = data.files[0]
      if data.files[0].size < 5242880 && (types.test(file.type) || types.test(file.name))
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
       
      else
         $('#failed').modal('show')
  	      $('#dropzone').show()
         $('.video-upload-info').html('').append("<b><red>Upload Failed</red></b><br><b>Filename:</b> " + data.files[0].name + " <br><b>Size:</b> " + (data.files[0].size / 1000000).toFixed(2) + " MB <br><br><b>File Exceeds the 5MB file size limit or is not a valid video format</b>")

     send: (e, data) ->
          $("#failed").modal('show')
          $(".progress, #dropzone").fadeIn()
          $.each data.files, (index, file) ->
             $('.video-upload-info').html("").append("<b>Filename:</b> " + file.name + "<br><b>Size:</b> " + (file.size / 1000000 ).toFixed(2) + ' MB')


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