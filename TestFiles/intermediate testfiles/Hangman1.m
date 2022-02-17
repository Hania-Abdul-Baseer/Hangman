%Version 1 of hangman. Program accepts invalid inputs, can guess right if
%only in right order, does stop after 6 turns lost and player wins when all
%letters guessed in order and some other bugs

%clear variables and command window 
clear ALL;
clc;

%initializing values
guessedLetter = [];
turns = 6;
count = 0;

%taking input from user
word = input("Please enter the word that needs to be guessed by the other player: ", "s");

clc

%making a copy of the word
guessedWord = word;

%total letters in the word
Length = length(word);

%asking user to guess a letter
fprintf("You have to guess a %d letter word and you have 6 chances\n\n", length(word));

guessedLetter = input("Please guess a letter that belongs to the word: ", "s");

%if only one letter word and guessed right, player wins
if guessedLetter == word(1)
    fprintf("You have guessed all the letters of the word! You guessed the word: %s\n", word);
end

%loops for until more than 2 chances left or only last letter left to be guessed
while (turns>2 && count~=Length-1) 
    
    %if letter guessed right, reuslt is displayed and user asked for next guess
    for i = 1:length(word)
        if guessedLetter == word(i)
            word(i) = [];
            guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
            count = count + 1;
            break
        else
            
            %if wrong guess, one turn lost, result displayed and user asked to guess again
            turns = turns - 1;
            fprintf("That was wrong :( You have %d turn(s) left.\n", turns);
            guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
            
            break
        end
    end
end


if turns==2
    
    %when 2 turn left and guess is wrong user is has one last chance
    fprintf("That was wrong :( You have %d turn(s) left.\n", turns-1);
    guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
    
    %loop until user has no chances left or user has one last letter to guess right
    while (count~=Length-1 && turns~=0)
        for i = 1:length(word)
            
            %if right guess, user asked for next guess
            if guessedLetter == word(i)
                word(i) = [];
                guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
                count=count+1;
                break
            else
                
                %if wrong guess, user runs out of turns and loses 
                disp("That was wrong :( You have lost");
                turns=0;
                break
            end
        end
    end
end

%condition for when user has one last letter to guess right
if count==Length-1
    while turns~=0 && count~=0
        for i = 1:length(word)
            
            %if right guess, user has guessed all letters and wins 
            if guessedLetter == word(i)
                fprintf("You have guessed all the letters of the word correctly! You guessed the word (%s)\n", guessedWord);
                count =0;
                break
                
            %if wrong guess on last turn user loses
            elseif turns==1
                turns=0;
                fprintf("That was wrong :( You have lost:(\n");                
                break
                
            %if wrong guess but more turns letf, user asked for next guess    
            else
                fprintf("That was wrong :( You have %d turn(s) left\n", turns-1);
                turns = turns-1;
                guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
                break
            end
        end
    end
end