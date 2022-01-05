require_relative 'game'
require 'json'
class GameManager
  attr_accessor :games

  def initialize
    @games = []
  end

  def add_game
    puts 'Multiplayer? (y/n)'
    multi_player = gets.chomp
    puts 'Last played at (yyyy-mm-dd)'
    last_played_at = gets.chomp
    puts 'Publish date (yyyy-mm-dd)'
    publish_date = gets.chomp
    game = Game.new(multi_player, last_played_at, publish_date)
    @games << game
    puts 'Game added'
  end

  def store_games(games)
    File.write('games.json', JSON.pretty_generate(games), mode: 'w')
  end

  def list_games
    @games.each do |game|
      puts game
    end
  end

  def read_games
    @games = JSON.parse(File.read('games.json')) if File.exist?('games.json')
  end
end
