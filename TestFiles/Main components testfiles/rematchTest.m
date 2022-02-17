%this program tests the rematch component of the hangman program. 
%Program should run again if user wants rematch and program will stop if user doesnt want a rematch

%setting rematch value as 1 so player is asked for a rematch atleast once
rematch = 1;

while rematch ==1
    again="*"; %setting a non yes/no value for again so program asks for rematch atleast once
                       
    %ask user if they want to play again, only accepts yes or no              
    while again~="yes" && again ~="no"  
        
        again = input("Do you want to play again?: ", "s");                    
        again = lower(again); %converting input to its lower for fair comparison   
        
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
end