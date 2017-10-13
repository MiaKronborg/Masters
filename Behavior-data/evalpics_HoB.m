
% Get two coordinates for mom and two for calf. Clicks come in the following order:
%   First click = rostrum mom
%   Second click = blowhole mom
%   Third click = rostrum calf
%   Fourth click = blowhole calf
% If mom and/or calf not visible click above picture frame (will produce a
% NaN coordinate for each click. 
% When ready for next frame click to the right of the picture frame.
% If mistake was made click to the left of picture frame AFTER having
% positioned all four clicks. This will show the previous frame that is
% then overwritten.
% If 'reset' of text file is needed set reset=1. If reset=0 the file is
% read from where it was abandonded in previous session. 

clear
videre=0;
fejl=0;
pa = '/Volumes/ADATA_B/Augusta2017/20170812/frames/' ;
di = 'DJI_0002/';
reset=0;   % to overwrite text file and start over set reset=1

d = dir([pa di]) ;
mfd=zeros(length(d),1);
for j=1:length(d)
    mfd(j)=isempty(strfind(d(j).name,'.jpg')); 
end
d(logical(mfd)) = [] ; % removes non-images from d
%  d([1,1])=[]; %only needed if some files are 'hidden' files and not .jpg
if reset
        pos = zeros(length(d),8) ;
else
try
    pos=load([pa di(1:end-1) '.txt']);
catch
    pos = zeros(length(d),8) ; % creates new pos matrix if there is nothing to load
end
end
tester=sum(pos,2);
strt=find(tester==0,1,'first');
j=strt; % find the next row where sum is 0, and begin with that image
while j<=length(d)
    im=imread([pa di d(j).name]);
    image(im)
    %axis xy
    if j==strt,rammer=axis;end
    try
    %data=ginput(1);
    data(1,:)=ginput(1);
    if data(1,1)>rammer(2) && data(1,2)>rammer(4);
        data(1:4,:)=nan;
        videre=1;
    else 
        data(2:4,:)=ginput(3);
        videre=0;
    end;
    catch
        fejl=1;
        j=length(d)+2;
    end
    if ~fejl
        data(data(:,2)<rammer(3),:)=nan; % creates NaN if click is above pic
        pos(j,:)=data([1 5 2 6 3 7 4 8]);
        save([pa di(1:end-1) '.txt'],'pos','-ascii')
        hold on 
        for k=1:4
            plot(pos(j,k*2-1),pos(j,k*2),'*')
        end
    if  ~videre
        gylle=ginput(1);
        gylle=gylle(1);
    else
        gylle=rammer(2)+1;
    end
        if (gylle<0) && (j>0) 
            j=j-1;              % after four clicks used a click on the left side of pic makes it go back one frame
        elseif gylle>rammer(2)
            j=j+1;              % after four clicks used a click on right side of pic makes it go forward to next
        end
        hold off
    end
end
sav=input('save backup? (0/1)');
if sav
save([pa di(1:end-1) 'backup.txt'],'pos','-ascii')
end