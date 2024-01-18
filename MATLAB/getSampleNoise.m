function [dataOut,infoOut] = getSampleNoise(audio, infoIn)
% Helper function to create datastore returning the noise segment at the
% start of the recording, for one file at a time, segmented as specified 
% in the annotations accompanying the data. Only data channels 4 and 5 are 
% returned, respectvely in columns 1 and 2
% 
% Copyright 2023 The MathWorks, Inc.

fs = infoIn.SampleRate;
startstopTime = infoIn.Label.ROI{1}{"noise",:};
startstopSamples = round(fs * startstopTime);
dataOut = audio(startstopSamples(1):startstopSamples(2),4:5);
infoOut = infoIn;
infoOut.ChannelLabels = ["Channel4","Channel5"];
