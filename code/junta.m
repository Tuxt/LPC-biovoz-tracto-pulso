%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCI�N DE RECOMPOSICI�N DE SE�AL
%
% Entradas:
%   A:          Matriz de vectores a de LPC para cada trozo
%       dim ->  (n_coef + 1, n_trozos)
%   P:          Matriz de pulso glotico
%       dim ->  (desplaza, n_trozos)
%   polo:       Polo del filtro de de�nfasis
%
% Salidas:
%   recomp:     Se�al recompuesta a partir de A y P
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function recomp = junta(A, P, polo)
    % Obtencion de datos de los parametros
    % l_v = 
    % desplaza = size(P, 1);
    n_coef = size(A, 1) - 1;
    n_trozos_pulso = size(P, 2);
    n_trozos_lpc = size(A, 2);
    
    % P y A vienen de audios diferentes, por lo que tendran tama�os
    % dferentes. Cogemos el de menor dimension
    n_trozos = min(n_trozos_pulso, n_trozos_lpc);
    
    Zi = zeros(1,n_coef);               % Condiciones iniciales de filtros
    recomp = [];                         % Vector de se�al recompuesta
    
    for i=1:n_trozos
        trozo = P(:, i);
        a = A(:, i);
        [trozo_recomp, Zi] = filter(1, a, trozo, Zi);
        recomp = [recomp, trozo_recomp'];
    end
    
    % Filtro de de�nfasis
    a = [1 -polo];
    b = 1;
    recomp_fil = filter(b,a,recomp);
    recomp = recomp_fil;
end