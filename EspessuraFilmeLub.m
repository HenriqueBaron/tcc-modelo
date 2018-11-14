function [ h ] = EspessuraFilmeLub(dp,db,Rx,k,omega,wz,Eef,eta,xi)
%ESPESSURAFILMELUB Calcula a espessura do filme de lubrificante.
%   Determina a espessura filme de lubrificante no rolamento atraves da
%   teoria elastohidrodinamica (EHD), utilizando uma simplificacao por
%   fatores adimensionais.
%   PARAMETROS DE ENTRADA
%   dp - Diametro efetivo (pitch diameter), m
%   db - Diametro das esferas, m
%   Rx - Raios de curvatura equivalentes na direcao X, m
%   k - Parametros de elipticidade do contato
%   omega - Velocidades angulares, pistas interna e externa, rad/s
%   wz - Carga radial, N
%   Eef - Modulo de elasticidade efetivo, Pa
%   eta - Viscosidade absoluta, N*s/m^2
%   xi - Coeficiente de viscosidade-pressao, m^2/N

% Inicializacao dos vetores
[U, G, W, h] = deal(zeros(1,2));

omega_b = sum(omega); % Velocidade angular da esfera
ub = omega_b*db/2; % Velocidade de superficie (tangencial) da esfera
% Somas de velocidades
us(1) = omega(1)*(dp-db)/2 + ub;
us(2) = omega(2)*(dp+db)/2 + ub;

for i=1:2
    % Parametros adimensionais de velocidade, material e carga das pistas
    U(i) = eta*us(i)/(2*Eef*Rx(i));
    G(i) = xi*Eef;
    W(i) = wz/(Eef*Rx(i)^2);
    
    h(i) = 2.69*U(i)^0.67*G(i)^0.53*W(i)^-0.067*...
        (1-0.61*exp(-0.73*k(i)))*Rx(i);
end

end