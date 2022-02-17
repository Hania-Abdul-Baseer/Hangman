%Version 5 of hangman. User can now play game multiple times and wrong guessed letter are displayed and chances left are displayed to user for every turn
%User doesnt need to guess same letter multiple times if the word contains same letter multiple times.
%Program now displays the word and letters guessed correctly and hides the other letters
%Program uses function: rightMatch to find if guess is right. and uses function: validword and
%validLetter to accept valid inputs, and letters dont need to be guessed in order now.
%does stop after 6 turns lost and player wins when all letters guessed

%rematch value set as 1 so game runs atleast once
rematch=1;

%while user wants to play again this game will run 
while rematch==1
    
    %clear variables and command line
    clear ALL;
    clc;

    %initializing values
    guessedWord = [];
    guessedLetter = [];
    wrongGuesses = [];
    displayWord = [];
    turns = 6;
    count = 0;

    %taking input/word from user that needs to be guessed by the other
    %player and converted to its lower 
    word = input("Please enter the word that needs to be guessed by the other player: ", "s");
    word = lower(word);

    %loop to make sure only valid words are accepted
    while ~validWord(word)
        fprintf("Error: please type in a valid word. (i.e, no single letter, special characters, blank space, numbers, more than one word, etc.)\n\n");
        word = input("Please enter the word that needs to be guessed by the other player: ", "s");
        word = lower(word);
    end  
    clc

    %total letters in the word
    Length = length(word);
    
    %making copies of the word 
    guessedWord = lower(word);
    finalWord = lower(word);

    %displaying the word to user with its letters hidden
    for i = 1:length(word)
        displayWord = [displayWord, '*'];
    end

    %small intro to game and info about the word to user
    fprintf("The word to guess: %s\n\n", displayWord);
    fprintf("You have to guess a %d letter word and you have 6 chances\n", length(word));
    
    %asking user to guess a letter and converting the letter to its lower
    guessedLetter = input("Please guess a letter that belongs to the word: ", "s");
    fprintf("\n");
    guessedLetter = lower(guessedLetter);
    clc

    %loop until user is on their last turn or when user has one last letter to guess right
    while (turns>1 && count~=Length-1) 

        %if guess is right, correct guessed letters are displayed
        if rightMatch(word,guessedLetter) && validLetter(guessedLetter)

            displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
            guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
            lengthLetters = length(strfind(word, guessedLetter));       
            word(strfind(word, guessedLetter)) = [];
            fprintf("The word to guess: %s \n\n", displayWord); 
            fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
            fprintf("Chances: %d\n\n", turns);

            %if all letters of word guessed right, user wins and asked if
            %they want to paly again
            if displayWord == finalWord 
                fprintf("That was correct! You have guessed all the letters of the word correctly! You have won :)\n\n"); 
                again="*";
                
                %ask user if they want to play again, only accepts yes or no
                while again~="yes" && again ~="no"
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        disp("Please type in yes or no only");
                    end
                end
                break
            else

                %if guess is right, result is displayed and user asked for next guess
                count = count+lengthLetters;
                guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
                fprintf("\n");
                guessedLetter = lower(guessedLetter);      
                clc

            end

        %if letter is invalid, user asked to type valid letter
        elseif ~validLetter(guessedLetter)

             fprintf("The word to guess: %s \n\n", displayWord);
             fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
             fprintf("Chances: %d\n\n", turns);
             fprintf("Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
             guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
             fprintf("\n");
             guessedLetter = lower(guessedLetter);
             clc;

        else

            %if guess is wrong, user loses a turn and asked for next guess
             turns = turns - 1;
             fprintf("The word to guess: %s \n\n", displayWord);
             wrongGuesses = [wrongGuesses, guessedLetter,','];
             fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
             fprintf("Chances: %d\n\n", turns);
             fprintf("That was wrong :( You have %d turn(s) left.\n", turns);
             guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
             fprintf("\n");
             guessedLetter = lower(guessedLetter);  
             clc;

        end
    end

    %loop for when user is on their last turn
    if turns==1
        while (count~=Length-1 && turns~=0)  
            
            %if guess is right, correct guessed letter are shown
            if rightMatch(word, guessedLetter)

                displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
                guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
                lengthLetters = length(strfind(word, guessedLetter));       
                word(strfind(word, guessedLetter)) = [];
                fprintf("The word to guess: %s \n\n", displayWord); 
                fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
                fprintf("Chances: %d\n\n", turns);

                %if all letters of word guessed right user wins
                if displayWord == finalWord             
                    fprintf("That was correct! You have guessed all the letters of the word correctly! You have won :)\n\n");   
                    again="*";
                    
                    %user asked if they want to play again and only accepts
                    %yes or no 
                    while again~="yes" && again ~="no"
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        disp("Please type in yes or no only");
                    end
                    end
                break


                else

                    %if guess is right and more letters left, user asked
                    %for next guess
                    count = count+lengthLetters;
                    guessedLetter = input("That was correct! Please guess another letter that belongs to the word: ", "s");
                    fprintf("\n");
                    guessedLetter = lower(guessedLetter);      
                    clc
                end

            %user asked to input valid letter if letter is invalid
            elseif ~validLetter(guessedLetter)

                fprintf("The word to guess: %s \n\n", displayWord);
                fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
                fprintf("Chances: %d\n\n", turns);
                fprintf("Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
                guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
                fprintf("\n");
                guessedLetter = lower(guessedLetter);
                clc;

            else

                %if guess is wrong, user runs out of chances and loses
                fprintf("The word to guess: %s \n\n", displayWord);
                wrongGuesses = [wrongGuesses, guessedLetter,','];              
                fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
                fprintf("Chances: 0\n\n");
                fprintf("That was wrong :( You have run out of chances and lost the game :( The word was: (%s)\n\n", finalWord);
                turns=0;
                again="*";
                
                %user asked to if they want to play again, accepts yer or
                %no only
                while again~="yes" && again ~="no"
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        disp("Please type in yes or no only");
                    end
                end
                break

            end
        end
    end

    %condition for when user has one last letter to guess right
    if count==Length-1
        while turns~=0 && count~=0 
            
            %if guess is right, correct guessed letters displayed
            if rightMatch(word,guessedLetter) 

                displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
                guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
                lengthLetters = length(strfind(word, guessedLetter));       
                word(strfind(word, guessedLetter)) = [];
                fprintf("The word to guess: %s \n\n", displayWord); 
                fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
                fprintf("Chances: %d\n\n", turns);

                %if all letters guessed right, user wins 
                if displayWord == finalWord             
                    fprintf("That was correct! You have guessed all the letters of the word correctly! You have won :)\n\n"); 
                    again="*";
                    
                    %user asked if they want to play again, accepts yes or no only
                    while again~="yes" && again ~="no"
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        disp("Please type in yes or no only");
                    end
                    end
                break

                else

                    %if last letter guessed right, user wins
                    fprintf("The word to guess: %s\n", finalWord);
                    fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
                    fprintf("Chances: %d\n\n", turns);
                    fprintf("That was correct! You have guessed all the letters of the word correctly! You have won :)\n\n");
                    count =0;  
                    clc
                end

            elseif ~validLetter(guessedLetter)

                 fprintf("The word to guess: %s \n\n", displayWord);
                 fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
                 fprintf("Chances: %d\n\n", turns);
                 fprintf("Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
                 guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
                 fprintf("\n");
                 guessedLetter = lower(guessedLetter);
                 clc;

            %if user is on their last turn and guessed wrong, user loses
            elseif turns==1

                 fprintf("The word to guess: %s \n\n", displayWord);
                 wrongGuesses = [wrongGuesses, guessedLetter,','];
                 fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
                 turns=0;
                 fprintf("Chances: %d\n\n", turns);
                 fprintf("That was wrong :( You have run out of chances and lost the game :( The word was (%s)\n\n", finalWord);
                 again="*";
                 
                 %user asked if they want to play again, accepts yer or no only
                while again~="yes" && again ~="no"
                    
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        disp("Please type in yes or no only");
                    end
                end
                break

            else

                %if guess is wrong, but more turns left, user asked to guess another letter
                 fprintf("The word to guess: %s \n\n", displayWord);
                 wrongGuesses = [wrongGuesses, guessedLetter,','];
                 fprintf("Your wrong guesses so far: (%s)\n\n", wrongGuesses);
                 fprintf("Chances: %d\n\n", turns-1);
                 fprintf("That was wrong :( You have %d turn(s) left\n", turns-1);
                 turns = turns-1;
                 guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
                 fprintf("\n");
                 guessedLetter = lower(guessedLetter);
                 clc
            end
        end
    end

end
