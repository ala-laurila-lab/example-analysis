function initializeLogger(fname)
    [~, deleteLogger] = logging.getLogger(sa_labs.analysis.app.Constants.ANALYSIS_LOGGER, 'path', 'test.log');
    deleteLogger();
    [log, ~] = logging.getLogger(sa_labs.analysis.app.Constants.ANALYSIS_LOGGER, 'path', [fname '.log']);
    log.setLogLevel(logging.logging.ALL);
    log.setCommandWindowLevel(logging.logging.DEBUG);
end