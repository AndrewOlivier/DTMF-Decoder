 filename = 'abcd.wav';
% Function to decode an audio file with DTMF Tones and return the sequence
    if (isstr(filename))
        [data,Fs] = audioread(filename);
    else 
       data = filename;
       Fs = 8000;
    end
    frames = makeFrames(data, Fs);
    dft_data = transformFrames(frames,Fs);
    rawSequence = getRawKeys(dft_data);
    DTMFSequence = getDTMFSequence(rawSequence)
