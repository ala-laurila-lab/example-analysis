function  copyTagsFromOldAnalysis(data, oldData)
import sa_labs.analysis.entity.*

if nargin < 2
    symphony_v1.util.loadClasspath();
    
    global ANALYSIS_FOLDER;
    file = fullfile(ANALYSIS_FOLDER, 'cellData', data.savedFileName);
    reuslt = load(file);
    oldData = reuslt.cellData;
end
description = FeatureDescription(containers.Map('id', 'SPIKE_TIME'));

for i = 1 : numel(oldData.epochs)
    oldEpoch = oldData.epochs(i);
    keys = setdiff(oldEpoch.attributes.keys, data.epochs(i).attributes.keys);
    
    for j = 1 : numel(keys)
        
        if strcmp(keys{j}, 'spikes_ch1')
            spikeTime = oldEpoch.attributes('spikes_ch1');
            data.epochs(i).attributes('SPIKE_TIME_FEATURE') = Feature(description, spikeTime);
        else
            data.epochs(i).attributes(keys{j}) = oldEpoch.attributes(keys{j});
        end
    end
end
end
