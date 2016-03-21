function I = calc(image,n)

v = size(image);

h = waitbar(0,'calculating...');
    steps = v(1);
    

    for x = 1:v(1)
        waitbar(x/steps)
        
        for y = 1:v(2)
            if (image(x,y)>n)
               image(x,y)=1;
            else image(x,y)=0;
            end
        end
    end
close(h);
I = image;

    



            