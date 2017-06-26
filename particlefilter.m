function [  ] = particlefilter(  )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明


end

function particles=predict(particles,deltaT,a,b)
	%input:
	%particles: a matrix about [x,y,dx,dy]
	%deltaT: time interval
	%	a:	Equation of motion parameter
	%	b:	Equation of motion parameter
	%output: new particles 
	%alpha=[x,y,dx,dy];
	%particles=[particle1 particle2 ...]
	A=[1,0,a*deltaT,0;...
		0,1,0,a*deltaT;...
		0,0,a,0;...
		0,0,0,a];
	



end
