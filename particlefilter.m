function [  ] = particlefilter(  )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明


end

function particles=predict(particles,deltaT,a,b)
	%input:
	%particles: a matrix about [x,y,z,dx,dy,dz]
	%deltaT: time interval
	%	a:	Equation of motion parameter
	%	b:	Equation of motion parameter
	%output: new particles 
	%alpha=[x,y,z,dx,dy,dz];
	%particles=[particle1 particle2 ...]
	%a=exp(-belta*deltaT);b=v*sqrt(1-a^2);
	%Uk~N(mean,var);
	A=[1,0,0,a*deltaT,0,0;...
		0,1,0,a*deltaT,0;...
		0,0,1,0,0,a*deltaT;...
		0,0,0,a,0,0;...
		0,0,0,0,a,0;...
		0,0,0,0,0,a;];
	B=[b*deltaT, 0,0;...
		0,b*deltaT,0;...
		0,0,b*deltaT;...
		b,	0,	0;...
		0,  b,	0;...
		0,	0,	b];
	MU=[0,0,0];
	n=size(MU);
	SIGMA=[1,0,0;...
			0,1,0;...
			0,0,1];
	Uk = normrnd(MU,SIGMA,1,n);
	particles=A*particles+B*Uk;

	%normalize;
	particles(:,1:3)=particles(1:3)./norm(particles(1:3));
	particles(:,4:6)=particles(4:6)-particles(:,1:3)*(particles(:,4:6))'*particles(:,1:3);
end

function weights=update(particles,weights,Prob)
	% Prob is the likelihood Pr(Zk|ak);to find my particles to the Prob


end