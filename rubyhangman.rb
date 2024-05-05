def choose_word
  words = ["apple", "banana", "orange", "grape", "kiwi", "pineapple"]
  return words.sample
end

def display_word(word, guessed_letters)
  displayed_word = ""
  word.each_char do |letter|
    if guessed_letters.include?(letter)
      displayed_word += letter
    else
      displayed_word += "_"
    end
  end
  return displayed_word
end

def hangman
  word = choose_word
  guessed_letters = []
  attempts = 6

  puts "Welcome to Hangman!"
  puts display_word(word, guessed_letters)

  loop do
    print "Guess a letter: "
    guess = gets.chomp.downcase

    if guessed_letters.include?(guess)
      puts "You've already guessed that letter."
      next
    elsif word.include?(guess)
      guessed_letters << guess
      puts display_word(word, guessed_letters)
    else
      attempts -= 1
      puts "Incorrect! Attempts left: #{attempts}"
      puts display_word(word, guessed_letters)
      if attempts.zero?
        puts "You're out of attempts! The word was: #{word}"
        break
      end
    end

    if !display_word(word, guessed_letters).include?("_")
      puts "Congratulations! You guessed the word: #{word}"
      break
    end
  end
end

hangman
