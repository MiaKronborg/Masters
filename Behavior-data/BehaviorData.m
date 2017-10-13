%% Behavioral data manipulation

% For each focal follow (consecutive follows over same focal whale) read in
% txt files of the behavioral entries.
% For each txt file calculate:
    % Total duration
    % Respiration rate
    % Proportion of total time 
        % spend nursing
        % spend at different distances
        % spend rubbing
        % spend backriding
        % etc
   % Occurrence of mom terminating the nursing
% Read the results for each focal follow into table 

% Input must be txt files with no spacing between variable names or
% entries.

myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.txt')); %gets all txt files in struct
formatSpec = '%f%C%C%C%C%C%C';
for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  num = readtable(fullFileName,'Delimiter','\t','Format',formatSpec);   %or readtable
  % all of your actions for filtering and plotting go here
end
   
%%   
clear

% Reading in the txt files with the behavioral entries 
pa = '/Users/MiaKronborg/Documents/Specialeprojekt/HoB17/Data/20170713/Behavior/DJI_0001kopi.txt'

formatSpec = '%f%C%C%C%C%C%C'; % Specifies the format of the data in each column. 
% f is floating-point number, C is categorical and D is date 

FF = readtable(pa,'Delimiter','\t','Format',formatSpec);

% FFcells = table2cell(FF) ;

%% Getting rid of <undefined>

TF = isundefined(FF);
FFr = rmmissing(FF);

%% Get the occurence of a behavior

summary(FF,1);
