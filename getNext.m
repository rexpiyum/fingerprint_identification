function [X,Y] = getNext(M,x1,y1,x2,y2)
    %% get next connecting point of a given point
    p = x2-x1+2;
    q = y2-y1+2;
    X = x1;
    Y = y1;
    
    n = sum(sum(M))-1;
    l = 1;
    if(n<3)
        for a = 1:3
            for b = 1:3
                if(~(a==2 && b==2))
                    diff = M(a,b) - M(2,2);
                    if(diff == 0 && ~(a == p && b == q))
                        X = x1+a-2;
                        Y = y1+b-2;
                    end
                end
            end
        end
    else
        
        for a = 1:3
            for b = 1:3
                if(~(a==2 && b==2))
                    diff = M(a,b) - M(2,2);
                    if(diff == 0 && ~(a == p && b == q) && ~(((a-p)==0 && abs(b-q)==1)||(abs(a-p)==1 && (b-q)==0)))
                        if(l==1)
                            X = x1+a-2;
                            Y = y1+b-2;
                        else
                            if((a==2 || b==2))
                                X = x1+a-2;
                                Y = y1+b-2;
                            end
                        end
                        l = l+1;
                    end
                end
            end
        end
    end
end