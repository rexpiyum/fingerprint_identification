function [P,gradP,gradAll]=PrimarySP(I,SP,w)
[arrayX,arrayY]=find(SP~=0);
sze = fix(4*1);   if ~mod(sze,2); sze = sze+1; end
    f = fspecial('gaussian',sze, 1); 
    [fx,fy] = gradient(f);                        
    Gx = filter2(fx, I); 
    Gy = filter2(fy, I);
    
    [r,c]=size(I);
    grad = zeros(r,c);
    for j=1:r
        for z=1:c
          grad(j,z)= atan2(Gy(j,z),Gx(j,z))/2;
        end 
    end

       for ind=1:length(arrayX)
            K=grad(arrayX(ind)-w:arrayX(ind)+w,arrayY(ind)-w:arrayY(ind)+w);  
            
            P(ind,1) =sum(sum(K));
       end 
       Psp=find(min(min(P)));
       Xp=arrayX(Psp);
       Yp=arrayY(Psp);
       gradP=grad(Xp,Yp)/3.1416*180;
       gradAll=grad./3.1416*180;
       
end