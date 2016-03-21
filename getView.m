function I = getView(image)

I = imcomplement(image).*255;

imshow(I);
   