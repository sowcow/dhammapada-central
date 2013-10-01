class Excerpt < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :translation
  delegate :lang, to: :translation
end
