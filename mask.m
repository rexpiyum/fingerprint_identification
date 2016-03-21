function I = mask(image, kernel)
v = size(image);
I = zeros(v);

vk = size(kernel);
wx = floor(vk(1)/2);
wy = floor(vk(2)/2);

h = waitbar(0,'Applying mask...');
    steps = v(1);
    
for a = vk(1):v(1)
    
     waitbar(a/steps)
     
    for b = vk(2):v(2)
       
       M= image(1+a-vk(1):a,1+b-vk(2):b);
       n = sum(sum(M.*kernel));
       
       I(a-wx,b-wy) = n;
       
    end
end

 close(h);
            