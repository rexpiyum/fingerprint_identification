function [I,G] = gradSkel(image,n,m,bool)
%% calculate line gradients and remove sudden gradient changes %%
v = size(image);
G = NaN(v);
Points = zeros(v);
I = image;

if(bool ==1)
    h = waitbar(0,'Smoothing Ridge Endings...');
    steps = v(1)-2;
end

for a = 1:v(1)-2
    if(bool ==1)
     waitbar(a/steps)
    end
    for b = 1:v(2)-2
        
        x = a+1;
        y = b+1;
        
        
        if(image(x,y) == 1)
            nonzero = sum(sum(image(a:a+2,b:b+2)))-1;
            if(nonzero == 1)
                Gtemp = NaN(1,1);
                [P,k] = lineFollow2(image,x,y,x,y,n,1);
                %% calculate gradient 
                for c = 1:size(P,1)-m
                    if(c<=m)
                        G(P(c,1),P(c,2)) = atan((P(c+m,1)-P(c,1))/(P(c+m,2)-P(c,2)))*180/pi;
                    else
                        G(P(c,1),P(c,2)) = atan((P(c+m,1)-P(c-m,1))/(P(c+m,2)-P(c-m,2)))*180/pi;
                    end
                    
                    Gtemp(c,1) = G(P(c,1),P(c,2));
                    
                end
                
                for d = 1:10:size(Gtemp,1)-10
                    %% check for gradient changes of 45' and remove
                    if(Gtemp(d,1)*Gtemp(d+9,1)>0 && abs(Gtemp(d,1)-Gtemp(d+9,1)) > 45)
                        for e = 1:d+9
                            I(P(e,1),P(e,2)) = 0;
                        end
                        break;
                    elseif(Gtemp(d,1)*Gtemp(d+9,1)<0 && abs(Gtemp(d,1)-Gtemp(d+9,1)) <= 90 && abs(Gtemp(d,1)-Gtemp(d+9,1)) > 45)
                        for e = 1:d+9
                            I(P(e,1),P(e,2)) = 0;
                        end
                        
                        break;
                     elseif(Gtemp(d,1)*Gtemp(d+9,1)<0 && abs(Gtemp(d,1)-Gtemp(d+9,1)) >90 && 180-abs(Gtemp(d,1)-Gtemp(d+9,1)) > 45)
                        for e = 1:d+9
                            I(P(e,1),P(e,2)) = 0;
                        end
                        break;
                    end
                end
            end
        
        end
    end
end
if(bool ==1)
    close(h);
end
% [x_p,y_p] = find(Points);
% imshow(~image);         %# Display your image
% hold on;            %# Add subsequent plots to the image
% plot(y_p,x_p,'o');  %# NOTE: x_p and y_p are switched (see note below)!
% hold off;
% figure,imshow(~I);