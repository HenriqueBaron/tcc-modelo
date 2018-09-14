function [ h ] = EspessuraFilmeLubrificacao( de,cd,d,n,r,beta,wz,omega,eta,ksi,E,ni )
%EspessuraFilmeLubrificacao calcula a espessura do filme de graxa no
%rolamento
%   Determina a espessura do filme de lubrificante no rolamento atraves da
%   teoria elastrohidrodinamica (EHD) conforme Hamrock (1994)
%
%   PARAMETROS DE ENTRADA
%   de - Diametro efetivo (pitch diameter), mm
%   d - Diametro das esferas, mm
%   cd - Folga diametral, mm
%   n - Numero de esferas
%   r - Raio das calhas interna e externa, mm
%   beta - Angulo de contato, rad
%   wz - Carga radial, N
%   omega - Velocidades angulares, pistas interna e externa, rad/s
%   eta - Viscosidade absoluta, N*s/m^2
%   ksi - Coeficiente de viscosidade-pressao, m^2/N
%   E - Modulo de elasticidade das esferas e pistas, MPa
%   ni - Coeficiente de Poisson das esferas e pistas

% Taxa de vazao de volume
qa = pi/2 - 1;

% Modulo de elasticidade efetivo
Eef = E/(1-ni^2);

% Inicializacao dos vetores
[Rr, Rx, Ry, R, alpha_r, k, epsilon, F, U, G, W, h] = deal(zeros(1,2));

% Raios equivalentes
Rx(1) = d*(de-d*cos(beta))/(2*de);
Rx(2) = d*(de+d*cos(beta))/(2*de);

for i=1:2
    Rr(i) = r(i)/d; % Race conformity
    % Raios equivalentes
    Ry(i) = Rr(i)*d/(2*Rr(i)-1);
    R(i) = inv(inv(Rx(i))+inv(Ry(i)));
    alpha_r(i) = Ry(i)/Rx(i);
    
    k(i) = alpha_r(i)^(2/pi); % Condicoes de elipticidade
    
    % Integrais elipticas
    epsilon(i) = 1 + qa/alpha_r(i);
    F(i) = pi/2 + qa*log(alpha_r(i));
end

% Carga na esfera mais solicitada
wz_max = ObterCargaMaximaEsfera(wz,n,cd,Eef,F,epsilon,R,k);

% Velocidade de escoamento
u = abs(omega(2)-omega(1))*(de^2-d^2)/(4000*de);

for i=1:2
    % Parametros adimensionais de velocidade, material e carga das pistas
    U(i) = eta*u/(Eef*10^6*Rx(i)/1000);
    G(i) = ksi*Eef*10^6;
    W(i) = wz_max/(Eef*10^6*(Rx(i)/1000)^2);
    
    h(i) = 3.63*U(i)^0.68*G(i)^0.49*W(i)^-0.073*(1-exp(-0.68*k(i)))*Rx(i);
end

end