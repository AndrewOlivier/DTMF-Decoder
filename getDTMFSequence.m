
function sequence = getDTMFSequence( rawKeys )
%Function to retrieve the actual sequence of DTMF tones represented by the
%data. The input is the data from the getRawKeys() function which will be a
%string representing the DTMF character from each frames

    % go through the whole string, if the current char is not a "_",
    % add that char to the output sequence and skip to the next "_"
    % char
    
    sequence = '';
    if (rawKeys(1) ~= '_')
        sequence = rawKeys(1);
    end
    for i = 2 : length(rawKeys)
        if (rawKeys(i) == '_' && rawKeys(i-1) ~= '_')
            sequence = strcat(sequence,' ');
        elseif (rawKeys(i) ~= rawKeys(i-1))
            sequence = strcat(sequence,rawKeys(i));
        end
        
    end %end of for loop
    
end %end of function
