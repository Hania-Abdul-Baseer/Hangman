%this program forms the component of the program hangman that displays results so far only after a correct guess is made
%when a correct letter is guessed then the correct letters are displayed in the word along with results showing 
%how many chances are left and what wrong guesses were made so far

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

if rightMatch(word,guessedLetter)
    
    %displays correct guessed letters in the word
    displayWord(strfind(guessedWord, guessedLetter)) = guessedLetter;  
    
    %removes the correctly guessed letter from the word so it is not guessed again
    guessedWord(strfind(guessedWord,guessedLetter)) = '*';                   
    lengthLetters = length(strfind(word, guessedLetter));                   
    word(strfind(word, guessedLetter)) = [];
                     
    %Yair Altman (2021). cprintf - display formatted colored text in Command Window (https://www.mathworks.com/matlabcentral/fileexchange/24093-cprintf-display-formatted-colored-text-in-command-window), MATLAB Central File Exchange. Retrieved April 15, 2021.            
    cprintf('red',"The word to guess: %s \n\n", displayWord);             
    cprintf('magenta',"Wrong guesses: (%s)\n\n", wrongGuesses);            
    cprintf('magenta',"Chances: %d\n\n", turns);

    fprintf("That was correct!\n");
end
                  
    