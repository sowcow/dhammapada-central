class Translation < ActiveRecord::Base
  belongs_to :translateable, polymorphic: true
  belongs_to :source
  belongs_to :language
end
