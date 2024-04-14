module Boggle where

import qualified Data.Map.Strict as Map
import Data.Char (toLower)
import Data.List (nubBy)
import Data.Maybe (fromMaybe)

newtype Trie = Trie { unTrie :: Map.Map Char Trie }
    deriving (Eq)

data SearchResult = Found | Prefix | None deriving (Eq, Show)

-- return an empty trie
emptyTrie :: Trie
emptyTrie = Trie Map.empty

-- insert a word into the trie
insertWord :: String -> Trie -> Trie
insertWord [] (Trie trie) = Trie (Map.insert '\0' emptyTrie trie)
insertWord (c:cs) (Trie trie) =
    let c' = toLower c
        subTrie = Map.findWithDefault emptyTrie c' trie
    in Trie (Map.insert c' (insertWord cs subTrie) trie)

-- -- build a trie from a list of words
buildTrie :: [String] -> Trie
buildTrie = foldr (insertWord . map toLower) emptyTrie  

-- search for a word in trie and return the search results
searchTrie :: String -> Trie -> SearchResult
searchTrie [] (Trie trie) = if Map.member '\0' trie then Found else Prefix
searchTrie (c:cs) (Trie trie) = case Map.lookup (toLower c) trie of 
    Just subTrie -> searchTrie cs subTrie
    Nothing -> None

type Board = [[Char]]
type Position = (Int, Int)
type Path = [Position]

-- find all valid words on a boggle board from list of dictionary words
boggle :: Board -> [String] -> [(String, Path)]
boggle board words = nubBy (\(w1, _) (w2, _) -> w1 == w2) $
    concatMap findWords allPositions
    where
        -- build the trie
        trie = buildTrie words
        height = length board
        width = if height == 0 then 0 else length (head board)
        allPositions = [(i, j) | i <- [0..height-1], j <- [0..width-1]]

        -- find all words from position
        findWords :: Position -> [(String, Path)]
        findWords pos = dfs pos "" []

        -- depth first search to search all the possibilities from position
        dfs :: Position -> String -> Path -> [(String, Path)]
        dfs (x, y) acc path
            -- check bounds 
            | not (inBounds (x, y)) || (x, y) `elem` path = []
            | otherwise =
                let newWord = acc ++ [toLower (board !! x !! y)] -- append current letter 
                    newPath = path ++ [(x, y)]
                    searchRes = searchTrie newWord trie --check current word in trie
                    continue = if searchRes == Prefix || searchRes == Found --continue if prefix is ok or word is found
                               then concatMap (\(nx, ny) -> dfs (nx, ny) newWord newPath) (adjacent (x, y)) 
                               else []
                in if searchRes == Found && length newWord > 2 then (newWord, newPath) : continue else continue

        -- helper function to check if position is inside the boards boundaries
        inBounds (x, y) = x >= 0 && x < height && y >= 0 && y < width
        
        -- helper function to calculate adjacent cells for a position
        adjacent (x, y) = [(x+dx, y+dy) | dx <- [-1..1], dy <- [-1..1], not (dx == 0 && dy == 0), inBounds (x+dx, y+dy)]
