require 'date'
require_relative 'author_manager'

class Item
  attr_reader :id
  attr_accessor :genre, :author, :source, :label, :publish_date, :archived

  def initialize(id:, publish_date:, archived: false)
    @id = id || Random.rand(1..1_000_000)
    @publish_date = publish_date
    @archived = archived
    @author_manager = AuthorManager.new
  end

  def add_genre(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  def add_author(author = nil)
 
    author ||= @author_manager.add_author
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end

  def add_source(source)
    @source = source
    source.items.push(self) unless source.items.include?(self)
  end

  def add_label(label)
    @label = label
    label.items.push(self) unless label.items.include?(self)
  end

  def move_to_archive
    @archived = can_be_archived?
  end

  private

  def can_be_archived
    current_date = Date.today
    current_date.year - publish_date.slice(0, 3).to_i > 10
  end
end
