$ ->
  $(".direct-upload").each ->
    form = $(this)
    $(this).fileupload
      url: form.attr("action")
      type: "POST"
      autoUpload: true
      dataType: "xml" # This is really important as s3 gives us back the url of the file in a XML document
      add: (event, data) ->
        $.ajax
          url: "/signed_urls"
          type: "GET"
          dataType: "json"
          data: # send the file name to the server so it can generate the key param
            doc:
              title: data.files[0].name

          async: false
          success: (data) ->
            
            # Now that we have our data, we update the form so it contains all
            # the needed data to sign the request
            form.find("input[name=key]").val data.key
            form.find("input[name=policy]").val data.policy
            form.find("input[name=signature]").val data.signature

        data.submit()

      send: (e, data) ->
        $(".progress").fadeIn()

      progress: (e, data) ->
        
        # This is what makes everything really cool, thanks to that callback
        # you can now update the progress bar based on the upload progress
        percent = Math.round((e.loaded / e.total) * 100)
        $(".bar").css "width", percent + "%"

      fail: (e, data) ->
        console.log "fail"

      success: (data) ->
        
        # Here we get the file url on s3 in an xml doc
        url = decodeURIComponent($(data).find("Location").text())
        $("#video_file").val url # Update the real input in the other form

      done: (event, data) ->
        $(".progress").fadeOut 300, ->
          $(".bar").css "width", 0
			


