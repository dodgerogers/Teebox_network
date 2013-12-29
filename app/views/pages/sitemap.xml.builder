xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc root_url
    xml.priority 1.0
  end
  
  @static_pages.each do |page|
    xml.url do
      xml.loc "#{page}"
      xml.changefreq("monthly")
    end
  end
  @questions.each do |question|
    xml.url do
      xml.loc "#{question_url(question)}"
      xml.lastmod question.created_at.strftime("%F")
      xml.changefreq("monthly")
    end
  end
  @tags.each do |tag|
    xml.url do
      xml.loc "#{tagged_url(tag.name)}"
      xml.lastmod tag.created_at.strftime("%F")
      xml.changefreq("monthly")
    end
  end
end
