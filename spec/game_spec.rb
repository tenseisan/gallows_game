require_relative '../lib/game.rb'
require 'unicode'

describe 'Game' do

  it 'user wins the game' do
    # Загадываем слово
    game = Game.new('ХЕХ')

    # Убедимся, что в начале игры статус — игра в процессе
    expect(game.status).to eq :in_progress

    # Удачно отгадаем несколько букв, симулируя действия игрока
    game.next_step 'Х'
    game.next_step 'Е'


    # Теперь изучем состояние экземпляра game: количество ошибок и статус
    expect(game.errors).to eq 0
    expect(game.status).to eq :won
  end


  it 'user lose the game' do
    game = Game.new('МУДАК')

    expect(game.status).to eq :in_progress

    game.next_step 'Я'
    game.next_step 'Щ'
    game.next_step 'Р'
    game.next_step 'В'
    game.next_step 'И'
    game.next_step 'О'
    game.next_step 'Ц'

    expect(game.errors).to eq 7
    expect(game.status).to eq :lost

  end
  end