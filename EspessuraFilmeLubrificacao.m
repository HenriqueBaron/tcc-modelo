function [ h ] = EspessuraFilmeLubrificacao(dp,db,Rx,k,omega,wz,Eef,eta,ksi)
%EspessuraFilmeLubrificacao calcula a espessura do filme de graxa no
%rolamento
%   Determina a espessura do filme de lubrificante no rolamento atraves da
%   teoria elastrohidrodinamica (EHD) conforme Hamrock (1994)
%
%   PARAMETROS DE ENTRADA
%   dp - Diametro efetivo (pitch diameter), m
%   db - Diametro das esferas, m
%   Rx - Raios de curvatura equivalentes na direcao X, m
%   k - Parametros de elipticidade do contato
%   omega - Velocidades angulares, pistas interna e externa, rad/s
%   wz - Carga radial, N
%   Eef - Modulo de elasticidade efetivo, Pa
%   eta - Viscosidade absoluta, N*s/m^2
%   ksi - Coeficiente de viscosidade-pressao, m^2/N

% Inicializacao dos vetores
[U, G, W, h] = deal(zeros(1,2));

% Velocidade de escoamento
u = abs(omega(2)-omega(1))*(dp^2-db^2)/(4*dp);

for i=1:2
    % Parametros adimensionais de velocidade, material e carga das pistas
    U(i) = eta*u/(Eef*10^6*Rx(i)/1000);
    G(i) = ksi*Eef*10^6;
    W(i) = wz/(Eef*10^6*(Rx(i)/1000)^2);
    
    h(i) = 3.63*U(i)^0.68*G(i)^0.49*W(i)^-0.073*(1-exp(-0.68*k(i)))*Rx(i);
end

end