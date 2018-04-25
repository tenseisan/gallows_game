class Game
  MAX_ERRORS = 7
  attr_reader :errors, :letters, :bad_letters, :good_letters, :status
  attr_accessor :version

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = :in_progress
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end

    slovo = Unicode::upcase(slovo)

    slovo.split("")
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def won?
    @status == :won
  end

  def is_good?(letter)
    @letters.include?(letter) ||
      (letter == "Е" && @letters.include?("Ё")) ||
      (letter == "Ё" && @letters.include?("Е")) ||
      (letter == "И" && @letters.include?("Й")) ||
      (letter == "Й" && @letters.include?("И"))
  end

  def add_letter_to(letters, letter)
    letters << letter
    case letter
      when "Е" then letters << "Ё"
      when "Ё" then letters << "Е"
      when "И" then letters << "Й"
      when "Й" then letters << "И"
    end
  end

  def next_step(letter)
    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)

      @status = :won if solved?
     else
       add_letter_to(@bad_letters, letter)
      @errors += 1
      @status = :lost if lost?
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ""

    while letter == "" || letter.size > 1
      letter = Unicode::upcase(STDIN.gets.chomp)
    end
    next_step(letter)
  end
end
