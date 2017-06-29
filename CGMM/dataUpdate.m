function signals=dataUpdate(signals,shiftSize,newFrame)
    signals.framedata(:,(1:signals.SAMPLES_PER_FRAME - shiftSize))=...
       signals.framedata(:,(shiftSize+1:signals.SAMPLES_PER_FRAME)) ;
    signals.batchdata(:,(1:signals.SAMPLES_PER_BATCH - shiftSize))=...
       signals.batchdata(:,(shiftSize+1:signals.SAMPLES_PER_BATCH)) ;
    signals.framedata=[signals.framedata(:,(1:signals.SAMPLES_PER_FRAME - shiftSize)),newFrame];
    signals.batchdata=[signals.batchdata(:,(1:signals.SAMPLES_PER_BATCH - shiftSize)),newFrame];
end