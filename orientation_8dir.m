function I = orientation_8dir(image,n,tr,s)

K1 = zeros(n);
K2 = zeros(n);
K3 = zeros(n);
K4 = zeros(n);
K5 = zeros(n);
K6 = zeros(n);
K7 = zeros(n);
K8 = zeros(n);

t = floor(n/2);
t1 = ceil(t/2);

%K1 - 90
K1(1:n,t+1:t+1)= 1;

%K2 - 67.5
K2(t+1,t+1) = 1;
l=0;
for a = 1:t1
    k = t+1+a;
    m = t-l;
    K2(m,k) = 1;
    if(m>1)
        K2(m-1,k) = 1;
        l=l+2;
    end
    
end
l=0;
for a = 1:t1
    k = t+1-a;
    m = t+2+l;
    K2(m,k) = 1;
    if(m<n)
        K2(m+1,k) = 1;
        l=l+2;
    end
end

%K3 - 45
for a = 1:n
    K3(n+1-a,a) = 1;
end

%K4 - 22.5
K4(t+1,t+1) = 1;
l=0;
for a = 1:t1
    k = t+1-a;
    m = t+2+l;
    K4(k,m) = 1;
    if(m<n)
        K4(k,m+1) = 1;
        l=l+2;
    end
    
end
l=0;
for a = 1:t1
    k = t+1+a;
    m = t-l;
    K4(k,m) = 1;
    if(m>1)
        K4(k,m-1) = 1;
        l=l+2;
    end
end
 
%K5 - 0
K5(t+1:t+1,1:n)= 1;

%K6 - -22.5
K6(t+1,t+1) = 1;
l=0;
for a = 1:t1
    k = t+1+a;
    m = t+2+l;
    K6(k,m) = 1;
    if(m<n)
        K6(k,m+1) = 1;
        l=l+2;
    end
    
end
l=0;
for a = 1:t1
    k = t+1-a;
    m = t-l;
    K6(k,m) = 1;
    if(m>1)
        K6(k,m-1) = 1;
        l=l+2;
    end
end
%K7 - -45
for a = 1:n
    K7(a,a) = 1;
end

%K8 - -67.5
K8(t+1,t+1) = 1;
l=0;
for a = 1:t1
    k = t+1+a;
    m = t+2+l;
    K8(m,k) = 1;
    if(m<n)
        K8(m+1,k) = 1;
        l=l+2;
    end
    
end
l=0;
for a = 1:t1
    k = t+1-a;
    m = t-l;
    K8(m,k) = 1;
    if(m>1)
        K8(m-1,k) = 1;
        l=l+2;
    end
end

I1 = mask(image,K1);
I2 = mask(image,K2);
I3 = mask(image,K3);
I4 = mask(image,K4);
I5 = mask(image,K5);
I6 = mask(image,K6);
I7 = mask(image,K7);
I8 = mask(image,K8);

v = size(image);

grad = zeros(v);

h = waitbar(0,'Calculating direction');
    steps = v(1);
    
for a = 1:v(1)
    waitbar(a/steps);
    
    for b = 1:v(2)
      
      max = I1(a,b);
      grad(a,b)=90;
      
      if(max<I2(a,b))
          max = I2(a,b);
          grad(a,b)=67.5;
      elseif(max<I3(a,b))
          max = I3(a,b);
          grad(a,b)=45;
      elseif(max<I4(a,b))
          max = I4(a,b);
          grad(a,b)=22.5;
      elseif(max<I5(a,b))
          max = I5(a,b);
          grad(a,b)=0;
      elseif(max<I6(a,b))
          max = I6(a,b);
          grad(a,b)=-22.5;
      elseif(max<I7(a,b))
          max = I7(a,b);
          grad(a,b)=-45;
      elseif(max<I8(a,b))
          max = I8(a,b);
          grad(a,b)=-67.5;
      end
      
      if(max<tr)
          grad(a,b) = NaN;
      end        
           
        
    end    
end
close(h);
%oriDraw_8dir(image,grad,s);
I = grad;


