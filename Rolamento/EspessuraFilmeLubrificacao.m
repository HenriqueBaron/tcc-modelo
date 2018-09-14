%function [ h ] = EspessuraFilmeLubrificacao( ~ )
%EspessuraFilmeLubrificacao calcula a espessura do filme de graxa no
%rolamento
%   Determina a espessura do filme de lubrificante no rolamento atraves da
%   teoria elastrohidrodinamica (EHD) conforme Hamrock (1994)
clearvars;
d_i = 52.291; % Diametro pista interna, mm
d_o = 77.706; % Diametro pista externa, mm
d = 12.7; % Diametro das esferas, mm
n = 9; % Numero de esferas
r_i = 6.604; % Raio da calha interna, mm
r_o = 6.604; % Raio da calha externa, mm
alpha = 0; % Angulo de contato, rad
R_qb = 0.0625; % Rugosidade rms das esferas, micrometros
R_qa = 0.0175; % Rugosidade rms das pistas, micrometros
w_z = 8900; % Carga radial, N
omega_i = 400; % Velocidade angular pista interna, rad/s
omega_o = 0; % Velocidade angular pista externa, rad/s
eta = 0.04; % Viscosidade absoluta, N*s/m^2
ksi = 2.3e-8; % Coeficiente de viscosidade-pressao, m^2/N
ni = 0.3; % Coeficiente de Poisson das esferas e pistas

d_e = (d_o+d_i)/2; % Pitch diameter JA DISPONIVEL
c_d = d_o - d_i - 2*d; % Diametral clearance JA DISPONIVEL


%end