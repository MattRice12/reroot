class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(query)
    where("name ~* '.*#{query}.*'")
  end

end
