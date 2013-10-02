class Excerpt < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :translation
  delegate :lang, to: :translation
  delegate :text, to: :phrase
  delegate :translateable, to: :translation

  has_many :excerpt_links, foreign_key: 'one_id'
  has_many :linked,
    through: :excerpt_links, source: 'two'
end
