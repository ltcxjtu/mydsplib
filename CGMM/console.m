clear all;
clc;
micarray=micarrayInit();
SAMPLES_PER_FRAME= micarray.signals.shiftSize;%25ms*16K/4
NB_MICROPHONES=micarray.NB_MICROPHONES;
RAW_BUFFER_SIZE=SAMPLES_PER_FRAME*NB_MICROPHONES;
audio_float_data=zeros(NB_MICROPHONES,SAMPLES_PER_FRAME);
fileId = fopen('smallroom1.pcm','r');
audio_raw_data = fread(fileId,inf,'int16');
nFrame=round(length(audio_raw_data)/(SAMPLES_PER_FRAME*NB_MICROPHONES));
frameNumber=1;
for frameNumber=1:nFrame-1
	fprintf('frameNumber,%d \n',frameNumber);
	for channel=1:NB_MICROPHONES
		audio_float_data(channel,:)=audio_raw_data(channel+NB_MICROPHONES*...
            (0:SAMPLES_PER_FRAME-1)+(frameNumber-1)*NB_MICROPHONES*SAMPLES_PER_FRAME);
    end
    micarray.signals = dataUpdate(micarray.signals,SAMPLES_PER_FRAME,audio_float_data); 
    micarray.signals = batchTime2Freq( micarray.signals,NB_MICROPHONES);
end