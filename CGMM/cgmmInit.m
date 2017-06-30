function gmm=cgmmInit(dataSet,NB_Guass,maxIter,meane,alpha,fai,R)
	gmm.dataSet = dataSet;
	gmm.NB_Guass = NB_Guass;
	gmm.maxIter = maxIter;
	% R is   6 * 6 * NB_Guass;
	% fai is  len(dataSet) * NB_Guass 
	gmm.Guass.R = R;
	gmm.Guass.fai = fai;
	gmm.Guass.mean = meane ;
	gmm.Guass.alpha = 1/gmm.NB_Guass*ones(gmm.NB_Guass,1);
end
