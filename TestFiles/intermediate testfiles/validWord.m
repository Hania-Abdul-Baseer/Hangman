%this function takes the word as input and checks if its a valid word. ie, not a letter, number, blankspace, etc.

function[validity] = validWord(inputWord)

%converting word to character
inputWord = char(inputWord);

for i = 1:length(inputWord)
    
    %checks if the word contains empty spaces
    if isempty(inputWord(i)) 
        validity = false;
        break
        
    %checks if the word contains non letters
    elseif ~isletter(inputWord(i))
        validity = false;
        break
        
    %checks if the word contains spaces
    elseif isspace(inputWord(i))
        validity = false;
        break
        
    %if all checks passed, its a valid word
    else
        validity = true;
    end
end


%checks if the word as a whole is empty vector or isnt made up of letter
if isempty(inputWord)
    
    validity = false;
    
elseif ~isletter(inputWord)
    
    validity = false;
    
elseif length(inputWord)<=1
    
    validity = false;
    
end







