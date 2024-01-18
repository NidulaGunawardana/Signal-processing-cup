function rawds = getRawSamplesDatastore(locraw)
% Helper function to create datastore for folder or "raw" recordings called
% "samples"
% 
% Copyright 2023 The MathWorks, Inc.

rawds = audioDatastore(locraw,'IncludeSubfolders', true);
rawlabs = folders2labels(rawds);
spkrlabs = extractBefore(string(rawlabs), "_");
runlabs = extractAfter(string(rawlabs), "_");
numruns = height(rawlabs);
roi = cell(numruns,1);
for krun = 1:numruns
    filename = fullfile(locraw,string(rawlabs(krun)),'annotations.txt');
    t = readtable(filename,ReadVariableNames=false,ReadRowNames=true);
    t.Properties.VariableNames = ["start","stop"];
    roi{krun} = t;
end
anno = table(spkrlabs,runlabs,roi);
anno.Properties.VariableNames = ["Speaker","Run","ROI"];
rawds.Labels = anno;