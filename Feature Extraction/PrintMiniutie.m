function PrintMiniutie(K, CentroidTerm, CentroidBif,TR, BR, a)
figure, imshow(~K)
hold on
plot(CentroidTerm(:,1),CentroidTerm(:,2),'bo')
plot(CentroidBif(:,1),CentroidBif(:,2),'rs')
plot(TR(:,1),TR(:,2),'go');
plot(BR(:,1),BR(:,2),'gs');
title(a);
hold off