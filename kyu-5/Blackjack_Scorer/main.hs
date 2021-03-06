-- https://www.codewars.com/kata/534ffb35edb1241eda0015fe/

import Data.List (partition)
import Data.Char (isDigit)


blackjackScore :: String -> Int
blackjackScore x
  | isNumber x = read x :: Int
  | otherwise = 10
  where
    isNumber = isDigit . head

blackjackScorePartition :: [String] -> (Int, Int)
blackjackScorePartition xs = (length aces, safe_score)
  where
    (aces, rest) = partition ((==) "A") xs
    safe_score = (+) (length aces) . sum . map blackjackScore $ rest

scoreHand :: [String] -> Int
scoreHand xs = safe_score + required_score
  where
    (ace_len, safe_score) = blackjackScorePartition xs
    required_score = (*) 10 . min ace_len . max 0 $ ((21 - safe_score) `div` 10)

