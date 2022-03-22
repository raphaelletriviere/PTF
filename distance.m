function dist=distance(LAT1, LONG1, LAT2, LONG2)

dist=zeros(1,length(LAT1));

for i=1:length(LAT1)
         D=(2*asind(sqrt(sind((LAT1(i)-LAT2)/2)^2+(1-sind((LAT1(i)-LAT2)/2)^2-sind((LAT1(i)+LAT2)/2)^2)*sind((LONG1(i)-LONG2)/2)^2))); 
        % D=(2*asind(sqrt(sind((LAT1(i)-LAT2)/2)^2+(1-sind((LAT1(i)-LAT2)/2)^2-sind((LAT1(i)+LAT2)/2)^2)*sind((LONG1(i)-LONG2)/2)^2))*111);
        % to put in meter 
         dist(i)=D;    
end 
dist=dist';
 
