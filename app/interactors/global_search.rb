class GlobalSearch
  include Interactor
  
  STANDARD_ERR = 'GlobalError: %s'
  NOT_IMPLEMENTED_ERR = "#search not implemented for %s"
  UNDEFINED_CLASS = "%s does not exist"
  SEARCH_PARAMS_ERROR = 'query must be a string'
  
  SEARCHABLE = [:questions, :articles, :users]
  PAGE_PARAMS = SEARCHABLE.map {|model| "#{model}_page".to_sym }
  TOTAL_ENTRIES = 100
  PER_PAGE = 6
  
  def call  
    unless context[:search].is_a?(String)
      context.fail!(error: sprintf(STANDARD_ERR, SEARCH_PARAMS_ERROR))
    end
    
    context.collection = {}
    
    SEARCHABLE.each do |model|
      klass = model.to_s.singularize.titleize
      klass_const = klass.constantize
      page_param = "#{model}_page".to_sym
      
      unless Object.const_defined?(klass.to_sym)
        context.fail!(error: sprintf(UNDEFINED_CLASS, klass))
      end
      
      if klass_const.respond_to?(:search)
        query = klass_const.search(context[:search])
        query = query.load_relations if klass_const.respond_to?(:load_relations)
        
        context.collection[model] = query.paginate(page: context[page_param], per_page: PER_PAGE) 
      else
        context.fail!(error: sprintf(NOT_IMPLEMENTED_ERR, klass))
      end
    end
    # TODO revise this
    context.total = context.collection.values.map(&:size).reduce(:+)
  end
end