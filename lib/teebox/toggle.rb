module Teebox::Toggle
  def toggle_correct(attribute)
    toggle(attribute).update_attributes({attribute => self[attribute]})
  end
end