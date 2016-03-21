function E = enhance(image)

I1 = myFilter(image,20);

I2 = reduce(I1,3,5);

I3 = fill(I2,30);

g = orientation_8dir(I3,40,35,10);

I4 = directionalReduce(I3,45,g,45,35);

I5 = reduce(I4,5,15);

I6 = Skel(~I5);

I7 = remove(I6,20);

[I8,g1] = gradSkel(I7,40,5);

[I9,g2] = gradSkel(I8,40,8);

I10 = connect(I8,g2,20,3);


E = I10; 





