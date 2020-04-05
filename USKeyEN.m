clear all;

% loadlibrary('C:\DLL_USKEY_x64\DLL_USKEY_x64\Ap_int_usb.dll','C:\DLL_USKEY_x64\DLL_USKEY_x64\Ap_int_usb.h','alias','ApintUsb')
% loadlibrary('C:\Users\DLL_USKEY_x64\Ap_int_usb.dll','C:\Users\DLL_USKEY_x64\Ap_int_usb.h','alias','ApintUsb')
loadlibrary('C:\DLL_USKEY_x64\Ap_int_usb.dll','C:\DLL_USKEY_x64\Ap_int_usb.h','alias','ApintUsb')

Err_Code(1) = int16(1);
Product = uint32(1);                                                       
Channel = uint32(0);                                                      
Out1(1) = uint16(1); 
Out2(1) = uint16(1); 
Out3(1) = uint16(1); 
Out4(1) = uint16(1); 
Out5(1) = uint16(1); 
Out6(1) = uint16(1); 
Len(1) = int16(6000);
Array(Len) = uint16(0);                                

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
                                                                      
Largeur_Pulse = 120;                                                  % Pulse width (0 <= Byte <= 255)
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

Filtre = 3;                                                         % Filters  : 
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
                                                            
Nb_Echantillons = 6000;                                             % Number of samples

Forme_Onde = 0;                                                     % Wave :
                                                                    % 0 -> Double alternance
                                                                    % 1 -> Negative Alternance
                                                                    % 2 -> Positiive Alternance

%%% calllib('ApintUsb','ApintUsb',Product,Channel,'Ascan',Type_Donnees,0,Nb_Echantillons,Forme_Onde,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)

calllib('ApintUsb','ApintUsb',Product,Channel,'Scale A-scan counter',Nb_Echantillons/2,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
tic

DataArray = zeros(6000,500);
aa=0;

% a = arduino('COM3', 'Uno', 'Libraries', 'Servo');
% s = servo(a,'D4','MinPulseDuration',8e-10,'MaxPulseDuration',4e-03);
     
    for j=1:250
        
        for i=1:10

        [Err_Code Function Out1 Out2 Out3 Out4 Out5 Out6 Array Len] = calllib('ApintUsb','ApintUsb',Product,Channel,'A-scan',Type_Donnees,0,Nb_Echantillons,Forme_Onde,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len);

        figure(1)

        plot(Array(1:Len));axis([1 Len  1500 2500]);drawnow;
        DataArray(:,i,j) =  Array(1:Len)';

        end

        j
        aa=aa+1;
    end
% end

save(fullfile('C:\DLL_USKEY_x64','MQP2.mat'),'-v7.3')

toc
%%plot(Array)
xlabel('Samples');
ylabel('Amplitude');

calllib('ApintUsb','ApintUsb',Product,Channel,'KillExeX32',0,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)

clear all;