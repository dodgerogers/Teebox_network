class PagesController < ApplicationController
  
  def info
    respond_to do |format|
      format.html { render layout: "fullwidth" }
    end
  end
end
