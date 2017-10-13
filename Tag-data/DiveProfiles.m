%% Dive profiles with MSA, roll, pitch, heading (and jerk)
clear

loadprh('ea16_218a')
plott(p,fs) ; % plots the dive profile
hold on;
%plott(A,fs) ; % plots roll, pitch and heading
set(gca,'ydir','reverse') %reverses the y-axis so the depths are positive
hold on;
xx=msa(A);
plott(-xx+15,fs)
hold on;
Thirty = [5868.5,6107.3,6473.9];
D1 = [-1,-1,-1];
Ten = [5902.7,5963.9,6080.3,6504.5,6866.9];
D2 = [-1,-1,-1,-1,-1];
Five = [5918.9,5997.5,6035.9,6524.3,6550.1];
D3 = [-1,-1,-1,-1,-1];
A = [6398.9];
D4 = [-1];
L = [6192.5,6970.277646];
D5 = [-1,-1];
% Tider = [5868.5,5902.7,5918.9,5963.9,5997.5,6035.9,6080.3,6107.3,6192.5,6398.9,6447.5,6473.9,6504.5,6524.3,6550.1,6866.9,6970.277646];
% Dybde = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
scatter(Thirty,D1,'r')
hold on
scatter(Ten, D2,'g')
hold on
scatter(Five,D3,'y')
hold on
scatter(A,D4,'b')
hold on
scatter(L,D5,'k')
legend({'Dive profile of mom','MSA','Drone 30m above whale','Drone 10m above whale','Drone 5m above whale', 'Drone approaching whale','Drone leaving whale'},'Location','Northeast','FontSize',18)


%jerk=norm2(diff(A))*20;
%plot((1:length(jerk))/fs/60,-jerk);

