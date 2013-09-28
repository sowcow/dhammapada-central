# ensures dhp skeleton
# only crates stuff, does not remove anything...
# so it does not update attrs, just creates new entities
# maybe there is some reason not to be destructive...

dhp = YAML.load File.read 'db/seeds/toc.yml'

book = Book.where(index: dhp[:index])
           .first_or_create

dhp[:vaggas].each { |x|
  vagga = Vagga.where(index: x[:index], book: book)
               .first_or_create

  x[:gathas].each { |x|
    Gatha.where(index: x[:index], vagga: vagga)
         .first_or_create
  }
}

# ***

dhp = YAML.load File.read 'db/seeds/dhp_original.yml'

#attrs = dhp.reject { |k,v| %i[books tags].include? k }
attrs = dhp.select { |k,v| %i[source].include? k }
src = Translation::Source.where(attrs).first_or_create

dhp[:books].each { |x|
  text, data = x.to_a.first # hash
  index = data[:index]
  text = data[:text] if data[:text]

  book = Book.where(index: index).first
  book.translations.where(source: src)
  .first_or_create text: text

  data[:vaggas].each { |x|
    index, data = x.to_a.first # hash
    index = data[:index]
    text = data[:text] if data[:text]

    vagga = Vagga.where(book: book, index: index).first
    vagga.translations.where(source: src)
    .first_or_create text: text

    data[:gathas].each { |x|
      index, data = x.to_a.first # hash
      index = data[:index]
      text = data[:text] if data[:text]

      gatha = Gatha.where(vagga: vagga, index: index).first
      gatha.translations.where(source: src)
      .first_or_create text: text
    }
  }
}
