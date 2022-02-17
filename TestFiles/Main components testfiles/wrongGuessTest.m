%%this program forms the component of the program hangman that displays results so far after a wrong guess is made
%when a wrong letter is guessed then the a turn is lost and results showing the word to guess, chances left 
%and what wrong guesses were made so far are displayed

%taking input from user
word = input("Enter the word: ", "s");

%empty array
displayWord = [];

%dispalying all astericks to hide the word
    for i = 1:length(word)
        displayWord = [displayWord, '*'];
    end

%initializing values
guessedWord = [];    
guessedLetter = [];    
wrongGuesses = [];        
turns = 6;   
count = 0;

%making a copy of the word
guessedWord = word;

%taking input from user, of their guess
guessedLetter = input("Please guess a letter that belongs to the word: ", "s");
fprintf("\n");
guessedLetter = lower(guessedLetter); %letter converted to its lower

if ~rightMatch(word,guessedLetter) 
    
    %if letter guessed is incorrect subtract from 1 from turns left and display result            
    turns = turns - 1;
    
    %Yair Altman (2021). cprintf - display formatted colored text in Command Window 
    %(https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), 
    %MATLAB Central File Exchange. Retrieved April 15, 2021.                
    cprintf('red',"The word to guess: %s \n\n", displayWord); 
    
    %adding the wrong guess to wrongGuesses array for display to user
    wrongGuesses = [wrongGuesses, guessedLetter,','];                             
    cprintf('magenta',"Wrong guesses: (%s)\n\n", wrongGuesses);          
    cprintf('magenta',"Chances: %d\n\n", turns);
    
    fprintf("That was wrong :(\n");
end

    
    
    
    
    
    
    
    
    
  
    
   
                  











