function Im = dynamicCalc(image,I,n)

v = size(I);

h = waitbar(0,'Calculating...');
    steps = v(1);

    for x = 1:v(1)
         waitbar(x/steps);
        for y = 1:v(2)
            if(I(x,y)>0)
                if (I(x,y)>n)
                    image(x,y)=1;
                else image(x,y)=0;
                end
            end
        end
    end
    
close(h);

Im = image;
