function [SP,A]= quadrentSPs(maxD,maxC)
Addition=maxD+maxC;
Sp=(Addition==2);
Avg=Addition-2*Sp;
F=fspecial('average',2);
A=filter2(F,Avg);
B=(A>.9999);
SP=Sp+B;
end