class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # before_create :assign_uuid
  
  # private
  # def assign_uuid
  #   self.uuid = SecureRandom.uuid
  # end
end
