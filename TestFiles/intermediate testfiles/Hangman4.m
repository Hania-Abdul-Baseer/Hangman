%Version 4 of hangman. User doesnt need to guess same letter multiple times if the word contains same letter multiple times.
%Program now displays the word and letters guessed correctly and hides the other letters
%Program uses function: rightMatch to find if guess is right. and uses function: validword and
%validLetter to accept valid inputs, and letters dont need to be guessed in order now.
%does stop after 6 turns lost and player wins when all letters guessed

%clear all variables and command line 
clear ALL;
clc;

%initializing values 
guessedWord = [];
guessedLetter = [];
displayWord = [];
turns = 6;
count = 0;

%getting word from the user that needs to be guessed by the other player and converted to its lower
word = input("Please enter the word that needs to be guessed by the other player: ", "s");
word = lower(word);

%ask user to enter word again if word is invalid 
while ~validWord(word)
    fprintf("Error: please type in a valid word. (i.e, no single letter, special characters, blank space, numbers, more than one word, etc.)\n\n");
    word = input("Please enter the word that needs to be guessed by the other player: ", "s");
    word = lower(word);
end  
clc

%total number of letters in the word
Length = length(word);

%making copies of the word 
guessedWord = lower(word);
finalWord = lower(word);

%dispalying the word with its letters hidden 
for i = 1:length(word)
    displayWord = [displayWord, '*'];
end

%small intro to game to user and asking to guess a letter, then coverting this letter to its lower 
fprintf("The word to guess: %s\n\n", displayWord);
fprintf("You have to guess a %d letter word and you have 6 chances\n", length(word));
guessedLetter = input("Please guess a letter that belongs to the word: ", "s");
fprintf("\n");
guessedLetter = lower(guessedLetter);
clc

%loop for until the user is on their last turn or one last letter is left to be guessed right
while (turns>1 && count~=Length-1) 
    
    %if guess is right, correct guessed letters are dispalyed with the word 
    if rightMatch(word,guessedLetter) && validLetter(guessedLetter)
          
        displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
        guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
        lengthLetters = length(strfind(word, guessedLetter));       
        word(strfind(word, guessedLetter)) = [];
        fprintf("The word to guess: %s \n\n", displayWord); 
        
        %if word contains of all similar letters and letter guessed is right then user wins
        if displayWord == finalWord 
            fprintf("That was correct! You have guessed all the letters of the word correctly! You have won :)\n"); 
            break
        
        else
            
            %if guess is right user asked for next guess and result is displayed 
            count = count+lengthLetters;
            guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
            fprintf("\n");
            guessedLetter = lower(guessedLetter);      
            clc
            
        end
     
    %if letter is invalid, user asked to guess letter again     
    elseif ~validLetter(guessedLetter)
        
         fprintf("The word to guess: %s \n\n", displayWord);
         fprintf("Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
         guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
         fprintf("\n");
         guessedLetter = lower(guessedLetter);
         clc;
         
    else
        
        %if guess is wrong, user loses a turn, reusult is displayed and user asked to guess another letter
         turns = turns - 1;
         fprintf("The word to guess: %s \n\n", displayWord);
         fprintf("That was wrong :( You have %d turn(s) left.\n", turns);
         guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
         fprintf("\n");
         guessedLetter = lower(guessedLetter);  
         clc;
         
    end
end

%loop for when user has last turn left
if turns==1
    while (count~=Length-1 && turns~=0) 
        
        %if guess is right, correct guessed letters are displayed
        if rightMatch(word, guessedLetter)
            
            displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
            guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
            lengthLetters = length(strfind(word, guessedLetter));       
            word(strfind(word, guessedLetter)) = [];
            fprintf("The word to guess: %s \n\n", displayWord); 
            
            %if all letters guessed right, player wins 
            if displayWord == finalWord             
                fprintf("That was correct! You have guessed all the letters of the word correctly! You have won :)\n");           
                break
        
            else
            
                %if guess is right but more letters left then user is asked to guess next letter
                count = count+lengthLetters;
                guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
                fprintf("\n");
                guessedLetter = lower(guessedLetter);      
                clc
            end
        
        %if letter is invalid, user asked to type in a new letter
        elseif ~validLetter(guessedLetter)
            
            fprintf("The word to guess: %s \n\n", displayWord);
            fprintf("Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
            guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
            fprintf("\n");
            guessedLetter = lower(guessedLetter);
            clc;
               
        else
            
            %if guess is wrong user runs out of turns and loses game 
            fprintf("The word to guess: %s \n\n", displayWord);
            fprintf("That was wrong :( You have run out of chances and lost the game :( The word was: (%s)\n", finalWord);
            turns=0;
              
        end
    end
end

%loop for when user has one last letter to guess right
if count==Length-1
    while turns~=0 && count~=0 
        
        %if guess is right, correct guessed letters are displayed 
        if rightMatch(word,guessedLetter) 
            
            displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
            guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
            lengthLetters = length(strfind(word, guessedLetter));       
            word(strfind(word, guessedLetter)) = [];
            fprintf("The word to guess: %s \n\n", displayWord); 
        
            %if all letter guessed right, player wins
            if displayWord == finalWord             
                fprintf("That was correct! You have guessed all the letters of the word correctly! You have won :)\n"); 
                break
                
            else
            
                %if last letter left to be guessed is right, user wins 
                fprintf("The word to guess: %s\n", finalWord);
                fprintf("That was correct! You have guessed all the letters of the word correctly! You have won :)\n");
                count =0;  
                clc
            end
         
        %if letter is invalid, user asked to enter a valid letter    
        elseif ~validLetter(guessedLetter)
 
             fprintf("The word to guess: %s \n\n", displayWord);
             fprintf("Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
             guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
             fprintf("\n");
             guessedLetter = lower(guessedLetter);
             clc;
                 
        elseif turns==1
            
            %if user had one last turn left and guess was wrong user loses
             fprintf("The word to guess: %s \n\n", displayWord);
             turns=0;
             fprintf("That was wrong :( You have run out of chances and lost the game :( The word was (%s)\n", finalWord);
         
        else
            
            %if guess is wrong but more turns left, user loses a turn and asked to guess another letter
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

