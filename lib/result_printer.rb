class ResultPrinter
  def initialize(game)
    @status_image = []

    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= game.max_errors
      file_name = current_path + "/../image/#{counter}.txt"
      begin
        file = File.new(file_name, "r:UTF-8")
        @status_image << file.read
        file.close
      rescue SystemCallError
        @status_image << "\n [ изображение не найдено ] \n"
      end
      counter += 1
    end
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  def print_status(game)
    cls
    puts game.version
    puts
    puts "Слово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки: #{game.bad_letters.join(", ")}"

    print_viselitsa(game.errors)

    if game.lost?
      puts
      puts "Вы проиграли :("
      puts "Загаданное слово было: " + game.letters.join("")
      puts
    elsif game.won?
      puts
      puts "Поздравляем, вы выиграли!"
      puts
    else
      puts "У вас осталось ошибок: #{game.errors_left}"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ""

    letters.each do |item|
      if good_letters.include?(item)
        result += item + " "
      else
        result += "__ "
      end
    end
    result
  end

  def cls
    system("clear") || system("cls")
  end
end
