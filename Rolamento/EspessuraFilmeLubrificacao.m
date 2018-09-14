%function [ h ] = EspessuraFilmeLubrificacao( ~ )
%EspessuraFilmeLubrificacao calcula a espessura do filme de graxa no
%rolamento
%   Determina a espessura do filme de lubrificante no rolamento atraves da
%   teoria elastrohidrodinamica (EHD) conforme Hamrock (1994)
clearvars;
di = 52.291; % Diametro pista interna, mm
do = 77.706; % Diametro pista externa, mm
d = 12.7; % Diametro das esferas, mm
n = 9; % Numero de esferas
ri = 6.604; % Raio da calha interna, mm
ro = 6.604; % Raio da calha externa, mm
beta = 0; % Angulo de contato, rad
Rqb = 0.0625; % Rugosidade rms das esferas, micrometros
Rqa = 0.0175; % Rugosidade rms das pistas, micrometros
wz = 8900; % Carga radial, N
omega_i = 400; % Velocidade angular pista interna, rad/s
omega_o = 0; % Velocidade angular pista externa, rad/s
eta = 0.04; % Viscosidade absoluta, N*s/m^2
ksi = 2.3e-8; % Coeficiente de viscosidade-pressao, m^2/N
E = 200e3; % Modulo de elasticidade das esferas e pistas, MPa
ni = 0.3; % Coeficiente de Poisson das esferas e pistas

de = (do+di)/2; % Pitch diameter JA DISPONIVEL
cd = do - di - 2*d; % Diametral clearance JA DISPONIVEL
Rri = ri/d; % Race conformity, pista interna
Rro = ro/d; % Race conformity, pista externa

% Raios equivalentes
Rxi = d*(de-d*cos(beta))/(2*de);
Rxo = d*(de+d*cos(beta))/(2*de);
Ryi = Rri*d/(2*Rri-1);
Ryo = Rro*d/(2*Rro-1);

Ri = inv(inv(Rxi)+inv(Ryi));
Ro = inv(inv(Rxo)+inv(Ryo));
alpha_ri = Ryi/Rxi;
alpha_ro = Ryo/Rxo;

% Condicoes de elipticidade
ki = alpha_ri^(2/pi);
ko = alpha_ro^(2/pi);

% Taxa de vazao de volume
qa = pi/2 - 1;

% Integrais elipticas
epsilon_i = 1 + qa/alpha_ri;
epsilon_o = 1 + qa/alpha_ro;
Fi = pi/2 + qa*log(alpha_ri);
Fo = pi/2 + qa*log(alpha_ro);

% Modulo de elasticidade efetivo
Eef = E/(1-ni^2);

%end