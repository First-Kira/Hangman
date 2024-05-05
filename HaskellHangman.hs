import System.IO

-- Define the word to guess
word :: String
word = "haskell"

-- Main function to play the game
main :: IO ()
main = do
    putStrLn "Welcome to Haskell Hangman!"
    playGame word ['_' | _ <- word] 6

-- Play the game with the given word, current guessed word, and attempts left
playGame :: String -> String -> Int -> IO ()
playGame _ guessedWord 0 = do
    putStrLn $ "Game over! You've run out of attempts. The word was: " ++ word
    putStrLn $ "The word you guessed: " ++ guessedWord
playGame word guessedWord attemptsLeft
    | word == guessedWord = do
        putStrLn $ "Congratulations! You've won. The word is: " ++ word
    | otherwise = do
        putStrLn $ "Word: " ++ guessedWord
        putStrLn $ "Attempts left: " ++ show attemptsLeft
        putStr "Guess a letter: "
        hFlush stdout
        guess <- getLine
        let newGuessedWord = updateGuessedWord word guessedWord (head guess)
        if newGuessedWord == guessedWord
            then do
                putStrLn "Incorrect guess."
                playGame word guessedWord (attemptsLeft - 1)
            else do
                putStrLn "Correct guess!"
                playGame word newGuessedWord attemptsLeft

-- Update the guessed word with the correctly guessed letter
updateGuessedWord :: String -> String -> Char -> String
updateGuessedWord [] _ _ = []
updateGuessedWord (w:ws) (g:gs) c
    | w == c = w : updateGuessedWord ws gs c
    | otherwise = g : updateGuessedWord ws gs c
