function extractPreFiringRate(analysis, group)

	indices = group.getFeatureData('SPIKE_TIME_FEATURE');
    
    if ~ iscell(indices)
        indices = {indices};
    end
    
    for i = 1 : numel(indices)
        spikeTimes = extractorFunctions.util.toSeconds(indices{i}, group);
        preSpikeTimes = spikeTimes(spikeTimes < 0);
        preTime = group.getParameter('preTime') * 10 ^-3;
        preFiringRate = preSpikeTimes / preTime;
        group.createFeature('PRE_FIRING_RATE', preFiringRate);
    end
end
