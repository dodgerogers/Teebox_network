Tag.destroy_all
File.read("#{Rails.root}/db/tags.txt").split("\n\n").each do |tag|
  name, explanation = tag.split(":")
  Tag.create!(name: name, explanation: explanation)
end
