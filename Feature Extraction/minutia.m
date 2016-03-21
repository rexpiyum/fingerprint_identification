function y = minutia(x)
i=ceil(size(x)/2);
if x(i,i)==0;
    y=0;
else
    y=2;
    L = zeros(1,8);
    m=1;
    for k = 1:3
        for l = 1:3
            
            if(k==2) && (l==2)
                continue; % Ignore the center pixel
            end
            L(1,m)= x(k,l); % Copy 3X3 matrix into a single dimention array
            m=m+1;
            
        end
    end
    %%%%%% interchange array positions of the pixel values %%%%%%
    n = L(1,5);
    L(1,5) = L(1,4);
    L(1,4) = n;
    
    n = L(1,6);
    L(1,6) = L(1,7);
    L(1,7) = n;
    
    n = L(1,5);
    L(1,5) = L(1,8);
    L(1,8) = n;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    a = 0;
    for b = 1:8
        a = a+abs(L(1,mod(b,8)+1)-L(b)); % Calculate the CN value
    end
    
    a = a/(2);
    switch a
        case {1}
            if (length(find(L))<3)
                y = 1;
            end
        case {3}
            y =3;
        otherwise
            
    end
    
end