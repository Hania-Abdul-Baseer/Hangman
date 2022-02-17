%Version 2 of hangman. Program uses function: rightMatch to find if guess is right. and uses function: validword and
%validLetter to accept valid inputs, and letters dont need to be guessed in order now.
%does stop after 6 turns lost and player wins when all letters guessed 

%clear variables and command line window
clear ALL;
clc;

%initializing values
guessedWord = [];
guessedLetter = [];
correctLetter = [];
turns = 6;
count = 0;

%asking word input that needs to be guessed by the other player and converting it in lower 
word = input("Please enter the word that needs to be guessed by the other player: ", "s");
word = lower(word);

%loop to only accept valid words as inputs
while ~validWord(word)
    disp("Invalid input: please type in one word only");
    word = input("Please enter the word that needs to be guessed by the other player: ", "s");
    word = lower(word);
end  

clc

%total letters in the word
Length = length(word);

guessedWord = word;

%asking user to guess a letter and converting it to lower 
fprintf("You have to guess a %d letter word and you have 6 chances\n", length(word));
guessedLetter = input("Please guess a letter that belongs to the word: ", "s");
guessedLetter = lower(guessedLetter);

%loop until one turn is left or one letter is left to be guessed right
while (turns>1 && count~=Length-1) 
    
        %using function rightMatch check if guess is right, display result and ask for next guess
        if rightMatch(word,guessedLetter) && validLetter(guessedLetter)
            
            correctLetter = strfind(word, guessedLetter);
            word(correctLetter(1)) = [];
            guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
            guessedLetter = lower(guessedLetter);
            count = count + 1;
            
        %accept only valid letters 
        elseif ~validLetter(guessedLetter)
            
            disp("Error: Please type in letters only and one letter at a time");
            guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
            guessedLetter = lower(guessedLetter);
        
        %if wrong guess, player asked for next guess and a turn is lost
        else
            
            turns = turns - 1;
            fprintf("That was wrong :( You have %d turn(s) left.\n", turns);
            guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
            guessedLetter = lower(guessedLetter);  
            
        end
end

%loop for when user is on their last turn
if turns==1
    while (count~=Length-1 && turns~=0)
        
            %if guess is right, user asked for next guess
            if rightMatch(word,guessedLetter)
                correctLetter = strfind(word, guessedLetter);
                word(correctLetter(1)) = [];
                guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
                guessedLetter = lower(guessedLetter);
                count=count+1;
             
            %if guess is wrong, user runs out of chances and loses    
            else
                disp("That was wrong :( You have lost");
                turns=0;         
            end
    end
end

%loop for when user is has one last letter to guess right
if count==Length-1
    while turns~=0 && count~=0
        
            %if guess is right, user wins 
            if rightMatch(word,guessedLetter)
                fprintf("You have guessed all the letters of the word correctly! You guessed the word (%s)\n", guessedWord);
                count =0;
                
            %if user was on last turn and guess is wrong, user loses    
            elseif turns==1
                turns=0;
                fprintf("That was wrong :( You have lost:(\n");
                
            %if guess is wrong but user has more turns left, user asked for next guess and a turn is lost    
            else
                fprintf("That was wrong :( You have %d turn(s) left\n", turns-1);
                turns = turns-1;
                guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
                guessedLetter = lower(guessedLetter);
            end
    end
end