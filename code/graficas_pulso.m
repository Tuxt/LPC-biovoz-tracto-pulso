% Crea las gráficas relacionadas con el pulso:
% Devuelve pulso glótico y onda glótica normalizados para guardar en wav
function [pulso, onda_glot] = graficas_pulso(index, pulso, l_v, fs)
    if isempty(pulso)
        return;
    end

    % Transforma el pulso de dimension 
    pulso = reshape(pulso, 1, numel(pulso));

    % --- GRÁFICA PULSO GLÓTICO         (Figure 5)
    if index == 1
        figure(105);
    else
        figure(205);
    end
    eje_t = 0 : 1/fs : (length(pulso)-1)/fs;
    plot(eje_t,pulso);
    title('Pulso glotico');
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    
    % --- ESPECTROGRAMA PULSO GLÓTICO   (Figure 6)
    if index == 1
        figure(106);
    else
        figure(206);
    end
    specgram(pulso, l_v, fs);
    title('Espectro del pulso glótico');
    
    % --- GRÁFICA ONDA GLÓTICA          (Figure 7)
    if index == 1
        figure(107);
    else
        figure(207);
    end
    % Integramos el pulso para obtener la onda
    a = [1, -0.99];
    b = 0.01;
    onda_glot = filter(b,a,pulso);
    plot(eje_t,onda_glot);
    title('Onda glótica');
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    
    % --- ESPECTROGRAMA ONDA GLÓTICA    (Figure 8)
    if index == 1
        figure(108);
    else
        figure(208);
    end
    specgram(onda_glot, l_v, fs);
    title('Espectro de la onda glótica');
    
    % --- GRÁFICA PULSO vs ONDA         (Figure 9)
    if index == 1
        figure(109);
    else
        figure(209);
    end
    plot(eje_t, pulso, 'b', eje_t, onda_glot*100, 'r');
    title('Pulso y onda');
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    legend('pulso','onda');

    % Normaliza pulso y onda para guardar
    pulso = pulso / max(abs(pulso));
    onda_glot = onda_glot / max(abs(onda_glot));
end

