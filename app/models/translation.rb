class Translation < ActiveRecord::Base
  belongs_to :translateable, polymorphic: true
  belongs_to :source
end