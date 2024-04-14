# Boggle-haskell

Boggle game - word finder using DFS algorithm
Project description:

Write a program that plays the game of Boggle (with some minor modifications,
described below). You are given an N*N grid of letters, and your task is to find connected
chains of letters that form legal words. The basic rules of the game can be found at this link:
https://en.wikipedia.org/wiki/Boggle
In addition to the general requirements of the project, each language comes with its own
language-specific constraints. These specify the format of the input and output, as well as
submission instructions for each language.
Aside from these requirements, anything you do inside your program is up to you. Use as
many helper functions or methods as you want, use any syntax you find useful whether we
covered it in class or not.
Game description
The first input to your program will be an N*N grid of letters. The second input will be a list
of legal words. Your task is to search for unique, legal words in the letter grid according to
the rules of Boggle (see Wikipedia link above for more info):
• Each letter after the first must be a horizontal, vertical, or diagonal neighbor of the one
before it.
• No individual letter cube may be used more than once in a word.
Your program will return this list of words, along with the indexes of each letter. Type
details for inputs and output are language-specific and will be described below. The list of
words returned by your program will be validated, and assigned a score:

Word length 1 2 3 4 5 6  7  8+
Points      1 2 4 6 9 12 16 20

Variations from the official game:
• Traditional Boggle has a minimum word length of 3, but for this project it will be 1.
• Word scoring also differs. See the table above.
• A traditional game of Boggle uses a 4x4 grid. The input to your program can be as small
as 2x2 and grow arbitrarily large to NxN. The input will always be square.
• Traditional boggle includes a letter tile that combines “Qu”. There will be no such block
in the project. Every letter tile will contain exactly one character.
• Boggle has a 3-minute time limit. The program must complete the unit tests for each
language in 30 seconds or less. It will be tested on a reasonably powerful computer.

Game Example #1
Below is a sample 4x4 board, as well as some (but not all!) words that are in it. Of course,
the words you can find depend also on the list of legal words passed in but assume for this
example that all standard English words are legal.

the board:
i s u o    
o s v e   
n e p a   
n t s u   

list of words in board:
is son spa sent vast issue so sap ape oven nice events us ten east nose save sonnet up vet nest tens pause session

The words found in the board above would be scored as follows:
is, so, us, up = 8 points (2 each)
son, sap, ten, vet, spa, ape = 24 points (4 each)
east, nest, sent, oven, nose, tens, vast, nice, save = 54 points (6 each)
pause, issue = 18 points (9 each)
events, sonnet = 24 points (12 each)
session = 16 points (16 each)
8 + 24 + 54 + 18 + 24 + 16 = 144 points total



