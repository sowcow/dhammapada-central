class ExcerptLink < ActiveRecord::Base
  belongs_to :one, class_name: 'Excerpt'
  belongs_to :two, class_name: 'Excerpt'
end
