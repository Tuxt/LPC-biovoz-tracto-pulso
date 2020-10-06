% Crea las gráficas relacionadas con el tracto
function [tracto] = graficas_tracto(index, l_v, desplaza, A, fs)
    if isempty(A)
        return;
    end

    solapa = l_v - desplaza;
    n_trozos = size(A,2);
    
    tracto = [];
    matr_lpc = zeros(l_v/2 + 1, n_trozos);
    
    for i=1:n_trozos
        a = A(:,i);
        [H, f] = freqz(1, a, l_v/2+1, fs);
        matr_lpc(:,i) = 20 * log10(abs(H) + eps);
        
        [H_tracto, f] = freqz(1, a, l_v, fs, 'whole');
        trozo_tracto = real(ifft(H_tracto));
        tracto = [tracto, (trozo_tracto(1:desplaza))'];
    end
    
    % --- GRÁFICA ESPECTROGRAMA PLANO DEL TRACTO    (Figure 1)
    if (index == 1)
        figure(101);
    else
        figure(201);
    end
    specgram(tracto,desplaza,fs,hamming(desplaza),0)
    title('Espectro LPC');
    xlabel('Tiempo (s)');
    ylabel('Frecuencia (Hz)');
    zlabel('Magnitud (dB)');
    
    
    % --- GRÁFICA ESPECTROGRAMA 3D DEL TRACTO       (Figure 2)
    if (index == 1)
        figure(102);
    else
        figure(202);
    end
    eje_t=(0:n_trozos-1)/(fs/desplaza);
    %eje_lpc=(0:l_v-1)*(fs/2)/(l_v-1);
    eje_lpc=(0:l_v/2)*fs/l_v;
    surf(eje_t,eje_lpc,matr_lpc);
    shading interp;
    title('Espectro LPC');
    xlabel('Tiempo (s)');
    ylabel('Frecuencia (Hz)');
    zlabel('Magnitud (dB)');

    % Normaliza tracto para guardar en archivo
    tracto = tracto / max(abs(tracto));
end

