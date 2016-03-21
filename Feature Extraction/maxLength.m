function [maxRidge,indsiz] = maxLength(M,num)
Mnum=bwlabel(M);
MaxVal= max(max(Mnum));

for i=1:MaxVal
    Mlength(i,1)=length(find(Mnum==i));
end
    Msort=sort(Mlength,1,'descend');
if(size(Mlength)==1)
    ind(1,1)=find(Mlength==Msort(1));
else
    if((Msort(1)/3)-Msort(2))>0
        ind(1,1)=find(Mlength==Msort(1));
   
    else
        for j=1:num
         ind(j,1)=find(Mlength==Msort(j));
        end
    end
end
maxRidge=zeros(size(M));
indsiz=size(ind);
if(indsiz==1)
    maxRidge = (Mnum==ind(1));
else
    for z=1:num
         maxRidge = maxRidge + (Mnum==ind(z));
    end
end
end
