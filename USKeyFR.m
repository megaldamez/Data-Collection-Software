clear all;

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
Len(1) = int16(8000);
Array(Len) = uint16(0);                                

%Function = 'RunExeX32'; 

Err_Code=calllib('ApintUsb','ApintUsb',Product,Channel,'RunExeX32',0,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chargement de la DLL et initialisation de chaque US-key %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


calllib('ApintUsb','ApintUsb',Product,Channel,'Init usb',0,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                                    % Chargement de la DLL
calllib('ApintUsb','ApintUsb',Product,Channel,'load configuration',1,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                         % Initialisation et chargement des paramètres de configuration
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gestion Emission pour un US-Key %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PRF = 0.5;                                                          % Valeur de la fréquence de répétition de l'émission (en KHz)
                                                                    % sauf pour PRF = 0.07 (synchro soft)

Tension = 120;                                                      % Valeur de la tension de l'impulsion d'émission (en Volts)
                                                                    % de 30 à 230 Volts (l'amplitude de l'impulsion est négative)
                                                                      
Largeur_Pulse = 5;                                                  % Largeur de l'impulsion de sortie (valeur entière codée de 0 à 255)
                                                                    % La valeur 0 n'envoie pas d'impulsion
                                    
Retard_Pulse = 0;                                                   % Retard entre le début de la fenêtre de numérisation et l'impulsion d'émission
                                                                    % par pas de 1.6µs                               

calllib('ApintUsb','ApintUsb',Product,Channel,'Prf',PRF,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                                     % PRF (Pulse Repetitive Frequency) en KHz
calllib('ApintUsb','ApintUsb',Product,Channel,'voltage',Tension,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                            % Amplitude de l'impulsion d'émission en Volts
calllib('ApintUsb','ApintUsb',Product,Channel,'width',Largeur_Pulse,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                       % Largeur de l'impulsion d'émission
calllib('ApintUsb','ApintUsb',Product,Channel,'pulse delay',Retard_Pulse,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                    % Retard entre la fenêtre de numérisation et l'impulsion d'émission (pas de 1.6µs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gestion Réception pour un US-Key %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Filtre = 2;                                                         % Sélection du filtre : 
                                                                    % 0 => 1.25 MHz
                                                                    % 1 => 2.5 MHz
                                                                    % 2 => 5 MHz
                                                                    % 3 => 10 MHz
                                                                    % 4 => Large bande
                                    
Mode = 0;                                                           % Sélection du mode Emetteur/Récepteur séparés ou connectés
                                                                    % 0 => Emetteur/Récepteur connectés
                                                                    % 1 => Emetteur/Récepteur séparés
        
Gain = 20;                                                          % Gain variable de 0 à 79.9 dB

Retard_Num = 0;                                                     % Retard de numérisation

Freq_Num = 1;                                                       % Sélection de la fréquence de numérisation :
                                                                    % 0 => 160 MHz
                                                                    % 1 => 80 MHz
                                                                    % 2 => 40 MHz
                                                                    % 3 => 20 MHz

calllib('ApintUsb','ApintUsb',Product,Channel,'filter/mode',Filtre,Mode,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                     % Sélection du filtre à appliquer sur le signal ainsi que du mode Emission/Réception
calllib('ApintUsb','ApintUsb',Product,Channel,'Gain',Gain,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                                   % Gain variable de 0 à 79.9 dB
calllib('ApintUsb','ApintUsb',Product,Channel,'scale delay',Retard_Num,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                      % Retard de numérisation
calllib('ApintUsb','ApintUsb',Product,Channel,'samplingfreqmode',Freq_Num,Mode,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)              % Sélection de la fréquence de numérisation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gestion des portes de mesure pour un US-Key %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Num_Porte = 1;                                                      % Sélection du numéro de la porte à paramétrer
                                                                    % N° : 1 -> 3 

Pos_Porte = 10;                                                     % Position de la porte en µs

Larg_Porte = 5;                                                     % Largeur de la porte en µs

Seuil_Porte = 30;                                                   % Seuil de déclenchement de la porte (en %)

calllib('ApintUsb','ApintUsb',Product,Channel,'gate position',Num_Porte,Pos_Porte,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)           % Réglage de la position d'une porte de mesure
calllib('ApintUsb','ApintUsb',Product,Channel,'gate width',Num_Porte,Larg_Porte,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)             % Réglage de la largeur d'une porte de mesure       
calllib('ApintUsb','ApintUsb',Product,Channel,'gate hight',Num_Porte,Seuil_Porte,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)            % Réglage du seuil de déclenchement d'une porte de mesure
calllib('ApintUsb','ApintUsb',Product,Channel,'relays',bin2dec('000'),0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)                      % Type d'alarme (sur apparition ou disparition d'échos)
                                                                   % 1 bit correspond à une porte => 'Porte3 Porte2 Porte1'
                                                                    % 0 => Alarme sur apparition
                                                                    % 1 => Alarme sur disparition
                                                                    % Exemple : bin2dec('001') => Porte3 et Porte2 sur apparition 
                                                                    % et Porte1 sur disparition
                                                   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Acquisition des données pour plusieurs US-Key %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Type_Donnees = 0;                                                   % Type de données à recevoir :
                                                                    % 0 -> HF
                                                                    % 1 -> A-scan
                                                            
Nb_Echantillons = 3900;                                             % Nombre d'échantillons à numériser

Forme_Onde = 0;                                                     % Forme de l'onde à afficher
                                                                    % 0 -> Double alternance
                                                                    % 1 -> Alternance négative
                                                                    % 2 -> Alternance positive

%%% calllib('ApintUsb','ApintUsb',Product,Channel,'Ascan',Type_Donnees,0,Nb_Echantillons,Forme_Onde,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)

calllib('ApintUsb','ApintUsb',Product,Channel,'Scale A-scan counter',Nb_Echantillons/2,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
tic
for i=1:20
[Err_Code Function Out1 Out2 Out3 Out4 Out5 Out6 Array Len] = calllib('ApintUsb','ApintUsb',Product,Channel,'A-scan',Type_Donnees,0,Nb_Echantillons,Forme_Onde,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len);
figure(1)
plot(Array(1:Len));drawnow;
end
toc
%%plot(Array)
xlabel('Echantillons');
ylabel('Valeur');

calllib('ApintUsb','ApintUsb',Product,Channel,'KillExeX32',0,0,0,0,0,0,Out1,Out2,Out3,Out4,Out5,Out6,Array,Len)
