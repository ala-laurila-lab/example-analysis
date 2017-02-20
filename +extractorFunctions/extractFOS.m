function extractFOS(anaylsis, rstarGroup, varargin)

	ip = inputParser;
	ip.addParameter('binWidth', 0.01, @isnumeric);
	ip.addParameter('recordingOffset', 0.4, @isnumeric);
	ip.addParameter('recordingOnset', -0.4, @isnumeric);
	ip.addParameter('tag', 'stimTime', @isnumeric);

	ip.parse(varargin{:});
	binWidth = ip.Results.binWidth;
	recordingOnset = ip.Results.recordingOnset;
	recordingOffset = ip.Results.recordingOffset;
	tag = ip.Results.tag;

	import extractorFunctions.util.*;
	epochGroup = anaylsis.featureBuilder.find(tag, 'from', rstarGroup);
    [pre, post] = getPreAndPostSpikeCount(epochGroup, binWidth, recordingOnset, recordingOffset);
	
    indices = find(ismember(epochGroup.epochIndices, rstarGroup.epochIndices));
	fractionCorrect = calculateFOS(pre, post, indices);
	rstarGroup.createFeature('FRACTION_CORRECT', fractionCorrect);
end