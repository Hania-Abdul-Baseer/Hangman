%this program forms the choosing of game mode component of the hangman program
%asks user if they want to continue game as one player or two player and game is continued according to the mode chosen

fprintf("Game mode: One player and two player.\n"); 
    
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

            %creating a random integer from 1 to 996, to be used as the index of the words array
            randNum = randi([1,996],1);
            word = char(words(randNum));
            fprintf("The word to guess is: %s \n", word);

        %if player chooses two player
        elseif mode == "2"
            clc
            %ask input from the first player to store the word that needs to be guessed by the other player 
            word = input("Please enter the word that needs to be guessed by the other player: ", "s");

            %converting the stored word in lower letters
            word = lower(word);

            %checking if the input for word is valid
            while ~validWord(word)
                
                %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
                %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window),
                %MATLAB Central File Exchange. Retrieved April 15, 2021.
                cprintf('err', "Error: please type in a valid word. (i.e, no single letter, special characters, blank space, numbers, more than one word, etc.)\n\n");
                word = input("Please enter the word that needs to be guessed by the other player: ", "s");
                word = lower(word);
            end
            
        %making sure to accept 1 or 2 as answers
        else  
            %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
            %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
            %MATLAB Central File Exchange. Retrieved April 15, 2021.
            cprintf('err',"Error: please type 1 or 2\n");
        end
    end