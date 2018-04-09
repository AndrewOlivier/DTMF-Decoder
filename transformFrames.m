
function out  = transformFrames( frames, Fs )
% Function that decodes a given frame matrix and gives an output in the form a
% matrix with each column giving the magnitudes of the each of the DTMF 
% signals in the corresponding frame.
    
    % initialise the output matrix
    dft_data = zeros(21,size(frames,2));
    
    % the frequency bin includes each DTMF frequency +/- 1Hz in case the
    % spectral peak is not exactly by the DTMF frequency. The frequency
    % with the highest spectral peak out of the 3 frequencies will be used
    % for further analysis
    
    % ITU Specifications : Max allowed frequency tolerance = 1.5%
    
    %freq_low = [697 +/-10, 770 +/-12, 852 +/-13, 941 +/- 14];
    %freq_high = [1209 +/-18, 1336 +/- 20, 1477 +/- 22, 1633 +/- 24];
    %f_bin = [697, 770, 852, 941, 1209, 1336, 1477, 1633];
    %f_bin = [687:707, 758:782, 839:865, 927:955, 1191:1227, 1316:1356, 1455:1499, 1609:1657];
    %f_bin = [691,697,703,764,770,777,845,852,860,934,941,948,1200,1209,1220,1325,1336,1347,1466,1477,1488,1624,1633,1644];
    f_bin = [687,707,758,782,839,865,927,955,1191,1210,1227,1316,1336,1356,1455,1466,1499,1609,1620,1647,1657];
    
    indices = round(f_bin/Fs * size(frames,1)) + 1;
    %indices = [31,31,32,34,35,35,38,38,39,42,42,43,54,54,55,59,59,60,65,65,66,72,72,73]; %350
    %indices = [32,32,33,35,36,36,39,39,40,43,43,44,55,55,56,61,61,62,67,67,68,74,74,75]; %360
    %indices = [33,34,  36,37,   40,41, 44,45,   56,57,58,   62,63,64,   68,69,70,   75,76,77,78];
    
    for i = 1:size(frames,2)
        dft_data(:,i) = abs(goertzel(frames(:,i),indices)); 
    end                                   
    
    % must choose the highest spectral peak for each DTMF frequency
    out = zeros(8,size(frames,2));
    for f = 1:size(frames,2) % for each frame
        out(1,f) = max(dft_data(1:2,f));       % 697Hz
        out(2,f) = max(dft_data(3:4,f));      % 770Hz
        out(3,f) = max(dft_data(5:6,f));      % 852Hz
        out(4,f) = max(dft_data(7:8,f));     % 941Hz
        out(5,f) = max(dft_data(9:11,f));    % 1209Hz
        out(6,f) = max(dft_data(12:14,f));    % 1336Hz
        out(7,f) = max(dft_data(15:17,f));    % 1477Hz
        out(8,f) = max(dft_data(18:21,f));    % 1633Hz
    end
    
end % end of function
%         out(1,f) = max(dft_data(1:20,f));       % 697Hz
%         out(2,f) = max(dft_data(21:46,f));      % 770Hz
%         out(3,f) = max(dft_data(47:73,f));      % 852Hz
%         out(4,f) = max(dft_data(74:102,f));     % 941Hz
%         out(5,f) = max(dft_data(103:139,f));    % 1209Hz
%         out(6,f) = max(dft_data(140:180,f));    % 1336Hz
%         out(7,f) = max(dft_data(181:225,f));    % 1477Hz
%         out(8,f) = max(dft_data(226:274,f));    % 1633Hz


% out(1,f) = max(dft_data(1:3,f));       % 697Hz
%         out(2,f) = max(dft_data(4:6,f));      % 770Hz
%         out(3,f) = max(dft_data(7:9,f));      % 852Hz
%         out(4,f) = max(dft_data(10:12,f));     % 941Hz
%         out(5,f) = max(dft_data(13:15,f));    % 1209Hz
%         out(6,f) = max(dft_data(16:18,f));    % 1336Hz
%         out(7,f) = sum(dft_data(19:21,f));    % 1477Hz
%         out(8,f) = sum(dft_data(22:24,f));    % 1633Hz