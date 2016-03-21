function I = reduce(image, size, n)

kernal = ones(size);
I = mask(image,kernal);
I
I= calc(I,n);

getView(I);
    



            