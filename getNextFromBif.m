function [X,Y] = getNextFromBif(image,P,x1,y1)

X = x1;
Y = y1;

M = image(x1-1:x1+1,y1-1:y1+1);
v = size(P);
l = 1;

for a = 1:3
    for b = 1:3
        if(~(a==2 && b==2))
            diff = M(a,b) - M(2,2);
            if(diff == 0)
                Xtemp = x1+a-2;
                Ytemp = y1+b-2;
                k =0;
                for r = 1:v(1)
                    if(P(r,1) == Xtemp && P(r,2) == Ytemp)
                        k = 1;
                        break;
                    end
                end
                if(k==0)
                    if(l==1)
                        X = Xtemp;
                        Y = Ytemp;
                    else
                        if((a==2 || b==2))
                            X = Xtemp;
                            Y = Ytemp;
                        end
                    end
                    l = l+1;
                end
            end
        end
    end
end