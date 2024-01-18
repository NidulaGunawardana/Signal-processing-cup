function [dataOut,infoOut] = getSampleSegment5(audio, infoIn)
% Helper function to create datastore returning 5th speaker segment, for 
% one file at a time, segmented as specified in the annotations 
% accompanying the data. Only data channels 4 and 5 are returned, 
% respectvely in columns 1 and 2
% 
% Copyright 2023 The MathWorks, Inc.

fs = infoIn.SampleRate;
startstopTime4 = infoIn.Label.ROI{1}{"4",:};
startstopSamples4 = round(fs * startstopTime4);
auinfo = audioinfo(infoIn.FileName);
stopSamples5 = auinfo.TotalSamples;
dataOut = audio(startstopSamples4(2):stopSamples5,4:5);
infoOut = infoIn;
infoOut.ChannelLabels = ["Channel4","Channel5"];
