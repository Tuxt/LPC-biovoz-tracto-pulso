% Crea las gr�ficas relacionadas con el pulso:
% Devuelve pulso gl�tico y onda gl�tica normalizados para guardar en wav
function [pulso, onda_glot] = graficas_pulso(index, pulso, l_v, fs)
    if isempty(pulso)
        return;
    end

    % Transforma el pulso de dimension 
    pulso = reshape(pulso, 1, numel(pulso));

    % --- GR�FICA PULSO GL�TICO         (Figure 5)
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
    
    % --- ESPECTROGRAMA PULSO GL�TICO   (Figure 6)
    if index == 1
        figure(106);
    else
        figure(206);
    end
    specgram(pulso, l_v, fs);
    title('Espectro del pulso gl�tico');
    
    % --- GR�FICA ONDA GL�TICA          (Figure 7)
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
    title('Onda gl�tica');
    xlabel('Tiempo (s)');
    ylabel('Amplitud');
    
    % --- ESPECTROGRAMA ONDA GL�TICA    (Figure 8)
    if index == 1
        figure(108);
    else
        figure(208);
    end
    specgram(onda_glot, l_v, fs);
    title('Espectro de la onda gl�tica');
    
    % --- GR�FICA PULSO vs ONDA         (Figure 9)
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

