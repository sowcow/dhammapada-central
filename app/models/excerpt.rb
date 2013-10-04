class Excerpt < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :translation
  delegate :lang, to: :translation
  delegate :text, to: :phrase
  delegate :translateable, to: :translation

  has_many :excerpt_links, foreign_key: 'one_id'
  has_many :linked,
    through: :excerpt_links, source: 'two'

  has_many :inverse_excerpt_links,
    class_name: 'ExcerptLink', foreign_key: 'two_id'
  has_many :inverse_linked,
    through: :inverse_excerpt_links, source: 'one'

  def linkz
    excerpt_links + inverse_excerpt_links
  end
  def linkzed
    linkz.flat_map { |link|
      link.one == self ? link.two : link.one
    }
  end
end
