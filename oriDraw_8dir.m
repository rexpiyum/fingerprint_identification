function T = oriDraw_8dir(image,grad,n)

D = grad;
[v] = size(image);

I = im2uint8(image);
I = imcomplement(I);

for x = 1:n:v(1)-n-1
   for y = 1:n:v(2)-n-1
       
       p = floor(n/2);
       p1 = ceil(p/2);
       r = x+p;
       c = y+p;

      Dtemp = nanmean(nanmean(D(r-p:r+p,c-p:c+p)));
      
      if (-11.25<Dtemp && Dtemp<=11.25)       %0
            I(r:r,c-p+1:c+p-1)= 180;
      
      elseif (11.25<Dtemp && Dtemp<=33.75)    %22.5
            I(r,c) = 180;
            l=0;
            for a = 1:p1-1
                k = r-a;
                m = c+1+l;
                I(k,m) = 180;
                if(m<y+n-2)
                    I(k,m+1) = 180;
                    l=l+2;
                end

            end
            l=0;
            for a = 1:p1-1
                k = r+a;
                m = c-1-l;
                I(k,m) = 180;
                if(m>y+3)
                    I(k,m-1) = 180;
                    l=l+2;
                end
            end
          
      elseif (33.75<Dtemp && Dtemp<=56.25)    %45
            for a = 1:n-2
                I(x+n-1-a,y+a) = 180;
            end
                
      elseif (56.25<Dtemp && Dtemp<=78.75)    %67.5
            I(r,c) = 180;
            l=0;
            for a = 1:p1-1
                k = c+a;
                m = r-1-l;
                I(m,k) = 180;
                if(m>x+3)
                    I(m-1,k) = 180;
                    l=l+2;
                end

            end
            l=0;
            for a = 1:p1-1
                k = c-a;
                m = r+1+l;
                I(m,k) = 180;
                if(m<x+n-2)
                    I(m+1,k) = 180;
                    l=l+2;
                end
            end
          
      elseif ( abs(Dtemp) >78.75)             %90
          I(r-p+1:r+p-1,c:c)= 180;  
          
      
      elseif (-33.75<Dtemp && Dtemp<=-11.25)  %-22.5
            I(r,c) = 180;
            l=0;
            for a = 1:p1-1
                k = r+a;
                m = c+1+l;
                I(k,m) = 180;
                if(m<y+n-2)
                    I(k,m+1) = 180;
                    l=l+2;
                end

            end
            l=0;
            for a = 1:p1-1
                k = r-a;
                m = c-1-l;
                I(k,m) = 180;
                if(m>y+3)
                    I(k,m-1) = 180;
                    l=l+2;
                end
            end
          
      elseif (-56.25<Dtemp && Dtemp<= -33.75) %-45
                for a = 1:n-2
                    I(x+a,y+a) = 180;
                end  
          
        
      elseif (-78.75<Dtemp && Dtemp<=-56.25)    %-67.5
            I(r,c) = 180;
            l=0;
            for a = 1:p1-1
                k = c+a;
                m = r+1+l;
                I(m,k) = 180;
                if(m<x+n-2)
                    I(m+1,k) = 180;
                    l=l+2;
                end

            end
            l=0;
            for a = 1:p1-1
                k = c-a;
                m = r-1-l;
                I(m,k) = 180;
                if(m>x+3)
                    I(m-1,k) = 180;
                    l=l+2;
                end
            end
      end
      
      
       
   end
   
end
T = I;
%figure,imshow(I);