module QuestionHelper
  
  def display_results(questions, options)
  	content_tag(:h2, options, class: "zero-margin") +
  	content_tag(:div, "#{pluralize(questions.total_entries, "Question")} found")
  end

  def display_video(question)
    if question.video.present?
      screenshot_img = question.video.screenshot.present? ? question.video.screenshot_url(:mini) : "video_screen.jpg"
    else
      screenshot_img = "video_screen.jpg"
    end
      link_to image_tag(screenshot_img), question
  end
end