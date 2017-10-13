% Generate DTAG3 PRH and CAL file
% Online GEOMAG converter: http://www.ngdc.noaa.gov/geomag-web/#igrfwmm

clear

author     = 'Mia Lybkær';
email      = 'mialkronborg@gmail.com';
expedition = 'Augusta16' ;

% Get magnetic parameters from GEOMAG converter (once per field trip)
DECL       = -3.1167;   % magnetic declination in degrees, - = West, + = East
INCL       = -68.4508;   % magnetic inclination in degrees
FSTRENGTH  = 59422; % total field strength, microTesla
UTC2LOC    = +8 ;

% Define tag deployment constants
tag = 'ea16_207a' ;
recdir = '/Volumes/ADATA_B/Augusta2016/250716/DTAG/ea207a' ; % this will create errors if drive is mapped to different drive
prefix = 'ea16_207a' ;
df     = 25 ;

% READ SENSOR DATA
X   = d3readswv ( recdir , prefix , df ) ;

% FIND AND IMPLEMENT TAG CALIBRATION
[CAL,DEPLOY] = d3deployment ( recdir , prefix , tag )

% PERFORM CALIBRATION OF TEMPERATURE AND PRESSURE
[p,CAL]=d3calpressure(X,CAL,'full');

% PERFORM CALIBRATION OF ACCELLEROMETERS AND MAGNETOMETERS
[A,CAL,fs] = d3calacc(X,CAL,'full');
[M,CAL] = d3calmag(X,CAL,'full');

% SAVE PRH AND CAL DATA FOR AUDITING AND OTHER PROCESSING
saveprh(tag,'p','M','A','fs')
d3savecal(tag,'CAL',CAL);


% Correct to actual OTAB found using prhpredictor
PRH = prhpredictor (p,A,fs,4,2) ;
OTAB = [0 0 mean(PRH(:,2)) mean(PRH(:,3)) mean(PRH(:,4))]; %avg orientation from prhpredictor
%OTAB=[OTAB1' OTAB2' OTAB3' OTAB4' OTAB5' OTAB6' OTAB7' OTAB8']' if tag
%moves
d3savecal(tag,'OTAB',OTAB);
d3savecal(tag,'CAL',CAL);
d3makeprhfile('e:/mn12/mn12_178a','mn178a','mn12_178a',8);




% Define expedition specific information stored in cal files

% Define extra deployment specific information stored in cal file
% location       = 'Tarifa';
% ANIMAL.ID      = '92' ;
% ANIMAL.name    = '' ;
% ANIMAL.gender  = 'Male' ;
% ANIMAL.description = 'Large adult male' ;
% ANIMAL.age     = '';
% TAGON.TIME     = [2013 08 08 10 50 51] ; % Get this from xml field cue time, UTC
% TAGON.POSITION = [35.94699 -5.49839] ;
% TAGON.PHOTO    = '';
% TAGON.PLACEMENT= 'Right side';

% For Sarasota animals, when were animals released?
% TAGON.RELEASE  = [2013 05 06 11 11 03] ;
% 
% % ADD METADATA TO CAL FILE
% 
% % Who made files and recordings?
% d3savecal(tag,'AUTHOR',author);
% d3savecal(tag,'EMAIL',email);
% d3savecal(tag,'EXPEDITION',expedition);
% 
% % What were the magnetic field characteristics of the expedition site?
% d3savecal(tag,'DECL',DECL);
% d3savecal(tag,'INCL',INCL);
% d3savecal(tag,'FSTRENGTH',FSTRENGTH);
% d3savecal(tag,'UTC2LOC',UTC2LOC)
% 
% % What animal was tagged?
% d3savecal(tag,'ANIMAL',ANIMAL);
% 
% % Where and when was it tagged?
% d3savecal(tag,'LOCATION',location);
% d3savecal(tag,'TAGON',TAGON)


