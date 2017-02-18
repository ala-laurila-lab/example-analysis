function loadClasspath()
    
    global ANALYSIS_FOLDER
    ANALYSIS_FOLDER = 'D:\matlab-workspace\data\analysis\';
    global RAW_DATA_FOLDER
    RAW_DATA_FOLDER = 'D:\matlab-workspace\data\rawData\';
    global ANALYSIS_CODE_FOLDER
    ANALYSIS_CODE_FOLDER = 'D:\matlab-workspace\repo\becs\SymphonyAnalysis';
    global PREFERENCE_FILES_FOLDER
    PREFERENCE_FILES_FOLDER = 'D:\matlab-workspace\repo\becs\SymphonyAnalysis_PAL\resources\';
    addpath(genpath(ANALYSIS_CODE_FOLDER));
    addpath(genpath([fileparts(ANALYSIS_CODE_FOLDER) '\lib']));
end