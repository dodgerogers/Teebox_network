$(function() {
  return $(".direct-upload").each(function(data) {
    var form;
    form = $(this);
    return $(this).fileupload({
      url: form.attr("action"),
      type: "POST",
      autoUpload: true,
      dataType: "xml",
      add: function(event, data) {
        var file, types;
        types = /(\.|\/)(ogg|ogv|3gp|mp4|m4v|webm|mov)$/i;
        file = data.files[0];
        if (data.files[0].size < 5242880 && (types.test(file.type) || types.test(file.name))) {
          $.ajax({
            url: "/signed_urls",
            type: "GET",
            dataType: "json",
            data: {
              doc: {
                title: data.files[0].name
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
          $('#failed').modal('show');
          $('#dropzone').show();
          return $('.video-upload-info').html('').append("<b><red>Upload Failed</red></b><br><b>Filename:</b> " + data.files[0].name + " <br><b>Size:</b> " + (data.files[0].size / 1000000).toFixed(2) + " MB <br><br><b>File Exceeds the 5MB file size limit or is not a valid video format</b>");
        }
      },
      send: function(e, data) {
        $("#failed").modal('show');
        $(".progress, #dropzone").fadeIn();
        return $.each(data.files, function(index, file) {
          return $('.video-upload-info').html("").append(file.name + " " + (file.size / 1000000).toFixed(2) + ' MB');
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
        return $("#new_video").submit();
      }
    });
  });
});
