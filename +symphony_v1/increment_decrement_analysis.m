%% Application initialization
clear;
pause(1);

IDENTIFIER = 'icnrement-decrement';
initializeLogger(IDENTIFIER);
import sa_labs.analysis.*;

configPath = which('ExampleAnalysisContext');
obj.beanFactory = mdepin.getBeanFactory(configPath);
offlineAnalysisManager = obj.beanFactory.getBean('offlineAnalaysisManager');

%% step 1) create project

project = entity.AnalysisProject();
project.identifier = IDENTIFIER;
project.analysisDate = datestr(now, 'dd.mm.yyyy');
project.experimentDate = datestr(datetime(2017, 01, 31), 'mmddyy');
project.performedBy = 'sanna';

% add new cell files over here 
project.addCellData('013117Ac2');

% create project
preProcessors = {@(d) addRstarMean(d.epochs,  d.savedFileName),...
    @(d) symphony_v1.util.copyTagsFromOldAnalysis(d)};
offlineAnalysisManager.createProject(project, preProcessors);

%% pre processing 
% add r* mean to the epoch data, see SymphonyAnalysis_PAL\utilities\addRstarMean.m
data = project.getCellData('013117Ac2');
offlineAnalysisManager.preProcess(data, preProcessors, 'enabled', [false, true]);

%% step 2) do analysis

analysisPreset = struct();
analysisPreset.type = 'icnrement-decrement-analysis';
analysisPreset.buildTreeBy = {'EpochGroup', 'RstarMean'};
analysisPreset.RstarMean.featureExtractor = {'@(b, f) extractorFunctions.incrementDecrementAnalysis(b, f)'};

analysisProtocol = core.AnalysisProtocol(analysisPreset);

tic;
project = offlineAnalysisManager.doAnalysis('icnrement-decrement', analysisProtocol);
result = project.getAllresult();
toc;
