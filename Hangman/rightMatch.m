%this function is called rightMatch that takes the guessed letter as input and checks whether it belongs to the word

function[correct] = rightMatch(inputWord, inputLetter)
        
    if strfind(inputWord, inputLetter)>0            
        correct = true;
         
    else      
        correct = false;    
    end
end

     