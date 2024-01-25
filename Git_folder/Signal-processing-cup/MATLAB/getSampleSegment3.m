function [dataOut,infoOut] = getSampleSegment3(audio, infoIn)
% Helper function to create datastore returning 3rd speaker segment, for 
% one file at a time, segmented as specified in the annotations 
% accompanying the data. Only data channels 4 and 5 are returned, 
% respectvely in columns 1 and 2
% 
% Copyright 2023 The MathWorks, Inc.

fs = infoIn.SampleRate;
startstopTime2 = infoIn.Label.ROI{1}{"2",:};
startstopSamples2 = round(fs * startstopTime2);
startstopTime3 = infoIn.Label.ROI{1}{"3",:};
startstopSamples3 = round(fs * startstopTime3);
dataOut = audio(startstopSamples2(2):startstopSamples3(1),4:5);
infoOut = infoIn;
infoOut.ChannelLabels = ["Channel4","Channel5"];
