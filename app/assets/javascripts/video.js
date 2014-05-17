$(function() {
  return $(".direct-upload").each(function(data) {
    var form = $(this);
	var errors = [];
    return $(this).fileupload({
      url: form.attr("action"),
      type: "POST",
      autoUpload: true,
      dataType: "xml",
      add: function(event, data) {
        var types = /^(\S+)(\.|\/)(ogg|ogv|3gp|mp4|m4v|webm|mov|wmv)*$/i;
        var file = data.files[0];
        if (file.size < 5242880 && (types.test(file.name))) {
          $.ajax({
            url: "/signed_urls",
            type: "GET",
            dataType: "json",
            data: {
              doc: {
                title: file.name
              }
            },
            async: false,
            success: function(data) {
              form.find("input[name=key]").val(data.key);
              form.find("input[name=policy]").val(data.policy);
              return form.find("input[name=signature]").val(data.signature);
            }
          });
          return data.submit();
        } else {
			// Handle the error messages
			if (file.size > 5242880) {
				errors.push("File exceeds the 5MB size limit.");
			} else if (file.name.indexOf(" ") >= 0) {
				errors.push("File is not a valid video format or the filename contains spaces.");
			}
          	$('#failed').modal('show');
          	$('#dropzone').show();
          	$('.video-upload-info').html('').append("<b><red>Upload Failed</red></b><br><b>Filename:</b> " + file.name + " <br><b>Size:</b> " + (file.size / 1000000).toFixed(2) + " MB <br><br><b>" + errors.toString(" ") + "</b>");
      		return errors.length = 0; // Clear the error array
		}
      },
      send: function(e, data) {
        $("#failed").modal('show');
        $(".progress, #dropzone").fadeIn();
        $.each(data.files, function(index, file) {
          return $('.video-upload-info').html("").append("<b>Filename:</b> " + file.name + " <br><b>Size:</b> " + (file.size / 1000000).toFixed(2) + " MB");
        });
      },
      progress: function(e, data) {
        var percent;
        percent = void 0;
        percent = Math.round((e.loaded / e.total) * 100);
        return $(".bar").css("width", percent + "%");
      },
      fail: function(e, data) {
        console.log("Uploading failed");
		return $("#dropzone").html("").append("<b>Upload failed, please try again <i class='icon-remove-sign red'></i><br></b>").fadeIn();
      },
      success: function(data) {
        var url;
        url = void 0;
        url = decodeURIComponent($(data).find("Location").text());
        return $("#video_file").val(url);
      },
      done: function(event, data) {
        $("#new_video").submit();
		// Refresh the created video in 12 seconds
		return VideoUpdate.refresh();
      }
    });
  });
});
