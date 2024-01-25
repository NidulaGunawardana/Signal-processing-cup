function [dataOut,infoOut] = getSampleGreeting(audio, infoIn)
% Helper function to create datastore returning the robot greetings segment
% for one recording at a time, segmented as specified in the annotations
% accompanying the data. Only data channels 4 and 5 are returned, 
% respectvely in columns 1 and 2
% 
% Copyright 2023 The MathWorks, Inc.

fs = infoIn.SampleRate;
startstopTime = infoIn.Label.ROI{1}{"greeting",:};
startstopSamples = round(fs * startstopTime);
dataOut = audio(startstopSamples(1):startstopSamples(2),4:5);
infoOut = infoIn;
infoOut.ChannelLabels = ["Channel4","Channel5"];
