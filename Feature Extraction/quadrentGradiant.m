function [setPMx,setPMy] = quadrentGradiant(im, gradientsigma, blocksigma)
    
    
    % Calculate image gradients.
    sze = fix(6*gradientsigma);   if ~mod(sze,2); sze = sze+1; end
    f = fspecial('gaussian', sze, gradientsigma); % Generate Gaussian filter.
    [fx,fy] = gradient(f);                        % Gradient of Gausian.
    
    Gx = filter2(fx, im); % Gradient of the image in x
    Gy = filter2(fy, im); % ... and y

    Gxx = Gx.^2;  % Covariance data for the image gradients
    Gyy = Gy.^2;
    Gxy = Gx.*Gy;
    
    
    % Now smooth the covariance data to perform a weighted summation of the
    % data.
    sze = fix(6*blocksigma);   if ~mod(sze,2); sze = sze+1; end    
    f = fspecial('gaussian', sze, blocksigma);
    Gxx = filter2(f, Gxx); 
    Gyy = filter2(f, Gyy);
    Gxy = 2*filter2(f, Gxy);
    
    
   
    Gx1 = (Gxx-Gyy)/sze^2;
    Gy1 = 2*Gxy/sze^2;
   
%         if Gx1 ~=0
%             PMx=sign(Gx1);
%         else 
%             PMx=1;
%         end
%         if Gy1 ~=0
%             PMy=sign(Gy1);
%         else 
%             PMy=1;
%         end
       PMx=sign(Gx1);PMy=sign(Gy1);
      setPMx = edge(PMx);
      setPMy = edge(PMy);
    
   
    
end