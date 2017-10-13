




%% Get the tracks from the flight records
clear,

pa = '/Users/MiaKronborg/Documents/Specialeprojekt/HoB17/Data/20170731/FlightRecords/20170731.22.05.csv'

FR = readtable(pa);

% delete all rows that does not fit ALL the following paramteres:
%   1. altitude_feet (column 3): 60-80
%   2. gimbal_pitch_degrees_ (column 23): -89 to -90 degrees
%   3. compass_heading_degrees_ (column 15): 350-360 AND 0-10

Con1 = FR.altitude_feet_>80 ;
Con2 = FR.gimbal_pitch_degrees_>-88 ;
Con3 = FR.compass_heading_degrees_<350 & FR.compass_heading_degrees_>10 ;

TFall = Con1 | Con2 | Con3;
FR(TFall,:) = []; 

% Extract only every 10th row (so only data from every sec). 

FRmod = FR(1:10:end,:);

% convert table inco cell array
 FRcells = table2cell(FRmod) ;

% extract lat, long and time 
 FRcut = FRcells(:,[1 2 3 7]) ;

% convert cell array to matrix
 FRmat = cell2mat(FRcut);

% plot the track using lat/long 
plot(FRmat(:,1),FRmat(:,2))

% Find length of GPS track and estimate speed  

%route = gpxread('sample_route.gpx'); % some sample data
route = FRmod ;
lat = route.latitude;
lon = route.longitude;
time = 0:length(lon)-1; % assume GPS measurements logged every minute

% Create a map of the route:
figure('position',[100 50 560 800])
subplot(3,1,1)
worldmap([min(lat)-.05 max(lat)+.05],[min(lon)-.08 max(lon)+.08])
plotm(lat,lon,'k.')
textm(lat(1),lon(1),'Start','color',[.01 .7 .1])
textm(lat(end),lon(end),'End','color','r')


% Plot distance traveled:
metersTraveled = pathdist(lat,lon);

subplot(3,1,2)

N = sum(length(time))+1; % number of colors. Assumed to be greater than size of x
cmap = parula(N); % colormap, with N colors
linewidth = 1.5; % desired linewidth
xi = time(1)+linspace(0,1,N+1)*time(end); % interpolated x values
yi = interp1(time,metersTraveled,xi); % interpolated y values
hold on
for n = 1:N
    plot(xi([n n+1])/60, yi([n n+1]), 'color', cmap(n,:), 'linewidth', linewidth);
end
box off; axis tight;
xlabel('time (minutes)')
ylabel('meters traveled')

% Plot speed:
speed = diff(metersTraveled/1000)./(diff(time/60/60)).';
speed = [0 ; speed];

subplot(3,1,3)

N = sum(length(time))+1; % number of colors. Assumed to be greater than size of x
cmap = parula(N); % colormap, with N colors
linewidth = 1.5; % desired linewidth
xi = time(1)+linspace(0,1,N+1)*time(end); % interpolated x values
yi = interp1(time,speed,xi); % interpolated y values
hold on
for n = 1:N
    plot(xi([n n+1])/60, yi([n n+1]), 'color', cmap(n,:), 'linewidth', linewidth);
end
% plot(time(2:end)/60,speed)
box off; axis tight
xlabel('time (minutes)')
ylabel('speed (km/hr)')
ylim([0 8]);

% Still need to find a way to get distance, time and average speed for all
% tracks -- make loop and get these values into a table where they are
% related to the track.id


