function auOut = churchRev(auIn,wetDryMix,sampleRate)
% Helper function to convolve the input signal, auIn, with a long impulse
% response of a church. The church impulse response ships as sample file 
% with Audio Toolbox
% 
% Copyright 2019-2023 The MathWorks, Inc.

    persistent irConvolver44p1 irConvolver48 irConvolver16
    if isempty(irConvolver44p1)
        partLen = 512;
        
        [h,irfs] = audioread('ChurchImpulseResponse-16-44p1-mono-5secs.wav');
        % Construct different IR versions based on
        % different sample rate choices
        irConvolver44p1 = dsp.FrequencyDomainFIRFilter(h',...
            'PartitionForReducedLatency',true,...
            'PartitionLength',partLen);
        % 48kHz
        h48 = audioresample(h,OutputRate=48e3,InputRate=irfs);
        irConvolver48 = dsp.FrequencyDomainFIRFilter(h48',...
            'PartitionForReducedLatency',true,...
            'PartitionLength',partLen);
        % 16kHz
        h16 = audioresample(h,OutputRate=16e3,InputRate=irfs);
        irConvolver16 = dsp.FrequencyDomainFIRFilter(h16',...
            'PartitionForReducedLatency',true,...
            'PartitionLength',partLen);
        
    end
    switch sampleRate
        case 44100
            auPad = [auIn;zeros(size(auIn,1)+length(irConvolver44p1.Numerator),size(auIn,2))];
            auOut = irConvolver44p1(auPad);
            reset(irConvolver44p1)
        case 48000
            auPad = [auIn;zeros(size(auIn,1)+length(irConvolver48.Numerator),size(auIn,2))];
            auOut = irConvolver48(auPad);
            reset(irConvolver48)
        case 16000
            auPad = [auIn;zeros(size(auIn,1)+length(irConvolver16.Numerator),size(auIn,2))];
            auOut = irConvolver16(auPad);
            reset(irConvolver16)
        otherwise
            auPad = auIn;
            auOut = auIn;
            disp('Warning: IR not available for selected sample rate. churchReverb not applied')
    end
    
    % Wet/dry mix
    auOut = wetDryMix * auOut + (1-wetDryMix) * auPad ;
    
end