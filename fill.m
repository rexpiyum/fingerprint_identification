    function I = fill(image,n)
    I = image;
    v = size(I);
    mirror = zeros(v);
    
    
    vk = n;
wx = floor(vk/2);
wy = floor(vk/2);

h = waitbar(0,'Filling holes...');
    steps = v(1);

for a = vk:3:v(1)
     waitbar(a/steps)
        
    for b = vk:v(2)
        
        a0 = a+1-vk;
        b0 = b+1-vk;
        
        M = I(a0:a,b0:b);
        F = imfill(M,'holes');
        
        mirror(a0:a,b0:b) = mirror(a0:a,b0:b)|F(1:n,1:n);
      
    end
end
close(h);
I = mirror;