function signals = batchTime2Freq(signals,NB_MICROPHONES)
	batchfreq=zeros(signals.SAMPLES_PER_FRAME,NB_MICROPHONES,signals.SAMPLES_PER_BATCH/signals.shiftSize);
	for Index=1:signals.SAMPLES_PER_BATCH/signals.shiftSize-3
		signals.framedata = signals.batchdata(:,(Index-1)*signals.shiftSize+1:signals.SAMPLES_PER_FRAME+(Index-1)*signals.shiftSize);
		signals = frameTime2Freq(signals);
		batchfreq(:,:,Index)=signals.framedata_freq';
    end
    signals.batchfreq = batchfreq;

end

function signals = frameTime2Freq(signals)
	[sizeArray,~] = size(signals.framedata);
	% get the xtime_windows
	signals.framedata_windowed = signals.framedata.*repmat(hann(signals.SAMPLES_PER_FRAME)',sizeArray,1);
	% get fft of xtime_windows
	signals.framedata_freq = fft(signals.framedata_windowed); 
end