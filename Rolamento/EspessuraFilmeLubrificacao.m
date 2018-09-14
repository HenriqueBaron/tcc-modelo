%function [ h ] = EspessuraFilmeLubrificacao( ~ )
%EspessuraFilmeLubrificacao calcula a espessura do filme de graxa no
%rolamento
%   Determina a espessura do filme de lubrificante no rolamento atraves da
%   teoria elastrohidrodinamica (EHD) conforme Hamrock (1994)
clearvars;
de = 64.9985; % Diametro efetivo (pitch diameter), mm
d = 12.7; % Diametro das esferas, mm
cd = 0.015; % Folga diametral, mm
n = 9; % Numero de esferas
r = [6.604 6.604]; % Raio das calhas interna e externa, mm
beta = 0; % Angulo de contato, rad
Rqb = 0.0625; % Rugosidade rms das esferas, micrometros
Rqa = 0.0175; % Rugosidade rms das pistas, micrometros
wz = 8900; % Carga radial, N
omega = [400 0]; % Velocidades angulares, pistas interna e externa, rad/s
eta = 0.04; % Viscosidade absoluta, N*s/m^2
ksi = 2.3e-8; % Coeficiente de viscosidade-pressao, m^2/N
E = 200e3; % Modulo de elasticidade das esferas e pistas, MPa
ni = 0.3; % Coeficiente de Poisson das esferas e pistas

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

%end