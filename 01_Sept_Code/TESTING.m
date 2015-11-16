%Timeseries Analyses:
% only for ckt24

clear
clc
close all
s_b ='C:\Users\jlavall\Documents\GitHub\CAPER';
addpath('C:\Users\jlavall\Documents\GitHub\CAPER\03_OpenDSS_Circuits\EPRI_ckt24');
%addpath(strcat(s_b,'\01_Sept_Code'));
ckt_direct_prime=strcat(s_b,'\03_OpenDSS_Circuits\EPRI_ckt24\Master.dss');
%Setup the COM server
[DSSCircObj, DSSText, gridpvPath] = DSSStartup;
DSSCircuit = DSSCircObj.ActiveCircuit;

%Start simulation:
tic
DSSText.command = ['Compile ',ckt_direct_prime];

DSSText.command = 'solve loadmult=1.0';
Lines_Base = getLineInfo(DSSCircObj);
Buses_Base = getBusInfo(DSSCircObj);
Loads_Base = getLoadInfo(DSSCircObj);
%}

NAMEPLATE=zeros(1,5);
ALLOC=zeros(length(Loads_Base),1);
for i=1:1:length(Loads_Base)
    if Loads_Base(i,1).nodes == 1
        NAMEPLATE(1,1) = NAMEPLATE(1,1) + Loads_Base(i,1).xfkVA;
    elseif Loads_Base(i,1).nodes == 2
        NAMEPLATE(1,2) = NAMEPLATE(1,2) + Loads_Base(i,1).xfkVA;
    elseif Loads_Base(i,1).nodes == 3
        NAMEPLATE(1,3) = NAMEPLATE(1,3) + Loads_Base(i,1).xfkVA;
    elseif Loads_Base(i,1).nodes == [1,2,3]
        NAMEPLATE(1,4) = NAMEPLATE(1,4) + Loads_Base(i,1).xfkVA;
    end
end
%%
for i=1:1:length(Loads_Base)
    if Loads_Base(i,1).nodes == 1
        ALLOC(i,1)=Loads_Base(i,1).xfkVA/NAMEPLATE(1,1);
    elseif Loads_Base(i,1).nodes == 2
        ALLOC(i,1)=Loads_Base(i,1).xfkVA/NAMEPLATE(1,2);
    elseif Loads_Base(i,1).nodes == 3
        ALLOC(i,1)=Loads_Base(i,1).xfkVA/NAMEPLATE(1,3);
    elseif Loads_Base(i,1).nodes == [1,2,3]
        ALLOC(i,1)=Loads_Base(i,1).xfkVA/NAMEPLATE(1,4);
    end
end

%%
%Run 1-week simulation at hour 5280 out of 8760

%DSSText.command='set casename=Example1week';
%DSSText.command='set mode=yearly number=168 hour=5280'; %number=168 for 1hour intervals
%DSSText.command='set mode=yearly number=10080 hour=5280'; %number=168*60 for 1min intervals
%DSSText.command='set mode=duty number=10080 hour=5280'; %duty
%DSSText.command='set mode=daily stepsize=1m number=1440'; %stepsize is now 1minute (60s)
DSSText.command='set mode=daily stepsize=5s number=17280'; %stepsize is now        (05s)
%DSSText.command='set stepsize=60';
%DSSText.command='set mode=duty number=17280';
%DSSText.command = 'Set Controlmode=TIME';
%Other settings --c.
%Turn the overload report on:
DSSText.command='Set overloadreport=true';
DSSText.command='Set voltexcept=true';
%DSSText.command='Set demand=true'; %turns on demand interval/resets all energymeters
%DSSText.command='set DIVerbos=true';

%DSSText.command='Set Year=1';
%DSSText.command='Set hour=5280';
DSSText.command='solve';
%DSSText.command='closedi';

%%
%Now lets obtain results:
DSSText.Command = 'export mon fdr_05410_Mon_VI';
monitorFile = DSSText.Result;
MySUBv = importdata(monitorFile);
delete(monitorFile);
% 2]
DSSText.Command = 'export mon fdr_05410_Mon_PQ';
monitorFile = DSSText.Result;
MySUBp = importdata(monitorFile);
delete(monitorFile);
figure(2)
plot(MySUBp.data(:,[3,5,7]),'DisplayName','MySUBp.data(:,[3,5,7])');
title('Single Phase Real Power consumption');

% 3]
DSSText.Command = 'export mon SubXFMR_taps';
monitorFile = DSSText.Result;
MyLTC = importdata(monitorFile);
delete(monitorFile);
figure(3)
plot(MyLTC.data(:,end));
title('LTC operations');



