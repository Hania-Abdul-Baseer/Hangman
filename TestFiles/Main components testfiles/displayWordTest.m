%this program forms the displaying of the word as all astericks to hide it component of the hangman program
%replaces all letters of the word as astericks, to hide it

%taking input from user
word = input("Enter a word: ", "s");

%empty array
displayWord = [];

%dispalying all astericks to hide the word
    for i = 1:length(word)
        displayWord = [displayWord, '*'];
    end

%displaying the word with its letters hidden
disp(displayWord);

