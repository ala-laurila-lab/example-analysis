function t = toSeconds(indices, group)
	duration = extractorFunctions.util.getStimulusDuration(group);
	rate = featureGroup.getParameter('sampleRate');
	idx = min(abs(duration));
	t = (indices - idx(1)) / rate
end