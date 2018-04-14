%Decode audio file with DTMF Tones and return values

    [data,Fs] = audioread('dtmfN3.wav');
    
    plot(data); xlabel('Samples'); ylabel('Amplitude');   
       
    blocks = createBlocks(data);
    tones = DetectTones(blocks,Fs);
    Values = getValues(tones)