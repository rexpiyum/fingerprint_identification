function I = myFilter(image,w)
    I = image;
    v = size(I);
    mirror = zeros(v);
    
    h = waitbar(0,'Binarizing...');
    steps = v(1);
    
    for a = 1:5:v(1)
        waitbar(a/steps)
        a1 = a+w;
        if a1>v(1)
            a1=v(1);
        end
        
        for b = 1:5:v(2)
            
            b1 = b+w;
            if b1>v(2)
                b1=v(2);
            end
          
            n = mean(mean(I(a:a1,b:b1)));
            n = n + n/10;
            %n = DT(I(a:a1,b:b1));
          
             
               for x = a:a1
                for y = b:b1
                    if I(x,y)<n
                        mirror(x,y)=mirror(x,y)+1;
                    else mirror(x,y)=mirror(x,y)-1;
                    end
                end
               end
               
             
        end
        
       
    end
    close(h);

    for x = 1:v(1)
        for y = 1:v(2)
            if mirror(x,y)>0
                mirror(x,y)=1;
            else mirror(x,y)=0;
            end
        end
    end
  
I = mirror;
getView(I);


