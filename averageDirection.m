function direction = averageDirection(r,c,grad,n)

D = grad;


%big minus value for invalid regions
direction = -100;

    
      p = floor(n/2);
       
      Dtemp = nanmean(nanmean(D(r-p:r+p,c-p:c+p)));
     
      if (-11.25<Dtemp && Dtemp<=11.25)       %0
            direction = 5;
      
      elseif (11.25<Dtemp && Dtemp<=33.75)    %22.5
            direction = 4;
            
      elseif (33.75<Dtemp && Dtemp<=56.25)    %45
            direction = 3;
            
      elseif (56.25<Dtemp && Dtemp<=78.75)    %67.5
            direction = 2;
            
      elseif ( abs(Dtemp) >78.75)             %90
            direction = 1;  
                
      elseif (-33.75<Dtemp && Dtemp<=-11.25)  %-22.5
            direction = 6;
            
      elseif (-56.25<Dtemp && Dtemp<= -33.75) %-45
                direction = 7;
        
      elseif (-78.75<Dtemp && Dtemp<=-56.25)    %-67.5
            direction = 8;
      end
       
      
      
      
      
      
      
      
      
      
     
      
      
       
 

