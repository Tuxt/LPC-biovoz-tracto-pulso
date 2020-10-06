% Crea las gráficas relacionadas con los formantes
function graficas_formantes(index, x, trama, l_v, fs, A)
    if isempty(A)
        return;
    end

    n_trozos = size(A,2);
    if trama > n_trozos
        trama = n_trozos;
    end
    
    % Cálculo matr_lpc (Vectores LPC en dB)
    matr_lpc = zeros(l_v/2 + 1, n_trozos);
    
    for i=1:n_trozos
        a = A(:,i);
        [H, f] = freqz(1, a, l_v/2+1, fs);
        matr_lpc(:,i) = 20 * log10(abs(H) + eps);
    end
    

    % --- GRÁFICA FORMANTES: LPC vs FFT vs ENVOLVENTES LPC  (Figure 3)
    if (index == 1)
        figure(103);
    else
        figure(203);
    end
    
    [B,f,t]=specgram(x,l_v,fs);
    eje_lpc=(0:l_v/2)*fs/l_v;
    eje_f=1:l_v/2+1;
    eje_f=eje_f-1;
    eje_f=eje_f*fs/l_v;
    trama_lpc=matr_lpc(:,trama);
    trama_fourier=20*log10(abs(B(:,trama)));
    trama_lpc=trama_lpc-max(trama_lpc);
    trama_fourier=trama_fourier-max(trama_fourier);
    a_v=1;
    b_v=[1 -1];
    D_envolv=filter(b_v,a_v,trama_lpc);
    D_D_envolv=filter(b_v,a_v,D_envolv);
    
    plot(eje_lpc,trama_lpc,'r',eje_f,trama_fourier,'b', eje_f, D_envolv, 'k', eje_f, D_D_envolv,'g');
    title('fft y envolvente lpc')
    xlabel('Frecuencia (Hz)');
    ylabel('Amplitud (dB)');
    legend('lpc', 'fft', 'Dlpc', 'DDlpc');
    
    
    % --- GRÁFICA DIFERENCIA LPC y FFT                      (Figure 4)
    if (index == 1)
        figure(104);
    else
        figure(204);
    end
    surf(matr_lpc-20*log10(abs(B)));
    title('Diferencia entre espectro LPC y FFT')
    xlabel('Tiempo (s)');
    ylabel('Frecuencia (Hz)');
    zlabel('Amplitud (dB)');
    shading interp;
    
end

