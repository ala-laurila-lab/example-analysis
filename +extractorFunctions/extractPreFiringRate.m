function extractPreFiringRate(group)

	indices = rstarGroup.getParameter('SPIKE_TIME_FEATURE');
	spikeTimes = extractorFunctions.util.toSeconds(indices, rstarGroup);
	
	preSpikeTimes = spikeTimes(spikeTimes < 0);
	preTime = featureGroup.getParameter('preTime') * 10 ^-3;
	preFiringRate = preSpikeCount / preTime;
	group.createFeature('PRE_FIRING_RATE', preFiringRate);
end
