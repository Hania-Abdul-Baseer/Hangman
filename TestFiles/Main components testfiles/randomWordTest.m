%this program forms the random word generator component of the hangman program
%each time the program is run, a random word is generated, displayed and stored as an array of characters

%read in character arrays
dictText = fileread('dictionary.txt'); %dictionary.txt contains 996 words. Source: ENG1002 2021, Workshop 6 material

%split the text array into words
dictWords=splitlines(dictText); 
        
%build the dictionary from a text array
    
words=[]; % empty array
    
for i = [1:length(dictWords)]    
    
    % concatenate the string onto the end of the dictionary          
    words = [words string(dictWords(i))];       
end

%generating random number from 1 to 996, to be used as index of words array
randNum = randi([1,996],1);
word = char(words(randNum));

disp(word);
    
    




             
        



    
        