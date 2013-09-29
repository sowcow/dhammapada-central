class Vagga < ActiveRecord::Base
  belongs_to :book
  has_many :gathas
  has_many :translations, as: :translateable

  extend FriendlyId
  friendly_id :index, use: :finders

  def next
    book.vaggas.where("id > ?", id).order("id ASC").first
  end
end
