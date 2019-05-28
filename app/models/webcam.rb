class Webcam < ApplicationRecord
  def self.make_featured(id)
    self.find_by(api_id: id).update(featured: true)
  end

end
