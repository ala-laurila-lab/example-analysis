function [pre, post] = getPreAndPostSpikeCount(spikeTimes, currentEpochGroup, binWidth, recordingOnset, recordingOffset)

    sampleRate = cellData.epochs(currentEpochGroup(1)).attributes('sampleRate');
    spikeCount = [];

    for i = 1 : numel(currentEpochGroup)
        [spikeTimes, timeAxis] = cellData.epochs(currentEpochGroup(i)).getSpikes;
        stimulusStartIdx = find(round(timeAxis, 4) == 0);
        spikeTimes = spikeTimes - stimulusStartIdx;
        spikeTimes = spikeTimes / sampleRate;
        
        timeAxis_right = 0 : binWidth : recordingOffset;
        timeAxis_left = -binWidth : -binWidth : recordingOnset;
        timeAx = [timeAxis_left(end: -1: 1) timeAxis_right];
        
        spikeCount(i, :) = histc(spikeTimes, timeAx); %#ok
    end

    % Filter the matrix to get prepoints and postpoints >0->post, <0 prepoints
    preTimeIdx = find(timeAx < 0);
    postTimeIdx = find(timeAx > 0);

    pre = zeros(numel(dataSet), numel(preTimeIdx));
    post = zeros(numel(dataSet), numel(postTimeIdx));
    
    for i = 1 : size(spikeCount, 1)
        pre(i, :) = spikeCount(i, preTimeIdx);
        post(i, :) = spikeCount(i, postTimeIdx);
    end
end