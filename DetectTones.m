
function tones  = DetectTones( blocks, Fs )
% Decode a given block matrix and give an output in the form a
% matrix with each column giving the magnitude of the each of the DTMF 
% signals in the corresponding block.
    
    % initialise the output matrix
    output = zeros(21,size(blocks,2));
        
    % ITU Specifications : Max allowed frequency tolerance = 1.5%
    
    %freq_low = [697 +/-10, 770 +/-12, 852 +/-13, 941 +/- 14];
    %freq_high = [1209 +/-18, 1336 +/- 20, 1477 +/- 22, 1633 +/- 24];
    fre = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
    
    freq_bin = [687,707,758,782,839,865,927,955,1191,1210,1227,1316,1336,1356,1455,1466,1499,1609,1620,1647,1657];
    freq_indices = round(freq_bin/Fs * size(blocks,1)) + 1;
    
    for i = 1:size(blocks,2)
        output(:,i) = abs(goertzel(blocks(:,i),freq_indices)); 
    end                                  
    
    %For each block of data the highest spectral peak for each DTMF
    %frequency must be chosen.
    
    tones = zeros(8,size(blocks,2));
    for f = 1:size(blocks,2) % for each frame
        tones(1,f) = max(output(1:2,f));       % 697Hz
        tones(2,f) = max(output(3:4,f));      % 770Hz
        tones(3,f) = max(output(5:6,f));      % 852Hz
        tones(4,f) = max(output(7:8,f));     % 941Hz
        tones(5,f) = max(output(9:11,f));    % 1209Hz
        tones(6,f) = max(output(12:14,f));    % 1336Hz
        tones(7,f) = max(output(15:17,f));    % 1477Hz
        tones(8,f) = max(output(18:21,f));    % 1633Hz
    end
   % size(blocks,2)
   % p=1;
    %for k = 1:976:size(blocks,2)
     %   subplot(4,1,p);
      %  stem(fre,tones(:,k))
       % ax = gca;
       % ax.XTick = fre;
       % xlabel('Frequency (Hz)');
       % title('DFT Magnitude');
       % p = p+1;
  %  end
    
end 