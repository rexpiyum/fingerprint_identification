function Im = directionalReduce(image,n,grad,x,tr)

%figure,getView(image);
I = dynamicMask(image,n,grad,x);

Im= dynamicCalc(image,I,tr);


Im = Im|image;
%figure,getView(Im);


    



            