
loadprh('ea16_207a');
start=30;
ende=225000;
pp1=p(start:ende);
%pp2=p(start:ende);
plott(p,fs);
hold on
plott(pp1,fs);
xx1=msa(A);
hold off
loadprh('bm08_130a');
start2=1;
ende2=49000;
pp2=p(start2:ende2);
%pp2=p(start:ende);
plott(p,fs);
hold on
plott(pp2,fs);
xx2=msa(A);
hold off
loadprh('eg09_107a');
start3=1;
ende3=73000;
pp3=p(start3:ende3);
%pp2=p(start:ende);
plott(p,fs);
hold on
plott(pp3,fs);
xx3=msa(A);
hold off

figure
subplot(3,4,[1,3]);
%plott(pp1,fs)
plot((1:length(pp1))/fs/6000,pp1);
set(gca,'ydir','reverse') %reverses the y-axis so the depths are positive
ylim([-1 20]);
xlim([0 7.5])
hold on
plot(xx1-20,fs)
title('Lactating southern right whale','FontSize',14)
ylabel('Depth (meters)','FontSize',14)
xlabel('Time since tag on (hours)','FontSize',14)

subplot(3,4,4);
[counts bins] = hist(pp1);
pcts = 100 * counts / sum(counts);
barh(bins,pcts);
xlim([0 70]);
ylim([-1 20]);
set(gca,'Ydir','reverse','FontSize',14);
title('Time (%)')
hold on

subplot(3,4,[5,7]);
%plott(pp2,fs)
plot((1:length(pp2))/fs/3600,pp2);
set(gca,'ydir','reverse')
ylim([-1 50]);
xlim([0 2.72]);
title('Foraging bowhead whale','FontSize',14)
ylabel('Depth (meters)','FontSize',14)
xlabel('Time since tag on (hours)','FontSize',14)

subplot(3,4,8)
[counts2 bins2] = hist(pp2);
pcts2 = 100 * counts2 / sum(counts2);
barh(bins2,pcts2);
xlim([0 70]);
ylim([-1 50]);
set(gca,'Ydir','reverse');
hold on

subplot(3,4,[9,11]);
%plott(pp3,fs)
plot((1:length(pp3))/fs/3600,pp3);
set(gca,'ydir','reverse')
ylim([-1 30]);
xlim([0 4.05]);
title('Foraging north atlantic right whale','FontSize',14)
ylabel('Depth (meters)','FontSize',14)
xlabel('Time since tag on (hours)','FontSize',14)

subplot(3,4,12)
[counts3 bins3] = hist(pp3);
pcts3 = 100 * counts3 / sum(counts3);
barh(bins3,pcts3);
xlim([0 70]);
ylim([-1 30]);
set(gca,'Ydir','reverse');
hold on

set(gcf,'color','w');

