function N = traverse(M)
%% count 01 patterns in eight neighborhood %%
N =0;
for a = 1:2
    if(M(a,1)-M(a+1,1) == 1)
        N = N+1;
    end

    if(M(3,a)-M(3,a+1) == 1)
        N = N+1;
    end

    if(M(4-a,3)-M(3-a,3) == 1)
        N = N+1;
    end

    if(M(1,4-a)-M(1,3-a) == 1)
        N = N+1;
    end
end


