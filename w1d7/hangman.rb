require "byebug"

class Hangman

  MAX_TURNS = 6

  def initialize
    @turns = MAX_TURNS
  end

  def play

    print_welcome
    select_mode
    @pick_player.pick_secret_word
    @guess_player.receive_secret_length

    until game_over?
      print_current_state

      guessed_letter = prompt_for_guess
      until valid_letter?(guessed_letter)
        puts "Invalid character."
        guessed_letter = prompt_for_guess
      end

      @pick_player.check_guess(guessed_letter)
      unless @pick_player.handle_guess_response(guessed_letter)
        @guess_player.narrow_guesses(guessed_letter)
        @turns -= 1
      end

    end

    print_result

  end

  def print_welcome
    puts "Welcome to Hangman."
  end

  def print_current_state
    @pick_player.word_array.each do |letter|
      if letter == nil
        print "_"
      else
        print letter
      end
    end
    puts
  end

  def select_mode
    puts "Will the human or computer choose a word to guess? (h/c)"
    response = gets.chomp.upcase
    if response == "H"
      @pick_player = HumanPlayer.new
      @guess_player = ComputerPlayer.new
    else
      @pick_player = ComputerPlayer.new
      @guess_player = HumanPlayer.new
    end

  end

  def prompt_for_guess
    puts "Enter a letter."
    guessed_letter = @guess_player.guess
  end

  def valid_letter?(guess)
    return false if guess !~ /[[:alpha:]]/
    true
  end

  def won?
    if @pick_player.word_array.include?(nil)
      return false
    else
      true
    end
  end

  def lost?
    @turns == 0
  end

  def game_over?
    won? || lost?
  end

  def print_result
    if @guess_player.is_a? HumanPlayer
      puts "You won with #{@turns} guess(es) left!" if won?
      puts "You lose. Try again." if lost?
      puts "The word was #{@pick_player.secret_word}."
    else
      if won?
        puts "Your word was #{@pick_player.word_array.join("")}."
        puts "The computer won with #{@turns} guess(es) left!"
      else
      puts "The computer ran out of guesses!" if lost?
      end
    end
  end


end

class HumanPlayer

  attr_accessor :secret_word, :secret_length, :word_array

  def initialize
    @secret_word = []
    @secret_length = 0
    @word_array = []
  end

  def pick_secret_word
    puts "How long is the secret word?"
    @secret_length = gets.chomp.to_i
    @word_array = Array.new(@secret_length, nil)
  end

  def receive_secret_length
    #handled by ComputerPlayer
  end

  def guess
    guessed_letter = gets.chomp.upcase
  end

  def check_guess(letter)
    #all handled in handle_guess_response
  end

  def check_guess_human?(letter)
    puts "Human, does the word contain #{letter}? (y/n)"
    answer = gets.chomp.upcase
    if answer == "Y"
      @secret_length.times do |i|
        next unless @word_array[i].nil?
        puts "Does the letter appear in index #{i}? (y/n)"
        idx_answer = gets.chomp.upcase
        @word_array[i] = letter if idx_answer == "Y"
      end
      return true
    else
      puts "Okay I will try again."
      false
    end
  end

  def handle_guess_response(letter)
    check_guess_human?(letter)
  end

  def narrow_guesses(word)
    #does nothing for human player
  end

end

class ComputerPlayer

  DICTIONARY = "dictionary_small.txt"

  attr_accessor :secret_word, :secret_length, :word_array, :dictionary

  def initialize
    @secret_word = ""
    @secret_length = 0
    @word_array = []
    @guessed_letters = []
    @guessable_letters = []
    @dictionary = dictionary = File.readlines(DICTIONARY).map(&:chomp)
  end

  def pick_secret_word
    @secret_word = @dictionary[rand(0..@dictionary.length)].upcase
    @word_array = Array.new(@secret_word.length, nil)
  end

  def receive_secret_length
    until @secret_length > 0
      puts "Confirm length of word."
      @secret_length = gets.chomp.to_i
      if @secret_length == 0
        puts "Invalid length."
      end
    end
    select_possible_words_from_dictionary
  end

  def select_possible_words_from_dictionary
    new_dictionary = []
    @dictionary.each do |word|
      new_dictionary << word if word.length == @secret_length
    end
    @dictionary = new_dictionary

  end

  def guess

    update_guessable_letters
    guessed_letter = @guessable_letters[rand(0..(@guessable_letters.count - 1))]
    @guessed_letters << guessed_letter.upcase
    guessed_letter

    # RANDOM GUESSING
    # current_guess = rand(97..122).chr.upcase
    #   until !@guessed_letters.include?(current_guess)
    #     current_guess = rand(97..122).chr.upcase
    #   end
    #
    #   @guessed_letters << current_guess
    #   current_guess
  end

  def check_guess(letter)
    if @secret_word.include?(letter)
      @secret_word.length.times do |i|
        @word_array[i] = @secret_word[i] if @secret_word[i] == letter
      end
    end
  end

  def update_guessable_letters

    @guessable_letters = []
    @dictionary.each do |word|
      word.each_char do |letter|
        if !@guessable_letters.include?(letter) && !@guessed_letters.include?(letter)
          @guessable_letters << letter.upcase
        end
      end
    end
  end

  def handle_guess_response(letter)
    if @secret_word.include?(letter)
      puts "Good guess."
      return true
    else
      puts "Bad guess."
      return false
    end
  end

  def narrow_guesses(letter)
    new_dictionary = []
    @dictionary.each do |word|
      new_dictionary << word.upcase if !word.include?(letter.upcase)
    end
    @dictionary = new_dictionary
  end

end
