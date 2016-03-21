function T = thin(image)

I = image;
[M,D] = grad(I);
[v] = size(I);
T = zeros(v);
T= imcomplement(T);

horizontal = [255,0,255;255,0,255;255,0,255];
vertical = [255,255,255;0,0,0;255,255,255];
positive = [255,255,0;255,0,255;0,255,255];
negative = [0,255,255;255,0,255;255,255,0];


for x = 1:1:v(1)-2
   for y = 1:1:v(2)-2
       
       r = x+1;
       c = y+1;
       
      % m = nanmean(nanmean(D(x:x+9,y:y+9)));
       
      % D(x:x+9,y:y+9)
      % m
      % c
      % r

     % Dtemp = D(r,c);
      Itemp = I(r,c);
      if(r>2 && r<v(1)-1 && c>2 && c<v(2)-1)
          Dtemp = mean(mean(D(r-2:r+2,c-2:c+2)));
      else
          Dtemp = mean(mean(D(r-1:r+1,c-1:c+1)));
      end
      
     % I1 = I(x:x+2,y:y+2);
     % D1
     % I1
     % Itemp
     
      if (-22.5<Dtemp && Dtemp<=22.5)
          
          %horizontal
            if(Itemp == 0)
                k = c;
                left = 0;
                right = 0;
                while(k > 1 && I(r,k-1)==0)
                    k = k-1;
                    left = left+1;
                end
                k = c;
                while(k < v(2)-1 && I(r,k+1)==0)
                    k = k+1;
                    right = right+1;
                end
                
                mid = floor((right - left)/2);
                T(r,c+mid) = 0;                 
            %image(x:x+2,y:y+2) = image(x:x+2,y:y+2).*vertical;
            %T(r:r+2,c:c+2)= vertical;
            end
      end
      
      if (22.5<Dtemp && Dtemp<=67.5)
          %45
            if(Itemp == 0)
                j = r;
                k = c;
                left = 0;
                right = 0;
                while(k < v(2)-1 && j > 1 && I(j-1,k+1)==0)
                    k = k+1;
                    j = j-1;
                    left = left+1;
                end
                j = r;
                k = c;
                while(k > 1 && j < v(1)-1 && I(j+1,k-1)==0)
                    j = j+1;
                    k = k-1;
                    right = right+1;
                end
                mid = floor((left - right)/2);
                T(r-mid,c+mid) = 0;      
            %image(x:x+2,y:y+2) = image(x:x+2,y:y+2).*negative;
            %T(r:r+2,c:c+2) = negative;
            end
      end
      
      if ( abs(Dtemp) >67.5 )
          %vertical
          if(Itemp == 0)
                k = r;
                up = 0;
                down = 0;
                while(k > 1 && I(k-1,c)==0)
                    k = k-1;
                    up = up+1;
                end
                k = r;
                while(k < v(1)-1 && I(k+1,c)==0)
                    k = k+1;
                    down = down+1;
                end
                mid = floor((down - up)/2);
                T(r+mid,c) = 0; 
           %image(x:x+2,y:y+2) = image(x:x+2,y:y+2).*horizontal;
           % T(r:r+2,c:c+2)= horizontal;
          end
      end
      
      if (-67.5<Dtemp && Dtemp<= -22.5)
          
          %-45
          if(Itemp == 0)
                j = r;
                k = c;
                left = 0;
                right = 0;
                while(k > 1 && j > 1 && I(j-1,k-1)==0)
                    k = k-1;
                    j = j-1;
                    left = left+1;
                end
                j = r;
                k = c;
                while(k < v(2)-1 && j < v(1)-1 && I(j+1,k+1)==0)
                    j = j+1;
                    k = k+1;
                    right = right+1;
                end
                mid = floor((right - left)/2);
                T(r+mid,c+mid) = 0; 
            %image(x:x+2,y:y+2) = image(x:x+2,y:y+2).*positive;
            %T(r:r+2,c:c+2)= positive;
          end
      end
      
      
    %  T(r,c)
%      T(r:r+2,c:c+2)
      
       
   end
end
imshow(T);