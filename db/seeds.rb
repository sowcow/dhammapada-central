dhp = YAML.load File.read 'db/seeds/toc.yml'

book = Book.create index: dhp[:index]

dhp[:vaggas].each { |x|
  vagga = Vagga.create index: x[:index], book: book

  x[:gathas].each { |x|
    Gatha.create index: x[:index], vagga: vagga
  }
}
