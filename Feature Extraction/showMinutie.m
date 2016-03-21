function [Termination, Bifurcation] = showMinutie(originalImage, skelImage, filledImage, TR ,BR , t1, t2, t3, t4, borderMargin, winSize, theta)
% function [Termination, Bifurcation] = showMinutie(originalImage, skelImage,filledImage, t1, t2, t3, borderMargin, winSize, theta)

imgRGB = originalImage; % get the original images
K = skelImage; % skelatonized image
I5 = filledImage;
D1 = t1; %threshold distance between a termination and a biffurcation
D2 = t2; %threshold distance between biffurcations
D3 = t3; %threshold distance between terminations 10
D4 = t4; %threshold distance between terminations considering angle
b = borderMargin;
w = winSize; % window size(normally distance between two reidges
angle = theta;

% load('I.mat');
% figure, imshow(I);


%% Number the lines
H = fspecial('disk',50);
blurred = imfilter(I5,H,'replicate');
I5B = ~(blurred<0.62)+~K;
K1 = bwlabel(I5B);
%%

%% Mark minutie
fun=@minutia;
L = nlfilter(K,[3 3],fun);
%%

%% Extract minutia points
% Terminations
[i,j] = find(L==1);
Termination = [j,i];
% Bifurcation
[i,j] = find(L==3);
Bifurcation = [j,i];

% PrintMiniutie(K, Termination, Bifurcation,TR ,BR , 'Before remove points');

%%

%% Remove terminations & bifurications found in the border of the image
% K, b, Termination, Bifurcation

s = size(Termination);
imsize = size(K);
h = waitbar(0,'Remove terminations found in the border');
for k = 1:s(1)
    waitbar(k/s(1));
    if (Termination(k,1)<(b+1))||(Termination(k,2)<(b+1))||(Termination(k,2)>imsize(1)-(b+1))||(Termination(k,1)>imsize(2)-(b+1))
        Termination(k,:) = 0;
    end
end
close(h);

s = size(Bifurcation);
h = waitbar(0,'Remove bifurcation found in the border');
for k = 1:s(1)
    waitbar(k/s(1));
    if (Bifurcation(k,1)<(b+1))||(Bifurcation(k,2)<(b+1))||(Bifurcation(k,2)>imsize(1)-(b+1))||(Bifurcation(k,1)>imsize(2)-(b+1))
        Bifurcation(k,:) = 0;
    end
end
close(h);

[i,j] = find(Termination == 0);
Termination(i,:) = [];
[i,j] = find(Bifurcation == 0);
Bifurcation(i,:) = [];

%PrintMiniutie(K, Termination, Bifurcation,TR ,BR , 'Before remove points');
%%

%% Calculate the gradinat of every point
% Termination(k,3) - Angle
% Termination(k,4) - Line number
% Termination(k,5) - number of pixels
%

f = fspecial('gaussian',3, 1);
[fx,fy] = gradient(f);

% s = size(Termination);
% for k = 1:s(1)
%     Termination(k,3) = K1(Termination(k,2),Termination(k,1));
%     Gx = filter2(fx, K1==Termination(k,4));
%     Gy = filter2(fy, K1==Termination(k,4));
%     Grad = atan2(Gy,Gx);
%     Termination(k,4) = Grad(Termination(k,2),Termination(k,1));
% end

h = waitbar(0,'Calculate angles of terminations');
s = size(Termination);
for k = 1:s(1)
    waitbar(k/s(1));
    W = K1(Termination(k,2)-w:Termination(k,2)+w,Termination(k,1)-w:Termination(k,1)+w);
    Termination(k,3) = K1(Termination(k,2),Termination(k,1));
    Termination(k,4) = atan2(length(find(sum(W==K1(Termination(k,2),Termination(k,1)),2))),length(find(sum(W==K1(Termination(k,2),Termination(k,1)),1))));
    Termination(k,5) = sum(sum(K1 == (Termination(k,3))));
end
close(h);

% Bifurcation(k,3) - Angle
% Bifurcation(k,4) - Line number
% Bifurcation(k,5) - number of pixels

h = waitbar(0,'Calculate angles of bifurcation');
s = size(Bifurcation);
for k = 1:s(1)
    waitbar(k/s(1));
    Bifurcation(k,3) = K1(Bifurcation(k,2),Bifurcation(k,1));
    Gx = filter2(fx, K1==Bifurcation(k,3));
    Gy = filter2(fy, K1==Bifurcation(k,3));
    Grad = atan2(Gy,Gx);
    Bifurcation(k,4) = Grad(Bifurcation(k,2),Bifurcation(k,1));
    Bifurcation(k,5) = sum(sum(K1 == (Bifurcation(k,3))));
end
close(h);
%%

%%
%

s = size(Termination);
m1 = s(1);
m2 = m1;

G = zeros(m1,m2);
G1= zeros(m1,m2);

Distance = distanceCalcB(Termination);
h = waitbar(0,'Remove terminations due to breaked lines');
Termination(:,6) = 1;
for i=1:m1
    waitbar(i/m1);
    for j=1:m2
        if i==j
            G(i,j)=NaN;
        else
            G(i,j)=atan2(abs(Termination(i,2)-Termination(j,2)), abs(Termination(i,1)-Termination(j,1)));
             %if(Termination(i,5)>w/3 && Termination(j,5)>w/3)
                if((((G(i,j)<Termination(i,4)+angle)&&(G(i,j)>Termination(i,4)-angle))||((G(i,j)<Termination(j,4)+angle)&&(G(i,j)>Termination(j,4)-angle)))&&(Distance(i,j)<D4))
                        Termination(i,6) = 0;
                        Termination(j,6) = 0;
                end
             %end    
        end
    end
end
close(h);

[i,j] = find(Termination (:,6) == 0);

Termination(i,:) = [];
title1 = ['After removal of adjucent points | Angle = ', num2str(angle),' | Distance = ', int2str(D4)];
%PrintMiniutie(K, Termination, Bifurcation,TR ,BR , title1);

%%

%% Remove small noise terminations found in the image
% w = 40;
%%%%%%%%%%%%%%%%%
K1 = bwlabel(K);
s = size(Termination);
h = waitbar(0,'Remove terminations due to noise');
for k = 1:s(1)
    waitbar(k/s(1));
    W = K1(Termination(k,2)-w:Termination(k,2)+w,Termination(k,1)-w:Termination(k,1)+w);
    if (length(find(sum(W==K1(Termination(k,2),Termination(k,1)),1)))<w&&length(find(sum(W==K1(Termination(k,2),Termination(k,1)),2)))<w)
        Termination(k,6) = 0;
        %     else
        %         CentroidTerm(k,3) = atan2(length(find(sum(W==K1(CentroidTerm(k,2),CentroidTerm(k,1)),2))),length(find(sum(W==K1(CentroidTerm(k,2),CentroidTerm(k,1)),1))));
    end
end
close(h);
[i,j] = find(Termination (:,6)== 0);
Termination(i,:) = [];
title1 = ['After tint terminations | Size = ', int2str(w)];
%PrintMiniutie(K, Termination, Bifurcation,TR ,BR , title1);
%%

%% Remove close terminations
% D3 = 25;
%%%%%%%%%%%%%%%%
Distance=distanceCalcT(Termination);
SpuriousMinutae=Distance<D3;
[i,j]=find(SpuriousMinutae);
Termination(i,:)=[];
title1 = ['After removal of adjucent points (ter) (considering distance only) | Distance = ', int2str(D3)];
%PrintMiniutie(K, Termination, Bifurcation, TR ,BR ,title1 );
%%

%% Remove close terminations and bifurcation
% D1 = 30;
Distance=distanceCalcTB(Bifurcation,Termination);
SpuriousMinutae=Distance<D1;
[i,j]=find(SpuriousMinutae);
Bifurcation(i,:)=[];
Termination(j,:)=[];
title1 = ['After removal of adjucent points (bi & ter) (considering distance only) | Distance = ', int2str(D1)];
%PrintMiniutie(K, Termination, Bifurcation,TR ,BR ,title1);
%%

%% Remove close bifurcation
%D2 = 30;
Distance=distanceCalcB(Bifurcation);
SpuriousMinutae=Distance<D2;
[i,j]=find(SpuriousMinutae);
Bifurcation(i,:)=[];
title1 = ['After removal of adjucent points (bi) (considering distance only) | Distance = ', int2str(D2)];
%PrintMiniutie(K, Termination, Bifurcation,TR ,BR , '');

%% create mask and remove unwanted minutiae

[i,j] = find(blurred<0.62);
A = [j,i];
A(:,3:4) = 0;
Bifurcation = intersect(Bifurcation(:,1:2),A(:,1:2),'rows');
Termination = intersect(Termination(:,1:2),A(:,1:2),'rows');
%PrintMiniutie(K, Termination, Bifurcation, TR ,BR ,'');

%%  

figure, imshow(~K);
hold on
plot(Termination(:,1),Termination(:,2),'bo')
plot(Bifurcation(:,1),Bifurcation(:,2),'bs')
plot(TR(:,1),TR(:,2),'go');
plot(BR(:,1),BR(:,2),'gs');
title1 = ['D1 = ', int2str(D1), ' |  D2 = ', int2str(D2), ' | D3 = ', int2str(D3), ' | D4 = ', int2str(D4),' | Border = ', int2str(b), ' | Window = ', int2str(w), ' | Angle = ', num2str((angle/pi)*180)];
title(title1);
hold off

% figure, imshow(imgRGB);
% hold on
% plot(Termination(:,1),Termination(:,2),'bo')
% plot(Bifurcation(:,1),Bifurcation(:,2),'bs')
% %hold off



