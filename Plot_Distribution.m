%%%%%%%%%%%%%% Load file (hazardcurves, Thresholds, coordinates of POI)

% select event.   Options: '2003_0521_boumardes', '2015_0416_crete', '2015_1117_lefkada', 
%                          '2016_0125_gibraltar', '2016_1030_norcia','2017_0612_lesbo','2017_0720_kos-bodrum',
%                          '2018_1025_zante','2019_0320_turkey','2019_0921_albania','2019_1126_albania', 
%                          '2020_0502_crete','2020_1030_samos'

HazardCurves=load('Output\HazardCurves_2020_0502_crete_sig20.mat'); %Choose the event 
HCthresholds=load("LocalInput\HCthresholds.txt");
POI_coord=load('LocalInput\med-tsumaps\POIs.mat');

%%%%%%%%%%%%%%%%%%%%%%
%Select point of interest
%%%%%%%%%%%%%%%%%%%%%%
POI_lat_med=POI_coord.POIs.lat(138:1244,:); %Mediterranean POI
POI_lon_med=POI_coord.POIs.lon(138:1244,:);

%2003_0521_boumardes: 36.868 3.652
%2015_0416_crete: 35.163 26.745
%2015_1117_lefkada: 38.804 20.511
%2016_0125_gibraltar: 35.448 -3.731
%2016_1030_norcia: 42.869 13.151
%2017_0612_lesbo: 38.848 26.376
%2017_0720_kos-bodrum: 36.918 27.444
%2018_1025_zante:37.496 20.608
%2019_0320_turkey: 37.438 29.500
%2019_0921_albania:  41.317 19.475
%2019_1126_albania:  41.365 19.541
%2020_0502_crete: 34.288 25.739
%2020_1030_samos: 37.839 26.829

earthquake_lat= 34.288; %Choose Coordinates of the event
earthquake_lon= 25.739;

figure()
geoplot(POI_lat_med,POI_lon_med,'b.',earthquake_lat,earthquake_lon,'rp',...
     'LineWidth',5)

id1=find(POI_lat_med==34.952); % Choose latitude coordinate to obtain the indice
id2=find(POI_lat_med==35.394);
id3=find(POI_lat_med==32.6248);
id4=find(POI_lat_med==32.0636);

%%%%%%%%%%%%%%%%%%%%
%Calculate distribution
%%%%%%%%%%%%%%%%%%%%
hc_poiBS=HazardCurves.HazardCurves.hc_poiBS(:,:);
mid_HCthresholds=HCthresholds/2;

tab_diff_hc_poiBS=zeros(4,65);
tab_max=zeros(4,2);
hc_poiBS_8=zeros(1,65);
diff_hc_poiBS_8=zeros(1,65);

ind=[id1,id2,id3,id4];

 for i=[id1,id2,id3,id4]
     hc_poiBS_8=hc_poiBS(i,:);
     val_1=1-hc_poiBS_8(1);
     diff_hc_poiBS_8=[val_1,-1*diff(hc_poiBS_8)];
     pos=find(i==ind);
     tab_diff_hc_poiBS(pos(1),:)=diff_hc_poiBS_8;
    
     ymax=max(diff_hc_poiBS_8);
     id_x=find(ymax==diff_hc_poiBS_8);
     xmax=mid_HCthresholds(id_x);
     tab_max(pos(1),:)=[xmax,ymax];
end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p1lon=POI_lon_med(id1,:);
p1lat=POI_lat_med(id1,:);

p2lon=POI_lon_med(id2,:);
p2lat=POI_lat_med(id2,:);

p3lon=POI_lon_med(id3,:);
p3lat=POI_lat_med(id3,:);

p4lon=POI_lon_med(id4,:);
p4lat=POI_lat_med(id4,:);

%Mediterranean plot 
xlim=[earthquake_lon-6 earthquake_lon+6];
ylim=[earthquake_lat-1 earthquake_lat+1];



figure 
subplot(2,3,1)
geoplot(earthquake_lat,earthquake_lon,'rp',p1lat,p1lon,'bo',p2lat,p2lon,'go',p3lat,p3lon,'mo',p4lat,p4lon,'co',...
     'LineWidth',1)
geolimits(ylim,xlim)
subplot(2,3,2)
bar(mid_HCthresholds,tab_diff_hc_poiBS(1,:),'b');
xlabel('Thresholds')
ylabel('probability ')
subplot(2,3,3)
bar(mid_HCthresholds,tab_diff_hc_poiBS(2,:),'g')
xlabel('Thresholds')
ylabel('probability')
subplot(2,3,5)
bar(mid_HCthresholds,tab_diff_hc_poiBS(3,:),'m')
xlabel('Thresholds')
ylabel('probability')
subplot(2,3,6)
bar(mid_HCthresholds,tab_diff_hc_poiBS(4,:),'c')
xlabel('Thresholds')
ylabel('probability')

