function micarray=micarrayInit()
    micarray.NB_MICROPHONES=7;
    micarray.signals.SAMPLES_PER_FRAME = 400;%25ms*16K
    micarray.signals.shiftSize=100;%400*1/4;
    micarray.signals.SAMPLES_PER_BATCH = 4000;%250ms*16K
    micarray.signals.framedata = zeros(micarray.signals.SAMPLES_PER_FRAME,micarray.NB_MICROPHONES)';
    micarray.signals.batchdata = zeros(micarray.signals.SAMPLES_PER_BATCH,micarray.NB_MICROPHONES)';
    % Samples for train CGMM;400 X 40 X 7;freq  X number_samples X dimensions;
    micarray.signals.batchfreq = zeros(micarray.signals.SAMPLES_PER_FRAME,...
        micarray.signals.SAMPLES_PER_BATCH/micarray.signals.shiftSize,micarray.NB_MICROPHONES);
    micarray.signals.sizeDataSet = size(micarray.signals.batchfreq);
end
