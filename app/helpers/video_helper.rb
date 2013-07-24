module VideoHelper
  
  def video_select(video)
   "var form = $('#question_video_id');
	  var icon = $('.#{video.id}_icon');
	  var video = $('##{video.id}');
	  $('.selected').hide();
		$('.videos').removeClass('shadow');
	  form.val(form.val() == #{video.id} ? 0 : #{video.id});  
	  form.val() == #{video.id} ? icon.show() : icon.hide();
	  form.val() ==  #{video.id} ? video.addClass('shadow') : video.removeClass('shadow');"
	end
	
  def youtube_url_html5(url)
    "<iframe class='youtube-player' type='text/html' width='100%' height='400' src='http://www.youtube.com/embed/#{strip_url(url)}' frameborder='0'></iframe>"
  end
  
  def strip_url(url)
    url.gsub!("http://www.youtube.com/watch?v=", "")
  end

  def sublime_video(video, id)
    "<video id='video_#{id}' class='sublime' poster='' width='475px' height='' data-name='#{video}' data-uid='#{video}' preload='none' data-autoresize='fit'>
      <source src='#{video}' /></video>"
  end
  
  def sublimevideo_rails
    @site_token = load_config("sublime.yml")["SITE"]["TOKEN"]
  end

  def load_config(filename)
    YAML::load(ERB.new(IO.read("config/#{filename}")).result)
  end
end