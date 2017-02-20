function [pre, post] = getPreAndPostSpikeCount(group, binWidth, recordingOnset, recordingOffset)

    import extractorFunctions.util.*;
    spikeTimeIndices = group.getFeatureData('SPIKE_TIME_FEATURE');
    spikeCount = [];

    if ~ iscell(spikeTimeIndices)
        spikeTimeIndices = {spikeTimeIndices};
    end

    for i = 1 : numel(spikeTimeIndices)
        spikeTimes = toSeconds(spikeTimeIndices{i}, group);
        timeAxis_right = 0 : binWidth : recordingOffset;
        timeAxis_left = -binWidth : -binWidth : recordingOnset;
        timeAx = [timeAxis_left(end: -1: 1) timeAxis_right];
        spikeCount(i, :) = histc(spikeTimes, timeAx'); %#ok
    end
    pre = spikeCount(:, timeAx < 0);
    post = spikeCount(:, timeAx > 0);
end