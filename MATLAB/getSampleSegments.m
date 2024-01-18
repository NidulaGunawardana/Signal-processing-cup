function [dataOut,infoOut] = getSampleSegments(audio, infoIn)
% Helper function to create datastore returning:
% * Content of recordings in "samples" folder
% * Only speaker segments, as segmented in accompanying annotations
% * Only data channels 4 and 5 (respectvely in columns 1 and 2 of each
%   segment)
% * (Individual segments are returned in cells of a cell array)
% 
% Copyright 2023 The MathWorks, Inc.

fs = infoIn.SampleRate;
auinfo = audioinfo(infoIn.FileName);
startstopTimes = infoIn.Label.ROI{1}{:,:};
startstopSamples = round(fs * startstopTimes);
numsegs = height(startstopTimes)-1;
dataOut = cell(1,numsegs);
for kseg = 1:numsegs-1
    dataOut{kseg} = audio(startstopSamples(kseg+1,2):startstopSamples(kseg+2,1),4:5);
end
dataOut{numsegs} = audio(startstopSamples(numsegs+1,1):auinfo.TotalSamples,4:5);
infoOut = infoIn;
infoOut.ChannelLabels = ["Channel4","Channel5"];
