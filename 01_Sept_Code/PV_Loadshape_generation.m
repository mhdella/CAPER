%code to load in selected PV site for simulation.
%{
clear
UIControl_FontSize_bak = get(0, 'DefaultUIControlFontSize');
set(0, 'DefaultUIControlFontSize', 18);
sim_type=menu('Import data from which source?','PV_kw with VI/CI','DEC NUG Solar Farms');
while sim_type<1
    sim_type=menu('Import data from which source?','PV_kw with VI/CI','DEC NUG Solar Farms');
end

if sim_type == 1
    PV_Site=menu('Choose Site:','Shelby,NC (King''s Mtn','Murphy,NC (western tip)','Taylorsville,NC (middle of DEC)');
    while sim_type<1
        PV_Site=menu('Choose Site:','Shelby,NC (King''s Mtn','Murphy,NC (western tip)','Taylorsville,NC (middle of DEC)');
    end
elseif sim_type == 2
    PV_Site=menu('Choose Site:','5.0MW - Mocksville Farm','3.5MW - Ararat Rock 3.5MW','1.5MW - Old Dominion','1.0MW - Mayberry Farm');
    while sim_type<1
        PV_Site=menu('Choose Site:','5.0MW - Mocksville Farm','3.5MW - Ararat Rock 3.5MW','1.5MW - Old Dominion','1.0MW - Mayberry Farm');
    end
end
%}
%Load Results from individual analysis:
addpath(PV_Site_path);

if PV_Site == 1
    load M_SHELBY_INFO.mat
    M_PVSITE_INFO.RR_distrib = M_SHELBY_INFO.RR_distrib;
    M_PVSITE_INFO.kW = M_SHELBY_INFO.kW;
    M_PVSITE_INFO.name = M_SHELBY_INFO.name;
    load M_SHELBY.mat

    for i=1:1:12
        M_PVSITE(i).DAY(:,:) = M_SHELBY(i).DAY(1:end-1,1:6);    
        M_PVSITE(i).RR_1MIN(:,:) = M_SHELBY(i).RR_1MIN(:,1:3);
        M_PVSITE(i).PU(:,:) = M_SHELBY(i).kW(1:end-1,1)./M_PVSITE_INFO.kW;
    end
    clearvars M_SHELBY_INFO M_SHELBY
elseif PV_Site == 2
    %MURPHY
    load M_MURPHY_INFO.mat
    M_PVSITE_INFO.RR_distrib = M_MURPHY_INFO.RR_distrib;
    M_PVSITE_INFO.kW = M_MURPHY_INFO.kW;
    M_PVSITE_INFO.name = M_MURPHY_INFO.name;
    load M_MURPHY.mat

    for i=1:1:12
        M_PVSITE(i).DAY(:,:) = M_MURPHY(i).DAY(1:end-1,1:6);    
        M_PVSITE(i).RR_1MIN(:,:) = M_MURPHY(i).RR_1MIN(:,1:3);
        M_PVSITE(i).PU(:,:) = M_MURPHY(i).kW(1:end-1,1)./M_PVSITE_INFO.kW;
    end
    clearvars M_MURPHY_INFO M_MURPHY
elseif PV_Site == 3
    %TAYLOR
    load M_TAYLOR_INFO.mat
    M_PVSITE_INFO.RR_distrib = M_TAYLOR_INFO.RR_distrib;
    M_PVSITE_INFO.kW = M_TAYLOR_INFO.kW;
    M_PVSITE_INFO.name = M_TAYLOR_INFO.name;
    load M_TAYLOR.mat

    for i=1:1:12
        M_PVSITE(i).DAY(:,:) = M_TAYLOR(i).DAY(1:end-1,1:6);    
        M_PVSITE(i).RR_1MIN(:,:) = M_TAYLOR(i).RR_1MIN(:,1:3);
        M_PVSITE(i).PU(:,:) = M_TAYLOR(i).kW(1:end-1,1)./M_PVSITE_INFO.kW;
    end
    clearvars M_TAYLOR_INFO M_TAYLOR
elseif PV_Site == 4
    load M_MOCKS_INFO.mat
    M_PVSITE_INFO.RR_distrib = M_MOCKS_INFO.RR_distrib;
    M_PVSITE_INFO.kW = M_MOCKS_INFO.kW;
    M_PVSITE_INFO.name = M_MOCKS_INFO.name;
    load M_MOCKS.mat

    for i=1:1:12
        M_PVSITE(i).DAY(:,:) = M_MOCKS(i).DAY(1:end-1,1:6);    
        M_PVSITE(i).RR_1MIN(:,:) = M_MOCKS(i).RR_1MIN(:,1:3);
        M_PVSITE(i).PU(:,:) = M_MOCKS(i).kW(1:end-1,1)./M_PVSITE_INFO.kW;
    end
    clearvars M_MOCKS_INFO M_MOCKS
