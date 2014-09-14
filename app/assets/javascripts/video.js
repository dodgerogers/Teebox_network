$(function() {
  $(".direct-upload").each(function(data) {
	
	var maxFileSize = 12582912;
    var form = $(this);
	var errors = [];
	var new_video_form = $("#new_video");
	var aws_policy_url = "/signed_urls";
	var fail_message = "<b>Upload failed, please try again <i class='icon-remove-sign red'></i><br></b>";
	var valid_file_types = "ogg, ogv, 3gp, mp4, m4v, webm, mov, wmv";
	
    form.fileupload({
      url: form.attr("action"),
      type: "POST",
      autoUpload: true,
      dataType: "xml",
      add: function(event, data) {
        var types = /^(\S+)(\.|\/)(ogg|ogv|3gp|mp4|m4v|webm|mov|wmv)*$/i;
        var file = data.files[0];
        if ( (file.size < maxFileSize) && (types.test(file.name)) ) {
          $.ajax({
            url: aws_policy_url,
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
			if (file.size > maxFileSize) {
				errors.push("File exceeds the 12MB size limit");
			}
			if ( types.test(file.name) == false ) {
				errors.push("File is not a valid video format" + "<br>" + valid_file_types);
			}
			if ( file.name.indexOf(" ") >= 0 ) {
				errors.push("Filename contains spaces");
			}
			
			// Display the errors and clear array
          	$('#failed').modal('show');
          	$('#dropzone').show();
          	$('.video-upload-info').html('').append("<b><red>Upload Failed</red></b><br><b>Filename:</b> " + file.name + " <br><b>Size:</b> " + (file.size / 1000000).toFixed(2) + " MB <br><br><b>" + errors.join(". ") + "</b>");
      		return errors.length = 0;
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
		return $("#dropzone").html("").append(fail_message).fadeIn();
      },
      success: function(data) {
        var url;
        url = void 0;
        url = decodeURIComponent($(data).find("Location").text());
		return $("#video_file").val(url);
	  },
	  done: function(event, data) {
		return new_video_form.submit();
      }
    });
  });
});
