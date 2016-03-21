function I = dynamicMask(image,n,grad,x)
v = size(image);
I = zeros(v);

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

vk = n;
wx = floor(vk/2);
wy = floor(vk/2);

h = waitbar(0,'Applying directional mask');
    steps = v(1);
    
for a = vk:v(1)
   
    waitbar(a/steps);
    
    for b = vk:v(2)
        
        direction = averageDirection(a-wx,b-wy,grad,x);
        
        if(direction>0)
            
            if(direction == 1)
                kernal = K1;
            elseif(direction == 2)
                kernal = K2;
            elseif(direction == 3)
                kernal = K3;
            elseif(direction == 4)
                kernal = K4;
            elseif(direction == 5)
                kernal = K5;
            elseif(direction == 6)
                kernal = K6;
            elseif(direction == 7)
                kernal = K7;
            elseif(direction == 8)
                kernal = K8;
                
            end
       
            
            M= image(1+a-vk:a,1+b-vk:b);
            val = sum(sum(M.*kernal));
       
            I(a-wx,b-wy) = val;
            
        else
            I(a-wx,b-wy) = -500;
        end
       
    end
end
close(h);