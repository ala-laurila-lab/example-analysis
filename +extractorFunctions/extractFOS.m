function extractFOS(anaylsis, rstarGroup, varargin)

	ip = inputParser;
	ip.addParameter('binWidth', 0.01, @isnumeric);
	ip.addParameter('recordingOffset', -0.04, @isnumeric);
	ip.addParameter('recordingOnset', 0.04, @isnumeric);

	ip.parse(varargin{:});
	binWidth = ip.Results.binWidth;
	recordingOnset = ip.Results.recordingOnset;
	recordingOffset = ip.Results.recordingOnset;

	import extractorFunctions.util.*;

	epochGroup = anaylsis.find('EpochGroup');
	spikeTimeIndices = epochGroup.getParameter('SPIKE_TIME_FEATURE');
	spikeTimes = toSeconds(spikeTimeIndices, rstarGroup);

	leftTimeAxis = 0 : binWidth : recordingOffset;
	rightTimeAxis = -binWidth : -binWidth : recordingOnset;
	time = [leftTimeAxis(end: -1: 1) rightTimeAxis];

	spikeCount = histc(spikeTimes, time);
	preSpikeCount = spikeCount(time < 0);
	postSpikeCount = spikeCount(time > 0);

	indices = find(ismember(epochGroup.epochIndices, rstarGroup.epochIndices));
	fractionCorrect = calculateFOS(preSpikeCount, postSpikeCount, indices)
	rstarGroup.createFeature('FRACTION_CORRECT', fractionCorrect);
end