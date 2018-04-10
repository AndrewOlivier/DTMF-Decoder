function final_val = getValues( data  )
% Function to decode each of the frames to get the number represented by
% the data from the Goertzel Calculation. the argument "magData" is a
% vector with the magnitudes of each of the DTMF Frequencies in the frame
% they were extracted from.

% the output "rawKeys" will be the number represented by each frame. This
% has the numbers decoded from every frame present. frames that represent a
% "silence" will be shows as "_" strings

    init_val = repmat('~',[1,size(data,2)]);
    %freq_low = [697,770,582,941];
    %freq_high = [1209,1336,1477,1633];
    
    %go through each vector and first determine whether it is a silence or
    %an actual DTMF. if it is a silent, add '_' to the output. if it is not
    %a silence, get the indicies of the two highest peaks.

    % after some observation, noticed that the mean of the frames with DTMF
    % frequencies is much higher that the mean of "silent" frames,
    
    % find the 3 largest averages in the frames.
    % not efficient to go through the whole data set there
    % * get top 3 in the first 20 frames
    % * find average of those 3 peaks
    % * the silent frames will be frames with a mean that is less than 10%
    % of the average of the top 3 peaks.
    
    % get the top 3 frames from first 20
    if (length(data) >= 50)
        f20 = sort(mean(data(:,1:50)),'descend');
    else
        f20 = sort(mean(data),'descend');
    end
    
    % remove the frames with an avg of zero and use that array for the
    % averaging
    
    
    
    if (size(f20,2) < 6)
        avg = mean(f20(1));
    else
        avg = mean(f20(2:6)); % average of the top 5
    end
    
    % go through all the frames, decode frames with a mean greatere than
    % 10% of 'topAvg'
    
    for j = 1 : size(data,2) % for each decoded frame
        %get index of highest DTMF high and low frequencies
        if (mean(data(:,j)) < (0.66 * avg))
            init_val(j) = '_';
            
        else
            [a,low] = max(data(1:4,j));
            [a,high] = max(data(5:8,j));

            % find the corresponding frequencies
            if (low == 1) %low = 697
                if (high == 1)      %high = 1209
                    init_val(j) = '1';
                elseif (high == 2) %high = 1336
                    init_val(j) = '2';
                elseif (high == 3) %high = 1477
                    init_val(j) = '3';
                elseif (high == 4) %high = 1633
                    init_val(j) = 'A';
                end
            elseif (low == 2) %low = 770
                if (high == 1)      %high = 1209
                    init_val(j) = '4';
                elseif (high == 2) %high = 1336
                    init_val(j) = '5';
                elseif (high == 3) %high = 1477
                    init_val(j) = '6';
                elseif (high == 4) %high = 1633
                    init_val(j) = 'B';
                end
            elseif (low == 3) %low = 852
                if (high == 1)      %high = 1209
                    init_val(j) = '7';
                elseif (high == 2) %high = 1336
                    init_val(j) = '8';
                elseif (high == 3) %high = 1477
                    init_val(j) = '9';
                elseif (high == 4) %high = 1633
                    init_val(j) = 'C';
                end
            elseif (low == 4) %low = 941
                if (high == 1)      %high = 1209
                    init_val(j) = '*';
                elseif (high == 2) %high = 1336
                    init_val(j) = '0';
                elseif (high == 3) %high = 1477
                    init_val(j) = '#';
                elseif (high == 4) %high = 1633
                    init_val(j) = 'D';
                end
            end
        end
        
    end % end of loop through each frame
    

%Function to retrieve the actual sequence of DTMF tones represented by the
%data. The input is the data from the getRawKeys() function which will be a
%string representing the DTMF character from each frames

    % go through the whole string, if the current char is not a "_",
    % add that char to the output sequence and skip to the next "_"
    % char
    
    final_val = '';
    if (init_val(1) ~= '_')
        final_val = init_val(1);
    end
    for i = 2 : length(init_val)
        if (init_val(i) == '_' && init_val(i-1) ~= '_')
            final_val = strcat(final_val,' ');
        elseif (init_val(i) ~= init_val(i-1))
            final_val = strcat(final_val,init_val(i));
        end
        
    end %end of for loop
    
end %end of function