% save testvar start and end:
% start=1.0e+02*8.0
% ende=1.0e+02*2300
% save testvar start ende 

%ea16_207a
loadprh('ea16_207a');
plot((1:length(p(1.0e+02*8.0:1.0e+02*2300)))/fs/3600,-p(1.0e+02*8.0:1.0e+02*2300));
% hold on;
% loadcal(????)
% xx=msa(A);
% plot((1:length(xx))/fs/60,xx-15);

%ea16_208a
loadprh('ea16_208a');
plot((1:length(p(1.0e+05*0.1465:1.0e+05*1.4)))/fs,-p(1.0e+05*0.1465:1.0e+05*1.4));
plot((1:length(p))/fs/60,-p);

%ea16_209a
loadprh('ea16_209a');
plot((1:length(p(1.0e+04*0.2:1.0e+04*53.5)))/fs/3600,-p(1.0e+04*0.2:1.0e+04*53.5));

%ea16_210a
loadprh('ea16_210a');
plot((1:length(p(1.0e+04*0.005:1.0e+04*7.045)))/fs/3600,-p(1.0e+04*0.005:1.0e+04*7.045));

%ea16_214b
loadprh('ea16_214b');
plot((1:length(p(1.0e+04*24.0:1.0e+04*29.6)))/fs/3600,-p(1.0e+04*24.0:1.0e+04*29.6));
plot((1:length(p))/fs/3600,-p);
%ea16_217a
loadprh('ea16_217a');
plot((1:length(p))/fs/3600,-p);

%ea16_218a
loadprh('ea16_218a');
plot((1:length(p(1.0e+04*6:1.0e+04*30)))/fs/3600,-p(1.0e+04*6:1.0e+04*30));

%ea16_218b
loadprh('ea16_218b');
plot((1:length(p(1.0e+04*0.005:1.0e+04*15.0)))/fs/3600,-p(1.0e+04*0.005:1.0e+04*15.0));
plot((1:length(p))/fs,-p);



% % plotting 
% loadprh('ea16_210a');
% plot((1:length(p))/fs,-p); %plot diveprofile - pressure on y-axis and 
% xx=msa(A); %MSA - minimum specific acceleration in m/s^2
% hold on;
% plot((1:length(xx))/35135,xx-15);
% loadprh('ea16_208a');
% plot((1:length(p))/fs,-p);
% clf %remove from plot
% plot((1:length(p))/40889,-p);
% ginput;
% plot((1:length(p(1.0e+04*0.005:1.0e+04*15.0)))/fs,-p(1.0e+04*0.005:1.0e+04*15.0));
% hold on;
% plot((1:length(A)),A);
% xlim([1.0e+05*0.2146 1.0e+05*3.7500]);
% plot((1:length(p)),-p);
% hold on;
% plot((1:length(A(1.0e+05*0.2146:1.0e+05*1.200))),A(1.0e+05*0.2146:1.0e+05*1.200));

%  plot(x,y,'-o,'MarkerIndices',[1 5 10]) displays a circle marker at the first, fifth, and tenth data points.

%% Plot subset of dive profile + MSA + pitch/roll
tag = 'ea16_214b';
prefix = 'ea214b';
recdir = '/Volumes/ADATA_B/Augusta2016/010816/DTAG/ea16_214b' ;
R = loadaudit(tag);
loadprh(tag);

index = find(cellfun('length', regexp(R.stype, 'mb')) == 1 );
cues=R.cue(:,1);
l=R.cue(:,2);

mb = cues(index);

figure
subplot(4,1,1)
blue_colour = [23 80 228] ./ 255;
plot((1:length(p))/fs/60,p,'Color',blue_colour) ;
set(gca,'ydir','reverse') ;
hold on;
x = mb/60;
y = 0;
plot(x,y,'r:.','MarkerSize',15);
ylabel('Depth (meter)');
xlim([415 450]);
ylim([-0.5 10]);
set(gca,'XTick',[]);
set(gca,'xcolor',[1 1 1]);
 
subplot(4,1,2);
bbb = [50 92 131] ./ 255;
plot((1:length(pitch))/fs/60,pitch,'Color',bbb);
ylabel('Pitch (degrees)');
ax.YGrid = 'on';
xlim([415 450]);
ylim([-1.2 1.2]);
set(gca,'XTick',[]);
set(gca,'xcolor',[1 1 1]);
set(gca, 'YMinorGrid', 'on');

subplot(4,1,3);
ggg = [30 123 135] ./ 255;
plot((1:length(roll))/fs/60,roll,'Color', ggg);
ylabel('Roll (degrees)')
xlim([415 450]);
ylim([-2 3]);
set(gca,'XTick',[]);
set(gca,'xcolor',[1 1 1]);
set(gca, 'YMinorGrid', 'on');

subplot(4,1,4)
xx=msa(A);
plot((1:length(xx))/fs/60,xx,'Color', [0.5 0.5 0.5]);
xlabel('Time (minutes)')
ylabel('MSA (m s^2)')
xlim([415 450]);
ylim([0 2.5]);

legend(figure,l);



%% Recover audit when error occurs
load('d3audit_recover.mat')

%% plot specgram and jerk for resp
n = 3;
tag = 'ea16_210a';
prefix = 'ea210a';
recdir = '/Volumes/ADATA_B/Augusta2016/280716/DTAG/ea16_210a' ;
R = loadaudit(tag);
loadprh(tag);
jerk = norm2(diff(A));

index = find(cellfun('length', regexp(R.stype, 'mb')) == 1 );
cues=R.cue(:,1);
l=R.cue(:,2);

mb = cues(index);

% tid = 2;
start = mb(n)-3;
stop = mb(n)+3;

[x,afs] = d3wavread([start stop], recdir, prefix);

figure
subplot(2,1,1)
BL = 4000;
CH = 1;
specgram(x(:,CH),BL,afs,hamming(BL),round(BL*0.9));
caxis([-50 0]);
ylabel('Frequency (Hz)')
% xlim([0 1]);

subplot(2,1,2);
plot((1:length(jerk(start*fs:stop*fs)))/fs, jerk(start*fs:stop*fs));
xlabel('Time (seconds)')
ylabel('Jerk (m s^-^3)')
% xlim([0 1]);