
function gmm=cgmmProcess(gmm)
	[len,dim] = size(gmm.dataSet);	
	for j=1:gmm.maxIter
		%% E step:
		for Index=1:len
			for i=1:gmm.NB_Guass
				P(Index,i) = gmm.Guass.alpha(i)*ProbcalcGuass(gmm.dataSet(Index,:), 0,...
					gmm.Guass.fai(Index,i)*gmm.Guass.R(:,:,i));
			end
			temp=sum(P(Index,:));
			P(Index,:)=P(Index,:)/temp;				
		end

		%% M step:
      
		for i = 1:gmm.NB_Guass
            gmm.Guass.R(:,:,i) =0;
            for Index=1:len
                gmm.Guass.R(:,:,i) = gmm.Guass.R(:,:,i) + 1/(sum(P(Index,i)))*((P(Index,i).*1./(gmm.Guass.fai(Index,i)))*gmm.dataSet(Index,:)'*conj(gmm.dataSet(Index,:)));
            end
            gmm.Guass.alpha(i) = 1/len*sum(P(:,i));
            
		end

		for Index=1:len
			for i=1:gmm.NB_Guass
				gmm.Guass.fai(Index,i) = 1/dim*trace(gmm.dataSet(Index,:)'*conj(gmm.dataSet(Index,:))*gmm.Guass.R(:,:,i));
			end
		end	
	end 
end

function Pro=ProbcalcGuass(x,meane,varR)
	n=length(x);
	Pro = 1/((2*pi)^(n/2)*det(varR))*exp(-1/2*(x-meane)*inv(varR)*conj((x-meane)'));
end