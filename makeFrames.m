
function frames = makeFrames (data, Fs)
	%This function makes frames each of size "frame size" and returns
    %a matrix with each of the columns as a seperate frame for processing
    
    %each frame size must be about 32ms long
    %frame size must be a power of 2
    
%     if (Fs > 180000)
%         frameSize = 16384; % frame size is at max 45ms long at 180000Hz ... 21ms at 384000 Hz
%     elseif (Fs > 90000)
%         frameSize = 8192;
%     elseif (Fs > 45000)
%         frameSize = 4096;
%     elseif (Fs > 23000)
%         frameSize = 2048;
%     elseif (Fs > 11500)
%         frameSize = 1024;
%     else
%         frameSize = 512;
%     end

    frameSize = 370;

    if (length(data) < frameSize)
        frameSize = length(data);
        numFrames = 1;
    else
        numFrames = floor(length(data)/frameSize)*2 - 1;
    end

    % must preallocate memory for the output
    frames = zeros(frameSize,numFrames);   % number of frames (columns)
    %frames(:,1) = data(1:frameSize);                         % slice off the first frame
    
    col = 1;
    for i= 1 : floor(frameSize/2) : length(data)
        new =  data(i:i+frameSize-1);
        frames(:,col) = new;
        if (col == numFrames) % break when all the frames have been created
            break;
        end
        col = col+1;
        
    end % end of for loop
    
end % end of function
