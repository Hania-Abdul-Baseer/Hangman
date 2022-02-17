%Version 3 of hangman. Program now displays the word and letters guessed correctly and hides the other letters
%program does not reveal a right guessed letter more than once a time, so
%user needs to guess same letter multiple times if the word has same letter multiple times
%Program uses function: rightMatch to find if guess is right. and uses function: validword and
%validLetter to accept valid inputs, and letters dont need to be guessed in order now.
%does stop after 6 turns lost and player wins when all letters guessed

%clear varaiables and comand window
clear ALL
clc

%initializing values
guessedWord = [];
guessedLetter = [];
correctLetter = [];
displayWord = [];
turns = 6;
count = 0;

%yser input from user for the word that needs to be guessed and converting it to its lower 
word = input("Please enter the word that needs to be guessed by the other player: ", "s");
word = lower(word);

%loop to make sure only valid words are accepted 
while ~validWord(word)
    disp("Invalid input: please type in one word only");
    word = input("Please enter the word that needs to be guessed by the other player: ", "s");
    word = lower(word);
end  

clc

%total letters of the word 
Length = length(word);

%making copies of the word
guessedWord = lower(word);
finalWord = lower(word);

%displaying the word with its letters hidden
for i = 1:length(word)
    displayWord = [displayWord, '*'];
end

fprintf("The word to guess: %s\n\n", displayWord);
fprintf("You have to guess a %d letter word and you have 6 chances\n", length(word));

%asking for user to guess a letter
guessedLetter = input("Please guess a letter that belongs to the word: ", "s");
fprintf("\n");
guessedLetter = lower(guessedLetter);
clc

%loop until user is on their last turn or only one last letter is left to be guessed right
while (turns>1 && count~=Length-1) 
    
    %if guess is right and the letter is valid, correct letter displayed with the word and user asked for next input
    if rightMatch(word,guessedLetter) && validLetter(guessedLetter)
        
        correctLetter = strfind(word, guessedLetter);
        word(correctLetter(1)) = [];
        correctLetter2 = strfind(guessedWord, guessedLetter);
        displayWord(correctLetter2(1)) = guessedLetter;
        guessedWord(correctLetter2(1)) = '*';
        fprintf("The word to guess: %s \n\n", displayWord);
        guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
        fprintf("\n");
        guessedLetter = lower(guessedLetter);
        count = count+1;
        clc
        
    %user asked to guess another letter if letter is not valid   
    elseif ~validLetter(guessedLetter)
        
         fprintf("The word to guess: %s \n\n", displayWord);
         disp("Error: Please type in letters only and one letter at a time");
         guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
         fprintf("\n");
         guessedLetter = lower(guessedLetter);
         clc
         
    else
        
        %if wrong guess, display result and ask for next guess and a turn is lost 
         turns = turns - 1;
         fprintf("The word to guess: %s \n\n", displayWord);
         fprintf("That was wrong :( You have %d turn(s) left.\n", turns);
         guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
         fprintf("\n");
         guessedLetter = lower(guessedLetter);  
         clc
         
    end
end

%loop for when user is on their last turn 
if turns==1
    while (count~=Length-1 && turns~=0)   
        
        %if guess is right, result is dispayed and user is asked to guess next letter 
        if rightMatch(word,guessedLetter) 
            
            correctLetter = strfind(word, guessedLetter);
            word(correctLetter(1)) = [];
            correctLetter2 = strfind(guessedWord, guessedLetter);
            displayWord(correctLetter2(1)) = guessedLetter;
            guessedWord(correctLetter2(1)) = '*';
            fprintf("The word to guess: %s \n\n", displayWord);
            guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
            fprintf("\n");
            guessedLetter = lower(guessedLetter);
            count=count+1;
            clc
                
        %user asked to guess letter again if letter is invalid 
        elseif ~validLetter(guessedLetter)
            
            fprintf("The word to guess: %s \n\n", displayWord);
            disp("Error: Please type in letters only and one letter at a time");
            guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
            fprintf("\n");
            guessedLetter = lower(guessedLetter);
            clc
               
        else
            
            %if wrong guess, user runs out of turns and loses game 
            fprintf("The word to guess: %s \n\n", displayWord);
            disp("That was wrong :( You have run out of chances and lost the game :(");
            turns=0;
         
        end
    end
end

%loop for when user has one last letter left to guess right 
if count==Length-1
    while turns~=0 && count~=0   
        
        %if guess is right, user wins and result is displayed 
        if rightMatch(word,guessedLetter)  
            
            correctLetter2 = strfind(guessedWord, guessedLetter);
            displayWord(correctLetter2(1)) = guessedLetter;
            guessedWord(correctLetter2(1)) = '*';
            fprintf("The word to guess: %s \n\n", displayWord);
            fprintf("You have guessed all the letters of the word correctly! You have won :)\n");
            count =0;
        
        %user asked to guess a letter again if the letter is not valid    
        elseif ~validLetter(guessedLetter)
        
            fprintf("The word to guess: %s \n\n", displayWord);
            disp("Error: Please type in letters only and one letter at a time");
            guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
            fprintf("\n");
            guessedLetter = lower(guessedLetter);
            clc
         
        %if user is on their last turn and guess wrong, user runs out of turns and loses the game     
        elseif turns==1
            
            fprintf("The word to guess: %s \n\n", displayWord);
            turns=0;
            fprintf("That was wrong :( You have run out of chances and lost the game :(\n");
            
        else
            
            %if guess is wrong but the user has more turns left, result is displayed and user is asked to guess another letter and a turn is lost 
            fprintf("The word to guess: %s \n\n", displayWord);
            fprintf("That was wrong :( You have %d turn(s) left\n", turns-1);
            turns = turns-1;
            guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
            fprintf("\n");
            guessedLetter = lower(guessedLetter);
            clc
                
        end
    end
end