%%%%%%%%%%%%%%%%%%%%%%%%
% Ejecución por script %
%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% [CONFIGURACION %%%%%%%%%%
% Archivos de entrada
n_file1 = 'wav/albeniz_amplificado.wav';
n_file2 = 'wav/pulp.wav';


% Parametros de proceso
l_v = 512;              % Longitud de ventana
prop_despl = 1/2;       % (256) desplaza = l_v * prop_despl;
polo_preenfasis = 0.95; % Polo de preénfasis
polo_deenfasis = 0.95;  % Polo de deénfasis
n_coef = 32;            % Nº de coeficientes LPC
trama = 10;             % Trama a emplear en la representación de formantes
%%%%%%%%%% [FIN CONFIGURACION] %%%%%%%%%%

desplaza = l_v * prop_despl;
solapa = l_v - desplaza;

% Lectura de archivos
[x1,fs1] = audioread(n_file1);
[x2,fs2] = audioread(n_file2);

% Separación de datos
[x1_fil, A1, P1] = separa(x1, n_coef, polo_preenfasis, l_v, prop_despl);
[x2_fil, A2, P2] = separa(x2, n_coef, polo_preenfasis, l_v, prop_despl);

% Recomposicion de señales (fs1 == fs2)
A1P1 = junta(A1, P1, polo_deenfasis);
A2P2 = junta(A2, P2, polo_deenfasis);
A1P2 = junta(A1, P2, polo_deenfasis);
A2P1 = junta(A2, P1, polo_deenfasis);

% [GRAFICAS]
% Gráficas de tracto
%tracto1 = graficas_tracto(1, l_v, desplaza, A1, fs1);
%tracto2 = graficas_tracto(2, l_v, desplaza, A2, fs2);

% Graficas de formantes
%graficas_formantes(1, x1_fil, trama, l_v, fs1, A1);
%graficas_formantes(2, x2_fil, trama, l_v, fs2, A2);

% Gráficas de pulso
%[pulso1, onda_glot1] = graficas_pulso(1, P1, l_v, fs1);
%[pulso2, onda_glot2] = graficas_pulso(2, P2, l_v, fs2);

% Espectrogramas de señales de audio de entrada
%figure(110);    % Archivo de entrada 1 (sustituir x por x_fil segun se emplee filtro de deénfasis o no)
%spectrogram(x1_fil, l_v, solapa, desplaza, fs1, 'yaxis');
%figure(210);    % Archivo de entrada 2 (sustituir x por x_fil segun se emplee filtro de deénfasis o no)
%spectrogram(x2, l_v, solapa, desplaza, fs2, 'yaxis');

% Espectrogramas de señales de audio de salida
%figure(111);    % Tracto 1 - Pulso 1
%spectrogram(A1P1, l_v, solapa, desplaza, fs1, 'yaxis');
%figure(112);    % Tracto 1 - Pulso 2
%spectrogram(A1P2, l_v, solapa, desplaza, fs1, 'yaxis');
%figure(121);    % Tracto 2 - Pulso 1
%spectrogram(A2P1, l_v, solapa, desplaza, fs1, 'yaxis');
%figure(122);    % Tracto 2 - Pulso 2
%spectrogram(A2P2, l_v, solapa, desplaza, fs1, 'yaxis');


% [REPRODUCCIÓN DE AUDIOS]
% Audios originales
%sound(x1, fs1);
%sound(x1_fil, fs1);
%sound(x2, fs2);
%sound(x2_fil, fs2);

% Audios recompuestos
%sound(A1P1, fs1);   % Tracto 1 - Pulso 1
%sound(A1P2, fs1);   % Tracto 1 - Pulso 2
sound(A2P1, fs1);   % Tracto 2 - Pulso 1
%sound(A2P2, fs1);   % Tracto 2 - Pulso 2


% [GUARDADO DE ARCHIVOS]
%nf_tracto1 = [n_file1, '_tracto.wav'];
%nf_pulso1 = [n_file1, '_pulso.wav'];
%nf_onda1 = [n_file1, '_onda.wav'];
%nf_tracto2 = [n_file2, '_tracto.wav'];
%nf_pulso2 = [n_file2, '_pulso.wav'];
%nf_onda2 = [n_file2, '_onda.wav'];

%audiowrite(nf_tracto1, tracto1, fs1);
%audiowrite(nf_pulso1, pulso1, fs1);
%audiowrite(nf_onda1, onda_glot1, fs1);

%audiowrite(nf_tracto2, tracto2, fs2);
%audiowrite(nf_pulso2, pulso2, fs2);
%audiowrite(nf_onda2, onda_glot2, fs2);

%audiowrite('A1P1.wav', A1P1, fs1)
%audiowrite('A1P2.wav', A1P2, fs1)
%audiowrite('A2P1.wav', A2P1, fs1)
%audiowrite('A2P2.wav', A2P2, fs2)



