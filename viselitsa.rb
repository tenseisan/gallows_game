if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require "unicode"
require_relative "game"
require_relative "result_printer"
require_relative "word_reader"

puts "Игра виселица. Версия 4\n"
sleep 1

printer = ResultPrinter.new
word_reader = WordReader.new
words_file_name = File.dirname(__FILE__) + "/data/words.txt"
game = Game.new(word_reader.read_from_file(words_file_name))

while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
