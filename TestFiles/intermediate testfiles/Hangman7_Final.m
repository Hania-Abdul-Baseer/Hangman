%Final version of hangman, the game can now be played in one and two player mode
%more accurate commenting, style, user interface and variable names
%cprintf function used to display game details to user in color

%This program is a test-based one and two player hangman game. 

%Two player mode - The first player needs to type in the word that will then need to be guessed by the other player, 
%letter by letter, and they have 6 chances before they lose.

%One player mode - Random word is generated from a text file containing 996 words and the player then needs to
%guess this word letter by letter and they have 6 chances before the lose

%The program displays turns left, wrong letters guessed and the word, with correct guesses shown 
%and the rest of the letters of the word hidden

%The user can play multiple times and the program only accepts valid word, letters and other inputs


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

    fprintf('~~~~~~~~~~~~~~~~HANGMAN~~~~~~~~~~~~~~~~~\n\n')
    fprintf('Game mode: One player and two player.\n\n'); 
    
    %setting game mode as non 1 or 2 so player is asked to choose game mode atleast once
    mode = "3";
    
    while mode~="1" && mode~="2"
        mode = input("Enter 1 for one player and 2 for two player: ", "s");

        %if player chooses one player, random word is generated from a dictionary file containing 996 words
        if mode == "1"
            clc
            
            %read in character arrays
            dictText = fileread('dictionary.txt'); %dictionary.txt file from ENG1002 2021 workshop 6 material
            
            %split the text array into words
            dictWords = splitlines(dictText); 
            
            %build the dictionary from a text array, starting with an empty array
            words=[]; 

            for i=[1:length(dictWords)] 
                
                % concatenate the string onto the end of the dictionary          
                words=[words string(dictWords(i))];     
            end

            %seeds the random number generator so different numbers
            %generated each time
            rng('shuffle');
            
            %creating a random integer from 1 to 996, to be used as the index of the words array
            randNum = randi([1,996],1);
            word = char(words(randNum));

        %if player chooses two player
        elseif mode == "2"
            clc
            %ask input from the first player to store the word that needs to be guessed by the other player 
            word = input("Enter the word that needs to be guessed by the other player: ", "s");

            %converting the stored word in lower letters
            word = lower(word);

            %checking if the input for word is valid
            while ~validWord(word)
                
                %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                %MATLAB Central File Exchange. Retrieved April 15, 2021.
                cprintf('err', "Error: please enter a valid word. (i.e, no single letter, special characters, blank space, numbers, more than one word, etc.)\n\n");
                word = input("Enter the word that needs to be guessed by the other player: ", "s");
                word = lower(word);
            end
            
        %making sure to accept 1 and 2 only
        else
            
            %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
            %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
            %MATLAB Central File Exchange. Retrieved April 15, 2021.
            cprintf('err',"Error: please enter 1 or 2.\n");
        end
    end
    clc
    
    %converting the stored word in lower letters
    word = lower(word); 
    
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
    guessedLetter = input("Enter your guess: ", "s");
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
                        cprintf('err',"Error: please enter yes or no.\n");
                    end
                end
                break
            else

                %if letter is correct add value to count 
                count = count+lengthLetters;
                fprintf("That was correct!\n");
                guessedLetter=input("Enter your guess: ", "s");
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
             cprintf('err', "Error: Please enter one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
             guessedLetter = input("Enter your guess: ", "s");
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
             guessedLetter = input("Enter your guess: ", "s");
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
                        cprintf('err',"Error: please enter yes or no.\n");
                    end
                    end
                break

                else

                    %if guess is right, but more letters left, user asked for next guess
                    count = count+lengthLetters;
                    fprintf("That was correct!\n");
                    guessedLetter=input("Enter your guess: ", "s");
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
                cprintf('err', "Error: Please enter one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
                
                guessedLetter = input("Enter your guess: ", "s");
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
                        cprintf('err', "Please enter yes or no\n");
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
                        cprintf('err', "Error: Please enter yes or no\n");
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
                 cprintf('err',"Error: Please enter one valid letter at a time. (i.e, no special characters, blankspace, word, numbers, etc.)\n");
                 
                 guessedLetter = input("Enter your guess: ", "s");
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
                        %Yair Altman (2021). cprintf - display formatted colored text in 
                        %Command Window (https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
                        %MATLAB Central File Exchange. Retrieved April 15, 2021.
                        cprintf('err', "Error: please enter yes or no.\n");
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
                 guessedLetter = input("Enter your guess: ", "s");
                 fprintf("\n");
                 guessedLetter = lower(guessedLetter);
                 clc
            end
        end
    end
end