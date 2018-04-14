
function blocks = createBlocks (data)
	%Make blocks of size "block size" and return
    %a matrix with each of the columns as a seperate block for processing
    Fs=8000;
    blockSize = 400;

    if (length(data) < blockSize)
        blockSize = length(data);
        nBlocks = 1;
    else
        nBlocks = floor(length(data)/blockSize)*2 - 1;
    end

    % Preallocate memory for the output
    blocks = zeros(blockSize,nBlocks); 
    
    col = 1;
    
    for i= 1 : floor(blockSize/2) : length(data)
        new =  data(i:i+blockSize-1);
        blocks(:,col) = new;      
        if (col == nBlocks) % break when all the blocks have been created
            break;
        end
        col = col+1;
        
    end 
    
        figure
        a_plot = new(:,1);
        plot(a_plot); xlabel('Samples'); ylabel('Amplitude');
    
end 