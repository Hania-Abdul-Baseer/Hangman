%this function takes the guessed letter as input and checks if its a valid letter. ie, not a word, number, blank space, etc.

function [validity] = validLetter(inputLetter)
 
%converting inputLetter to character
inputLetter = char(inputLetter);

    %checks if the letter is an empty space
    if isempty(inputLetter)  
        validity = false;
    
    %checks if the input is not a letter
    elseif ~isletter(inputLetter)        
       validity = false;
        
    %checks if the input contains more than one letter 
    elseif length(inputLetter)>1           
        validity = false;    
        
    else  
        %if all checks passed, its a valid letter
        validity = true;
        
    end
end

