function C = remove(image,n)

v = size(image);
I = image;

h = waitbar(0,'Cleaning...');
steps = (v(1)-2)*2;

for a = 1:v(1)-2
    waitbar(a/steps);
    for b = 1:v(2)-2
        
        x = a+1;
        y = b+1;
        
        if(image(x,y) == 1) 
            
            nonzero = sum(sum(image(a:a+2,b:b+2)))-1;
            
            if(nonzero>2 && traverse(image(a:a+2,b:b+2))==3)
                M = getConnect(image(a:a+2,b:b+2),x,y); 
                for r = 2:nonzero+1
%                     [p,q] = getNextFromBif(I,M,M(r,1),M(r,2));
                    %% follow the line and get length
                    [P,k] = lineFollow2(image,M(r,1),M(r,2),x,y,n,0);
                    
                    if(k==1)
                        
                        w = size(P);
                        for c = 1:w(1)
                           if(~(P(c,1)==0 && P(c,2)== 0))
                            I(P(c,1),P(c,2)) = 0;
                           end
                        end
                        I(M(r,1),M(r,2)) = 0;
                    end
                end
%             elseif(nonzero == 1)
%                 [P,k] = lineFollow2(I,x,y,x,y,n,0);
%                 if(k==1)
%                     w = size(P);
%                     for c = 1:w(1)
%                         image(P(c,1),P(c,2)) = 0;
%                     end
%                 end
%             elseif(nonzero == 0)
%                 image(x,y) = 0;
            end
            
        end
    end
end


C = removeSmall(I,n);
close(h);
% figure,imshow(~C);
end

function R = removeSmall(image,n)
%% remove noisy branches and small noise particles
v = size(image);
I = image;
steps = (v(1)-2)*2;
for a = 1:v(1)-2
    waitbar((a+v(1)-2)/steps)
    for b = 1:v(2)-2
        x = a+1;
        y = b+1;
        
        if(I(x,y) == 1) 
            nonzero = sum(sum(I(a:a+2,b:b+2)))-1;
            if(nonzero == 1)
                %% follow the line and get length
                [P,k] = lineFollow2(I,x,y,x,y,n,1);
                if(k==1)
                    w = size(P);
                    for c = 1:w(1)
                        I(P(c,1),P(c,2)) = 0;
                    end
                end
            elseif(nonzero == 0)
                I(x,y) = 0;
            end
        end
    end
end
R = I;
end
