function D = distanceCalcT(dataset1)
h = waitbar(0,'Distance Computation');
[m1,n1]=size(dataset1);
m2=m1;
D=zeros(m1,m2);
for i=1:m1
    waitbar(i/m1)
    for j=1:m2
        if (i==j)||(dataset1(i,3)==dataset1(j,3))
            D(i,j)=NaN;
        else
            D(i,j)=sqrt((dataset1(i,1)-dataset1(j,1))^2+(dataset1(i,2)-dataset1(j,2))^2);
        end
    end
end
close(h);