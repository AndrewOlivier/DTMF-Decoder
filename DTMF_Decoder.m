%Decode audio file with DTMF Tones and return values

    [data,Fs] = audioread('abcd.wav');

    blocks = createBlocks(data);
    data = DetectTones(blocks,Fs);
    Values = getValues(data)