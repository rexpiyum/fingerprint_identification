function [SP,x,y,theta]=quadrentGrad(I, gradientsigma, blocksigma)
[C,D]=quadrentGradiant(I,gradientsigma, blocksigma);
figure, imshow(I);figure, imshow(C);figure, imshow(D);
num=2;

[maxD,ridnumD]=maxLength(D,num);
[maxC,ridnumC]=maxLength(C,num);
SP= quadrentSPs(maxD,maxC);
O1=size(find(SP==1));
O2=0;SP1=SP;
O3=0;SP2=SP;
if O1(1)>3
 num=1;
 if(ridnumD(1)==2)
    [maxD1,ridnumD]=maxLength(D,num);
    [SP1,A1]= quadrentSPs(maxD1,maxC);
 end
 O2=size(find(SP1==1));
end


if O1(1)>3
 num=1;
 if(ridnumC(1)==2)
    [maxC1,ridnumC]=maxLength(C,num);
    [SP2,A2]= quadrentSPs(maxD,maxC1);
 end
O3=size(find(SP1==1));
end


if(O2(1)>=O3(1))
    SP=SP2;
    A=A2;
else 
    SP=SP1;
    A=A1;
end
    figure, imshow(A);
    [x,y]=find(SP~=0);
    figure, imshow(I);hold on;
    for i=1:size(x)
        plot(y(i),x(i),'ro','LineWidth',3);
    end
   
[P,theta,gradAll]=PrimarySP(I,SP,40)
end
