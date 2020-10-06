%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCIÓN DE SEPARACIÓN
%
% Entradas:
%   x:          Vector de la señal
%   n_coef:     Número de coeficientes del modelo LPC
%   polo:       Polo del filtro de preénfasis
%   l_v:        Longitud de ventana
%   prop_despl: Proporción del desplazamiento
%
% Salidas:
%   A:          Matriz de vectores a de LPC para cada trozo
%       dim ->  (n_coef + 1, n_trozos)
%   P:          Matriz de pulso glotico
%       dim ->  (desplaza, n_trozos)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x_fil, A, P] = separa(x, n_coef, polo, l_v, prop_despl)
    % Comprobacion de canales de x
    if (size(x,2) > 1)
        warning("Input signal is stereo. Converting to mono");
        x = sum(x,2) / size(x,2);
    end
    
    desplaza = floor(l_v * prop_despl);
    
    % Cálculo del numero de trozos
    len = length(x);
    solapa = l_v - desplaza;
    len = len - solapa;     % Se elimina la parte de ventana que no se desplaza
    n_trozos = floor(len / desplaza);
    
    
    % Filtro de preenfasis
    a = 1;
    b = [1, -polo];
    x_fil = filter(b,a,x);
    
    Zi = zeros(1,n_coef);           % Condiciones iniciales de filtros
    
    % Valores de salida
    A = zeros(n_coef+1, n_trozos);  % Coeficientes a del tracto (LPC)
    P = zeros(desplaza, n_trozos);  % Pulso
    for i=1:n_trozos
        % Trocea y calcula vector de coeficientes 'a'
        trozo = x_fil((i-1)*desplaza + 1 : (i-1)*desplaza + l_v);
        a = real(lpc(trozo,n_coef));
        A(:,i) = a;
        
        % Filtro inverso para obtener pulso
        b_inv = a;
        a_inv = 1;
        
        % Se filtra la primera mitad de ventana debido al solapamiento
        % Se pierde la última media ventana (se podria usar padding?)
        [trozo_pulso,Zi] = filter(b_inv, a_inv, trozo(1:desplaza), Zi);
        P(:,i) = trozo_pulso;
    end
end






