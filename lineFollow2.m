function [P,k] = lineFollow2(image,x1,y1,x2,y2,n,type)
%% follow a line and get coordinates of the points up to n pixels %%
xOld = x2;
yOld = y2;
xNew = x1;
yNew = y1;


v = size(image);
k = 0;
P = zeros(1,2);

for r = 1:n
    if(xNew>1 && xNew<v(1) && yNew>1 && yNew<v(2))
        nonzero = sum(sum(image(xNew-1:xNew+1,yNew-1:yNew+1)))-1;
        
        if(nonzero>2 && traverse(image(xNew-1:xNew+1,yNew-1:yNew+1))==3) %% bifurcation
           
            k = 1;
            break;
        elseif(type == 1 && r<10 && r>1 && nonzero == 1) %% ending
            
            k =1;
            break;
        end
        
        [xNext,yNext] = getNext(image(xNew-1:xNew+1,yNew-1:yNew+1),xNew,yNew,xOld,yOld);
        
        P(r,1) = xNew;
        P(r,2) = yNew;
        xOld = xNew;
        yOld = yNew;
        xNew = xNext;
        yNew = yNext;
    end
end

end