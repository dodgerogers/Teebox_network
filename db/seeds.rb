Tag.destroy_all
File.read("#{Rails.root}/config/tags.txt").split("\n\n").each do |line|
  name, explanation = line.split(":")
  Tag.create!(name: name, explanation: explanation)
end