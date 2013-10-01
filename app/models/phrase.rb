class Phrase < ActiveRecord::Base
  has_many :excerpts
  delegate :lang, to: excerpt
end
