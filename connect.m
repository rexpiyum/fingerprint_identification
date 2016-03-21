function [I,Points,Points1] = connect(image,grad,n,w)

G = grad;
I = image;
v = size(image);
Itemp = zeros(v);
Points = zeros(v);
Points1 = zeros(v);
P = zeros(0,2);
Left = zeros(0,4);
Right = zeros(0,4);

l = 1;
%% mark endings from left %%
h = waitbar(0,'Connecting...');
steps = v(1)-2;

for a = 1:v(1)-2
    waitbar(a / steps)
    for b = 1:v(2)-2
        
        x = a+1;
        y = b+1;
        
        M = image(a:a+2,b:b+2);
        if(image(x,y) == 1)
            nonzero = sum(sum(M))-1;
            if(nonzero == 1)
                g = G(x,y);
                if (-22.5<g && g<=22.5)
                    %% horizontal orient %%
                    if(y+n< v(2) && x-w >1 && x+w <v(1))
                    sumleft = sum(sum(M(1:3,1:2)))-1;                    
                    if(sumleft>0)
                        Itemp(x-w:x+w,y:y+n)= 1;
                        for c = 0:n
                            for d = -w:w
                                Left(l,:) = [x+d,y+c,x,y];
                                l = l+1;
                            end
                        end
                    else
                        P(size(P,1)+1,:) = [x,y];
                    end
                    end
                elseif (abs(g) >67.5)
                    %% vertical orient %%
                    if(x+n < v(1) && y-w >1 && y+w <v(2))
                    sumup = sum(sum(M(1:2,1:3)))-1;
                    if(sumup>0)
                        Itemp(x:x+n,y-w:y+w)= 1; 
                        for c = 0:n
                            for d = -w:w
                                Left(l,:) = [x+c,y+d,x,y];
                                l = l+1;
                            end
                        end
                    else
                        P(size(P,1)+1,:) = [x,y];
                    end
                    end
                elseif (22.5<g && g<=67.5)
                      %% -45 %%
                    sumleft = sum(sum(M(1:3,1:2)))-1-M(3,2)+M(1,3);                    
                    if(sumleft>0)
                       for c = 0:n
                           if(x+c+w> v(1) || y+c > v(2))
                                break;
                            end
                           Itemp(x+c-w:x+c+w,y+c:y+c) = 1;
                           for d = -w:w
                                Left(l,:) = [x+c+d,y+c,x,y];
                                l = l+1;
                            end
                       end 
                    else
                        P(size(P,1)+1,:) = [x,y];
                    end
                elseif (-67.5<g && g<= -22.5)
                      %% 45 %%
                    sumleft = sum(sum(M(1:3,1:2)))-1-M(1,2)+M(3,3);                    
                    if(sumleft>0)
                        for c = 0:n
                            if(x-c-w<1 || y+c > v(2))
                                break;
                            end
                          Itemp(x-c-w:x-c+w,y+c:y+c) = 1;
                          for d = -w:w
                                Left(l,:) = [x-c+d,y+c,x,y];
                                l = l+1;
                          end
                        end 
                    else
                        P(size(P,1)+1,:) = [x,y];     
                    end
                end

            end
        end
    end
end
close(h);
%% connect right endings with left

r = 1;
t = 0;
h1 = waitbar(0,'Connecting...');
steps = size(P,1)+size(Right,1);
for e = 1:size(P,1)
        waitbar(e/steps)
                x = P(e,1);
                y = P(e,2);

                g = G(x,y);
                if (-22.5<g && g<=22.5)
                    %% horizontal orient %%
                    if( y-n > 1 && x-w >1 && x+w <v(1))
%                         Itemp(x-2:x+2,y-n:y) = 1;
                        if(sum(sum(Itemp(x-w:x+w,y-n:y))) > 0)
                            for c = 0:n
                                for d = -w:w
                                    if(Itemp(x+d,y-c) == 1)
                                        Right(r,:) = [x+d,y-c,x,y];
                                        r = r+1;
                                        t = 1;
                                        break;
                                    end
                                end
                                if(t==1)
                                    t = 0;
                                    break;
                                end
                            end
                            
                        end
                    end
                    
                elseif (abs(g) >67.5)
                    %% vertical orient %% 
                    if( x-n > 1 && y-w >1 && y+w <v(2))   
%                         Itemp(x-n:x,y-2:y+2) = 1;
                        if(sum(sum(Itemp(x-n:x,y-w:y+w))) > 0)
                            for c = 0:n
                                for d = -w:w
                                    if(Itemp(x-c,y+d) == 1)
                                        Right(r,:) = [x-c,y+d,x,y];
                                        r = r+1;
                                        t = 1;
                                        break;
                                    end
                                end
                                if(t==1)
                                    t = 0;
                                    break;
                                end
                            end
                        end
                    end
                elseif (22.5<g && g<=67.5)
                      %% -45 %%
                       for c = 0:n
                           if(x-c-w<1 || y-c <1)
                                break;
                           end
%                            Itemp(x-c-2:x-c+2,y-c:y-c) = 1;
                           if(sum(sum(Itemp(x-c-w:x-c+w,y-c:y-c))) > 0)
                                for d = -w:w
                                    if(Itemp(x-c+d,y-c) == 1)
                                        Right(r,:) = [x-c+d,y-c,x,y];
                                        r = r+1;
                                        t = 1;
                                        break;
                                    end
                                end
                                if(t==1)
                                    t = 0;
                                    break;
                                end
                           end
                           
                       end     
                    
                elseif (-67.5<g && g<= -22.5)
                      %% 45 %%
                        for c = 0:n
                            if(x+c+w>v(1) || y-c < 1)
                                break;
                            end
%                             Itemp(x+c-2:x+c+2,y-c:y-c) = 1;
                            if(sum(sum(Itemp(x+c-w:x+c+w,y-c:y-c))) > 0)
                                for d = -w:w
                                    if(Itemp(x+c+d,y-c) == 1)
                                        Right(r,:) = [x+c+d,y-c,x,y];
                                        r = r+1;
                                        t = 1;
                                        break;
                                    end
                                end
                                if(t==1)
                                    t = 0;
                                    break;
                                end
                           end
                           
                        end 
                          
                end
end


for f = 1:size(Right,1)
    waitbar((f+size(P,1))/steps)
    x = Right(f,3);
    y = Right(f,4);
    Points1(x,y) = 1;
    
    for h = 1:size(Left,1)
        if(Left(h,1) == Right(f,1) && Left(h,2) == Right(f,2))
            x1 = Left(h,3);
            y1 = Left(h,4);
            Points(x1,y1) = 1;
           
            break;
        end
    end
    %% plot
    rpts = linspace(x,x1,100);   %% A set of row points for the line
    cpts = linspace(y,y1,100);   %% A set of column points for the line
    index = sub2ind(v,round(rpts),round(cpts));  %% Compute a linear index
    I(index) = 1; 
end

close(h1);
% [x_p,y_p] = find(Points);
% [x_p1,y_p1] = find(Points1);
% imshow(~image);         
% hold on;            
% plot(y_p,x_p,'o'); 
% plot(y_p1,x_p1,'s');
% hold off;
% 
% figure,imshow(~I);
% figure,imshow(~image);
