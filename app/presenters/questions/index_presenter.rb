class Questions::IndexPresenter
  def initialize(params = {})
    @questions = Question
    @tags = Tag
    @params = params
  end
  
  def params
    @params
  end
  
  def questions
    @questions.paginate(page: params[:page], per_page: 20).search(params[:search])
  end
  
  def tags
   @tags.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group(:tag_id).order(' tag_count desc')
  end
  
  def tagged_questions
    @questions.tagged_with(params[:tag])
  end
  
  def newest
    @questions.newest.paginate(page: params[:page], per_page: 20)
  end
  
  def unanswered
    @questions.unanswered.paginate(page: params[:page], per_page: 20)
  end
  
  def votes
    @questions.by_votes.paginate(page: params[:page], per_page: 20)
  end
end