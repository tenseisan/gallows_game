if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'unicode'
require_relative 'lib/game'
require_relative 'lib/word_reader'
require_relative 'lib/result_printer'

VERSION = 'Игра виселица. Версия 4.1\n'.freeze
sleep 1

word_reader = WordReader.new
words_file_name = File.dirname(__FILE__) + '/data/words.txt'
game = Game.new(word_reader.read_from_file(words_file_name))
game.version = VERSION
printer = ResultPrinter.new(game)

while game.in_progress?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
