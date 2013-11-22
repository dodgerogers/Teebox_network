module QuestionHelper
  
  def display_results(questions, options)
  	content_tag(:h2, options, class: "zero-margin") +
  	content_tag(:div, "#{pluralize(questions.total_entries, "Question")} found")
  end

  def display_video(question)
    screenshot_img = (question.video.screenshot_url(:mini) if question.video) || "video_screen.jpg"
    link_to image_tag(screenshot_img), question
  end
end