elseif PV_Site == 5
    load M_AROCK_INFO.mat
    M_PVSITE_INFO.RR_distrib = M_AROCK_INFO.RR_distrib;
    M_PVSITE_INFO.kW = M_AROCK_INFO.kW;
    M_PVSITE_INFO.name = M_AROCK_INFO.name;
    load M_AROCK.mat

    for i=1:1:12
        M_PVSITE(i).DAY(:,:) = M_AROCK(i).DAY(1:end-1,1:6);    
        M_PVSITE(i).RR_1MIN(:,:) = M_AROCK(i).RR_1MIN(:,1:3);
        M_PVSITE(i).PU(:,:) = M_AROCK(i).kW(1:end-1,1)./M_PVSITE_INFO.kW;
    end
    clearvars M_AROCK_INFO M_AROCK

elseif PV_Site == 6
    load M_ODOM_INFO.mat
    M_PVSITE_INFO.RR_distrib = M_ODOM_INFO.RR_distrib;
    M_PVSITE_INFO.kW = M_ODOM_INFO.kW;
    M_PVSITE_INFO.name = M_ODOM_INFO.name;
    load M_ODOM.mat

    for i=1:1:12
        M_PVSITE(i).DAY(:,:) = M_ODOM(i).DAY(1:end-1,1:6);    
        M_PVSITE(i).RR_1MIN(:,:) = M_ODOM(i).RR_1MIN(:,1:3);
        M_PVSITE(i).PU(:,:) = M_ODOM(i).kW(1:end-1,1)./M_PVSITE_INFO.kW;
    end
    clearvars M_ODOM_INFO M_ODOM
elseif PV_Site == 7
    load M_MAYB_INFO.mat
    M_PVSITE_INFO.RR_distrib = M_MAYB_INFO.RR_distrib;
    M_PVSITE_INFO.kW = M_MAYB_INFO.kW;
    M_PVSITE_INFO.name = M_MAYB_INFO.name;
    load M_MAYB.mat

    for i=1:1:12
        M_PVSITE(i).DAY(:,:) = M_MAYB(i).DAY(1:end-1,1:6);    
        M_PVSITE(i).RR_1MIN(:,:) = M_MAYB(i).RR_1MIN(:,1:3);
        M_PVSITE(i).PU(:,:) = M_MAYB(i).kW(1:end-1,1)./M_PVSITE_INFO.kW;
    end
    clearvars M_MAYB_INFO M_MAYB
end
%%
%For (1) Day simulation with spec. DARR category:
%DOY = 50;
DOY = M_PVSITE_INFO.RR_distrib.Cat5(1,1);
CAT = 5;
if CAT == 1
    RR_distrib = M_PVSITE_INFO.RR_distrib.Cat1(:,1:7);
elseif CAT == 2
    RR_distrib = M_PVSITE_INFO.RR_distrib.Cat2(:,1:7);
elseif CAT == 3
    RR_distrib = M_PVSITE_INFO.RR_distrib.Cat3(:,1:7);
elseif CAT == 4
    RR_distrib = M_PVSITE_INFO.RR_distrib.Cat4(:,1:7);
elseif CAT == 5
    RR_distrib = M_PVSITE_INFO.RR_distrib.Cat5(:,1:7);
end
%Day selection:
for i=1:1:length(RR_distrib(:,1))
    if RR_distrib(i,1) == DOY
        %Day match!
        MNTH = RR_distrib(i,2);
        DAY = RR_distrib(i,3);
    end
    break
end
%Now lets pull the kW in P.U. matrix for that specified day:
PV_loadshape_daily = M_PVSITE(MNTH).PU(time2int(DAY,0,0):time2int(DAY,23,59),1);
%Export to .csv & clear variables that are not needed:
clearvars M_PVSITE RR_distrib
%s = strtok(ckt_direct,'\Run_Master_Allocate.dss');
s = ckt_direct(1:end-23);
str = ckt_direct;
idx = strfind(str,'\');
str = str(1:idx(8)-1);
if timeseries_span == 1
    s_pv = strcat(s,'\PV_loadshape_daily.txt');
elseif timeseries_span == 2
    s_pv = strcat(s,'\PV_loadshape_weekly.txt');
end
csvwrite(s_pv,PV_loadshape_daily)
%type PV_loadshape.dat



