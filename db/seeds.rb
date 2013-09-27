# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


dhp = YAML.load 'db/seeds/toc.yml'

book = Book.create index: dhp[:index]

dhp[:vaggas].each { |x|
  vagga = Vagga.create index: x[:index], book: book

  vag[:gathas].each { |x|
    Gatha.create index: x[:index], vagga: vagga
  }
}
