function P = getConnect(M,x,y)
P = zeros(1,2);
P(1,1) = x;
P(1,2) = y;
l=2;
for a = 1:3
    for b = 1:3
        if(~(a==2 && b==2))
            diff = M(a,b) - M(2,2);
            if(diff == 0)
                P(l,1) = x+a-2;
                P(l,2) = y+b-2;
                l=l+1;
            end
        end
    end
end
