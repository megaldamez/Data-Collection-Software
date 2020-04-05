clear all;


s = serial('COM5');
fopen(s)
fgetl(s)
% fclose(s)
% delete(s)
% delete(instrfindall)
FS = 80e6;
Filt.BPF = fir1(100, [2e6/(FS/2) 10e6/(FS/2)]);
loadlibrary('C:\DLL_USKEY_x64\Ap_int_usb.dll','C:\DLL_USKEY_x64\Ap_int_usb.h','alias','ApintUsb')
depthSample = 7000;
Err_Code(1) = int16(1);
Product = uint32(1);
Channel = uint32(0);
Out1(1) = uint16(1);
Out2(1) = uint16(1);
Out3(1) = uint16(1);
Out4(1) = uint16(1);
Out5(1) = uint16(1);
Out6(1) = uint16(1);
Len(1) = int16(depthSample);
Array(Len) = uint16(0);

NumCol = 1;
NumFrm = 1000;
DataArray = zeros(Len,NumFrm);
DataArray_f = zeros(Len,NumFrm);
DataAngle = zeros(NumCol,NumFrm);
% DataAngle2 = zeros(NumCol,NumFrm);
% calllib('ApintUsb','ApintUsb',Product,Channel,'KillExeX32',0,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)

%Function = 'RunExeX32';

Err_Code=calllib('ApintUsb','ApintUsb',Product,Channel,'RunExeX32',0,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)				% Loading x32 to x64 resident


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loading DLL and Init US-key %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


calllib('ApintUsb','ApintUsb',Product,Channel,'Init usb',0,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                                   % Loadind DLL
calllib('ApintUsb','ApintUsb',Product,Channel,'load configuration',1,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                         % Init US-Key


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% US-Key Transmitter management   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PRF = 0.5;                                                          % PRF (KHz)
% special value PRF = 0.07 (external sync)

Tension = 150;                                                      % Voltage (Volts)
% from 30 to 230 Volts

Largeur_Pulse = 55;                                                  % Pulse width (0 <= Byte <= 255)
% 0=18ns then 255 steps of 6.25ns

Retard_Pulse = 0;                                                   % Pulse Delay (탎)
% step of 1.6탎

calllib('ApintUsb','ApintUsb',Product,Channel,'Prf',PRF,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'voltage',Tension,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'width',Largeur_Pulse,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'pulse delay',Retard_Pulse,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% US-Key Receiver management       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Filtre = 2;                                                         % Filters  :
% 0 => 1.25 MHz
% 1 => 2.5 MHz
% 2 => 5 MHz
% 3 => 10 MHz
% 4 => Large bande

Mode = 0;                                                           % Mode
% 0 => Pulse Echo
% 1 => Pitch & catch

Gain = 20;                                                          % Gain 0 ?79.9 dB

Retard_Num = 0;                                                     % Scale Delay (탎)

Freq_Num = 1;                                                       % Sampling frequencies FOLLOWING PURCHASED OPTIONS :
% 0 => 160 MHz
% 1 => 80 MHz
% 2 => 40 MHz
% 3 => 20 MHz

calllib('ApintUsb','ApintUsb',Product,Channel,'filter/mode',Filtre,Mode,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'Gain',Gain,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'scale delay',Retard_Num,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'samplingfreqmode',Freq_Num,Mode,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% US-Key Gates management                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Num_Porte = 1;                                                      % Gate number
% N?: 1 -> 3

Pos_Porte = 10;                                                     % Gate Position (탎)

Larg_Porte = 5;                                                     % Gate Width (탎)

Seuil_Porte = 30;                                                   % Threshold (%)

calllib('ApintUsb','ApintUsb',Product,Channel,'gate position',Num_Porte,Pos_Porte,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'gate width',Num_Porte,Larg_Porte,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'gate hight',Num_Porte,Seuil_Porte,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
calllib('ApintUsb','ApintUsb',Product,Channel,'relays',bin2dec('000'),0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                      % Alarms (On appearence or vanish)
% Bit0=Gate1, Bit1=Gate2, Bit2=Gate3
% 0 => Alarm on appearence
% 1 => Alarm on vanish
% Exemple : bin2dec('001') => Gate3 & Gate2 on appearence - Gate1 on vanish

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% US-Key A-scan                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Type_Donnees = 0;                                                   % Kind :
% 0 -> Raw signal
% 1 -> Rectified A-scan

Nb_Echantillons = Len;                                             % Number of samples

Forme_Onde = 0;                                                     % Wave :
% 0 -> Double alternance
% 1 -> Negative Alternance
% 2 -> Positiive Alternance

%%% calllib('ApintUsb','ApintUsb',Product,Channel,'Ascan',Type_Donnees,0,Nb_Echantillons,Forme_Onde,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)

calllib('ApintUsb','ApintUsb',Product,Channel,'Scale A-scan counter',Nb_Echantillons/2,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
% tic

for i = 1:1000
    fgetl(s);
end

aa=0;
ardui = arduino(s,'Uno');
%     minangle = round(96.33*2);
%     maxangle = round(154.05*2);
minangle = round(165*2);
maxangle = round(238*2);
maxsize = round(maxangle-minangle);
newenv = zeros(depthSample,maxsize);
for j=1:NumFrm
    tic
    
    %for i=1:NumCol
    %     DataAngle1(j)=readangle(ardui);
    [Err_Code Function Out1 Out2 Out3 Out4 Out5 Out6 Array Len] = calllib('ApintUsb','ApintUsb',Product,Channel,'A-scan',Type_Donnees,0,Nb_Echantillons,Forme_Onde,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len);
    flushinput(s)
    fgetl(s);
    %     angle = fgetl(s)
    DataAngle(j) = str2double(fgetl(s));
    DataArray(:,j) =  Array(1:Len)';
    DataArray_f(:,j) = convn(DataArray(:,j), Filt.BPF', 'same');
    rawangle = round(DataAngle(j)*2);
    
    angle = rawangle - minangle + 1;
    newenv(:,angle) = newenv(:,angle)/2 + abs(hilbert(DataArray_f(:,j)))/2;
    %     for i = 1:10000
    % fgetl(s)
    % end
    
    %     DataAngle2(j)=readangle(ardui);
    
    %end
    
    figure(1)
    
    imagesc(log(abs(hilbert(newenv(500:4000,3:end)))));
    %     plot(DataArray_f(:,j));
    %     ylim([1800 2200]);
    %     ylim([-100 100]);
    drawnow;
    
    %     j
    aa=aa+1;
    toc
end
fclose(s)
delete(s)
delete(instrfindall)
%save('Data170120_2.mat','-v7.3')

% toc
%%plot(Array)
% xlabel('Samples');
% ylabel('Amplitude');

calllib('Ap+intUsb','ApintUsb',Product,Channel,'KillExeX32',0,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)

clear all;