function gmm=cgmmInit(dataSet,NB_Guass,maxIter,fai,R)
	gmm.dataSet = dataSet;
	gmm.NB_Guass = NB_Guass;fa
	gmm.maxIter = maxIter;
	% R is NB_Guass * 6 * 6;
	% fai is NB_Guass * len(dataSet)
	gmm.Guass.R = R;
	gmm.Guass.fai = fai;
	gmm.Guass.mean = 0 ;
	gmm.Guass.alpha = 1/gmm.NB_Guass*ones(gmm.NB_Guass,1);
end
function gmm=cgmmProcess(gmm)
	(len,dim) = size(gmm.dataSet);	
	for j=1:gmm.maxIter
		for Index=1:len
			for i=1:gmm.NB_Guass
				P(Index,i) = ProbcalcGuass(gmm.dataSet(Index,:)', 0,...
					gmm.Guass.fai(i,Index)*gmm.Guass.R(i,:,:) );
			end
			temp=sum(P(Index,));
			P(Index,:)=P(Index,:)/temp;
		end
end

function Pro=ProbcalcGuass(x,meane,varR)
	n=length(x);
	Pro = 1/((2*pi)^(n/2)det(varR))*exp(-1/2*(x-meane)'*inv(varR)*(x-meane));
end