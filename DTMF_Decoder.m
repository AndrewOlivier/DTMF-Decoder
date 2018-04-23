%Decode audio file with DTMF Tones and return values

    [data,Fs] = audioread('dtmfN1.wav')
       
    blocks = createBlocks(data);
    tones = DetectTones(blocks,Fs);
    Values = getValues(tones)