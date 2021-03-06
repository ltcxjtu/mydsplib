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
    if frameNumber>=100
        % the number of freq;
        NB_freq = micarray.signals.SAMPLES_PER_FRAME;
        NB_Guass = 2;
        maxIter = 20;
        meane = 0;
        alphan  = 1/NB_Guass*ones(NB_Guass,1);
        for i = 1:NB_freq
            dataSet = micarray.signals.batchfreq(i,:,:);
            [lenc,lena,lenb] = size(dataSet);
            dataSet=reshape(dataSet,lena,lenb);
            % signal and noise spatial correlation matrics initial;
            R(:,:,1) = dataSet(lena/2,:)'*conj(dataSet(lena/2,:));
            R(:,:,2) = diag(ones(lenb,1),0);
            for Index=1:lena
                for i=1:NB_Guass
                    fai(Index,i) = 1/lenb*trace(dataSet(Index,:)'*conj(dataSet(Index,:))*R(:,:,i));
                end
            end	
            cgmm = cgmmInit(dataSet,NB_Guass,maxIter,meane,alphan,fai,R);
            cgmm=cgmmProcess(cgmm);
        end
    end
end