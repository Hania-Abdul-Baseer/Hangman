%Version 6 of hangman, with more accurate commenting, style, user interface and variable names
%cprintf function used to display game details to user in color

%this program is a two player hangman game. The first player needs to type in the word that will then be guessed by the other player, 
%letter by letter, and they have 6 chances before they lose.
%the program displays truns left, wrong guesses and the word to be guessed with correct guesses shown and the rest of the word hidden
%player can play multiple times and program only accepts valid word, letters and yes or no when asked if they want to play again

%initializing rematch value as one so the game runs atleast once 
rematch=1;

%user can play multiple games, program runs until user does not want to play again 
while rematch==1
    
    %clear all variables and workspace at the start of every game
    clear ALL;
    clc;
    
    %initializing vectors and values
    guessedWord = [];
    guessedLetter = [];
    wrongGuesses = [];
    displayWord = [];
    turns = 6;
    count = 0;

    %ask input from the first player to store the word that needs to be guessed by the other player 
    word = input("Please enter the word that needs to be guessed by the other player: ", "s");
    
    %converting the stored word in lower letters
    word = lower(word);

    %checking if the input for word is valid
    while ~validWord(word)
        cprintf('err', "Error: please type in a valid word. (i.e, no single letter, special characters, blank space, numbers, more than one word, etc.)\n\n");
        word = input("Please enter the word that needs to be guessed by the other player: ", "s");
        word = lower(word);
    end  
    
    clc

    %making copies of the word and storing its length
    Length = length(word);
    guessedWord = lower(word);
    finalWord = lower(word);

    %dispalying all astericks to hide the word
    for i = 1:length(word)
        displayWord = [displayWord, '*'];
    end

    %small intro to game and details about the word to player
    fprintf("The word to guess: %s\n\n", displayWord);
    fprintf("You have to guess a %d letter word and you have 6 chances\n", length(word));
    guessedLetter = input("Please guess a letter that belongs to the word: ", "s");
    fprintf("\n");
    guessedLetter = lower(guessedLetter); %letter converted to its lower
    clc %clear command window

    %checking if the guessed letter is right until only one letter to guess is left or turns left is one or less
    while (turns>1 && count~=Length-1) 

        %using function: rightMatch check the correctness of the letter, if right displays the letter  
        if rightMatch(word,guessedLetter) && validLetter(guessedLetter)

            displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
            guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
            lengthLetters = length(strfind(word, guessedLetter));       
            word(strfind(word, guessedLetter)) = [];
            
            %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
            %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
            %MATLAB Central File Exchange. Retrieved April 15, 2021.
            fprintf("The word to guess: %s \n\n", displayWord); 
            cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
            cprintf('magenta',"Chances: %d\n\n", turns);

            %if all similar letters guessed right, player wins  
            if displayWord == finalWord 
                fprintf("That was correct!\nYou have guessed all the letters of the word correctly! You have won :)\n\n"); 
                
                again="*"; %setting a non yes/no value for again so program asks for rematch atleast once
                
                %ask user if they want to play again, only accepts yes or no
                while again~="yes" && again ~="no"
                    
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                        %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                        %MATLAB Central File Exchange. Retrieved April 15, 2021.
                        cprintf('err',"Error: please type yes or no only\n");
                    end
                end
                break
            else

                %if letter is correct add value to count 
                count = count+lengthLetters;
                fprintf("That was correct!\n");
                guessedLetter=input("Please guess another letter that belongs to the word: ", "s");
                fprintf("\n");
                
                guessedLetter = lower(guessedLetter); %converting letter to lower letter     
                clc %clear command window

            end

        %check the validity of the letter using functin: validLetter
        elseif ~validLetter(guessedLetter)

            %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
            %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
            %MATLAB Central File Exchange. Retrieved April 15, 2021.
             fprintf("The word to guess: %s \n\n", displayWord);
             cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
             cprintf('magenta',"Chances: %d\n\n", turns);
             cprintf('err', "Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
             guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
             fprintf("\n");
             
             guessedLetter = lower(guessedLetter); %converting letter to lower letter  
             clc; %clear command window

        else

            %if letter guessed is incorrect subtract from 1 from turns left and display result
             turns = turns - 1;
             
             %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
             %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
             %MATLAB Central File Exchange. Retrieved April 15, 2021.
             fprintf("The word to guess: %s \n\n", displayWord);
             wrongGuesses = [wrongGuesses, guessedLetter,','];
             cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
             cprintf('magenta',"Chances: %d\n\n", turns);
             fprintf("That was wrong :(\n");
             guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
             fprintf("\n");
             
             guessedLetter = lower(guessedLetter);  %converting letter to lower letter  
             clc;  %clear command window

        end
    end

    %condition when user is in their last turn
    if turns==1
        while (count~=Length-1 && turns~=0) 
            
            %function: rightMatch checks if letter typed is correct, correct guessed letters displayed 
            %and displays other results so far
            if rightMatch(word, guessedLetter)

                displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
                guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
                lengthLetters = length(strfind(word, guessedLetter));       
                word(strfind(word, guessedLetter)) = [];
                
                %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                %MATLAB Central File Exchange. Retrieved April 15, 2021.
                fprintf("The word to guess: %s \n\n", displayWord); 
                cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
                cprintf('magenta',"Chances: %d\n\n", turns);

                %if all letters guessed right, player wins
                if displayWord == finalWord             
                    fprintf("That was correct!\nYou have guessed all the letters of the word correctly! You have won :)\n\n"); 
                    
                    again="*"; %setting again value as non yes or no so program asks user for rematch atleast once
                    
                    %ask user if they want to play again, accepts yes or no only
                    while again~="yes" && again ~="no"
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                        %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                        %MATLAB Central File Exchange. Retrieved April 15, 2021.
                        cprintf('err',"Error: please type in yes or no only.\n");
                    end
                    end
                break

                else

                    %if guess is right, but more letters left, user asked for next guess
                    count = count+lengthLetters;
                    fprintf("That was correct!\n");
                    guessedLetter=input("Please guess another letter that belongs to the word: ", "s");
                    fprintf("\n");
                    guessedLetter = lower(guessedLetter);      
                    clc
                end

            %function:validLetter checks validity of letter 
            elseif ~validLetter(guessedLetter)

                %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                %MATLAB Central File Exchange. Retrieved April 15, 2021.
                fprintf("The word to guess: %s \n\n", displayWord); 
                cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
                cprintf('magenta',"Chances: %d\n\n", turns);
                cprintf('err', "Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
                
                guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
                fprintf("\n");
                guessedLetter = lower(guessedLetter);
                clc;

            else

                %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                %MATLAB Central File Exchange. Retrieved April 15, 2021.
                fprintf("The word to guess: %s \n\n", displayWord); 
                wrongGuesses = [wrongGuesses, guessedLetter,','];              
                cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
                cprintf('magenta',"Chances: 0\n\n");
                
                %if letter is wrong, player loses, and asked if they want to play again, accepts yes or no only
                fprintf("That was wrong :(\nYou have run out of chances and lost the game :( The word was: (%s)\n\n", finalWord);
                turns=0;
                
                again="*"; %setting again as no yes or no so program asks user for rematch atleast once
                
                while again~="yes" && again ~="no"
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                        %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window),
                        %MATLAB Central File Exchange. Retrieved April 15, 2021.
                        cprintf('err', "Please type in yes or no only\n");
                    end
                end
                break
            end
        end
    end

    %condition for whenonly one letter is left to be guessed right
    if count==Length-1
        while turns~=0 && count~=0 
            
            %rightMatch function checks if letter is correct
            if rightMatch(word,guessedLetter) 

                displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;
                guessedWord(strfind(guessedWord,guessedLetter)) = '*';       
                lengthLetters = length(strfind(word, guessedLetter));       
                word(strfind(word, guessedLetter)) = [];
                
                %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                %MATLAB Central File Exchange. Retrieved April 15, 2021.
                fprintf("The word to guess: %s \n\n", displayWord); 
                cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
                cprintf('magenta',"Chances: %d\n\n", turns);

                %if last letter is correct, player wins and asked if they want to play again, accepts yes or no only
                if displayWord == finalWord             
                    fprintf("That was correct!\nYou have guessed all the letters of the word correctly! You have won :)\n\n"); 
                    
                    again="*"; %setting again as non yes or no so program asks user for rematch atleast once
                    
                    while again~="yes" && again ~="no"
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        
                        %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                        %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                        %MATLAB Central File Exchange. Retrieved April 15, 2021.
                        cprintf('err', "Error: Please type in yes or no only\n");
                    end
                    end
                break

                else

                    %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                    %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                    %MATLAB Central File Exchange. Retrieved April 15, 2021.
                    fprintf("The word to guess: %s \n\n", finalWord); 
                    cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
                    cprintf('magenta',"Chances: %d\n\n", turns);
                    
                    fprintf("That was correct!\nYou have guessed all the letters of the word correctly! You have won :)\n\n");
                    count =0;  
                    clc
                end

            %validLetter function checks validity of letter 
            elseif ~validLetter(guessedLetter)

                 %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                 %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window),
                 %MATLAB Central File Exchange. Retrieved April 15, 2021.
                 fprintf("The word to guess: %s \n\n", displayWord); 
                 cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
                 cprintf('magenta',"Chances: %d\n\n", turns);
                 cprintf('err',"Error: Please type in one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
                 
                 guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
                 fprintf("\n");
                 guessedLetter = lower(guessedLetter);
                 clc;

            %if only one turn left and its a wrong guess, player loses and asked if they want to play again, accepts yes or no only 
            elseif turns==1
                
                %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                %MATLAB Central File Exchange. Retrieved April 15, 2021.
                 fprintf("The word to guess: %s \n\n", displayWord);
                 wrongGuesses = [wrongGuesses, guessedLetter,','];
                 cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
                 turns=0;
                 cprintf('magenta',"Chances: 0\n\n");
                 fprintf("That was wrong :(\nYou have run out of chances and lost the game :( The word was (%s)\n\n", finalWord);
                 
                 again="*"; %again set as non yes or no so program asks for rematch atleast once
                 
                while again~="yes" && again ~="no"
                    again = input("Do you want to play again?: ", "s");
                    again = lower(again);
                    
                    if again=="yes"
                        rematch = 1;
                        
                    elseif again == "no"
                        rematch = 0;
                        
                    else
                        %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                        %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window),
                        %MATLAB Central File Exchange. Retrieved April 15, 2021.
                        cprintf('err', "Error: please type in yes or only.\n");
                    end
                end
                break

            %if player guesses wrong but has more turns left, results displayed and player asked to type a new guess
            else

                %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                %MATLAB Central File Exchange. Retrieved April 15, 2021.
                 fprintf("The word to guess: %s \n\n", displayWord);
                 wrongGuesses = [wrongGuesses, guessedLetter,','];
                 cprintf('red',"Wrong guesses: (%s)\n\n", wrongGuesses);
                 cprintf('magenta',"Chances: %d\n\n", turns-1);
                 
                 fprintf("That was wrong :(\n");
                 turns = turns-1;
                 guessedLetter = input("Please guess another letter that belongs to the word: ", "s");
                 fprintf("\n");
                 guessedLetter = lower(guessedLetter);
                 clc
            end
        end
    end
end