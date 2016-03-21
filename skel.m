function T = skel(image)

v = size(image);
Z = ones(v);
T = imcomplement(image);
has_changed = 1;
l = 0;

h = waitbar(0,'Skeletonizing...');
steps = 15;

while(has_changed == 1)
    waitbar(l+1/steps)
    has_changed = 0;
    %% 1st sub iteration
    Z = ones(v);
    for a = 1:v(1)-2
        for b = 1:v(2)-2
            
            x = a+1;
            y = b+1;
            
            if(T(x,y) == 1)
               nonzero = sum(sum(T(a:a+2,b:b+2)))-1;
               if(2<=nonzero && nonzero<=6)
                   n = traverse(T(a:a+2,b:b+2));
                   if(n == 1)
                       
                       if(T(x+1,y)==0 || T(x,y+1)==0 || (T(x,y-1)==0 && T(x-1,y)==0))
                           Z(x,y) = 0;
                           has_changed = 1;
                       end
                   end
               end
            end
        end
    end
    
    T = T.*Z;
    
    %% 2nd sub iteration
    Z = ones(v);
    for a = 1:v(1)-2
        for b = 1:v(2)-2
            
            x = a+1;
            y = b+1;
            
            if(T(x,y) == 1)
               nonzero = sum(sum(T(a:a+2,b:b+2)))-1;
               if(2<=nonzero && nonzero<=6)
                   n = traverse(T(a:a+2,b:b+2));
                   if(n == 1)
                       
                       if(T(x-1,y)==0 || T(x,y-1)==0 || (T(x,y+1)==0 && T(x+1,y)==0))
                           Z(x,y) = 0;
                           has_changed = 1;
                       end
                   end
               end
            end
        end
    end
    
    T = T.*Z;
    l= l+1;
    
end
close(h);
%imshow(Z);
% imshow(imcomplement(T));
