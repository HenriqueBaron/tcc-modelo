t0 = 0; % Instante inicial
tf = 0.5; % Instante final
Fs = 50e3; % Frequencia de amostragem do sinal, hertz
N = 1800; % Velocidade de rotacao, em revolucoes por minuto

% Dados do rolamento - 6004 2RSH
Db = 6.35e-3; % Diametro das esferas, metros
Nb = 9; % Numero de esferas
m_b = 1.05e-3; % Massa de cada esfera, kg
alpha = 0; % Angulo de contato do rolamento
c_r = 7e-6; % Folga radial (radial clearance), metros
E = 200e9; % Modulo de elasticidade do aco dos aneis e esferas, Pa
ni = 0.3; % Coeficiente de Poisson para aneis e esferas
rolos = false; % Rolamento eh de rolos?

% Propriedades do anel interno do rolamento
anelInt.D = 20e-3; % Diametro interno da pista interna, metros
anelInt.D2 = 24.65e-3; % Diametro externo da pista interna, metros
anelInt.m = 0.022; % Massa, kg
anelInt.mu = 0.301; % Massa linear, kg/m
anelInt.I = 37.424e-12; % Momento de inercia, m^4
anelInt.Rneu = 11.65e-3; % Raio da linha neutra, m
anelInt.rx = 12.32e-3; % Raio de curvatura no eixo X, m
anelInt.ry = 3.18e-3; % Raio de curvatura no eixo Y (groove), m

% Propriedades do anel externo do rolamento
anelExt.D = 42e-3; % Diametro externo da pista externa, metros
anelExt.D2 = 37.19e-3; % Diametro interno da pista externa, metros
anelExt.m = 0.035; % Massa, kg
anelExt.mu = 0.289; % Massa linear, kg/m
anelExt.I = 31.802e-12; % Momento de inercia, m^4
anelExt.Rneu = 19.43e-3; % Raio da linha neutra, m
anelExt.rx = 18.68e-3; % Raio de curvatura no eixo X, m
anelExt.ry = 3.18e-3; % Raio de curvatura no eixo Y (groove), m

% Propriedades do lubrificante - ISO VG 32 @ 40°C
visc = 32e-6; % Viscosidade cinematica, m^2/s (1 m^2/s = 10^6 centistokes)
rho = 861; % Massa especifica, kg/m^3
% Filme de fluido entre anel interno e esfera
fiInt.k = 68.3; % Rigidez do filme de fluido a 1800 RPM, N/m^nf
fiInt.n = 1.388; % Expoente para calculo da forca de restauracao
fiInt.Fs = 4.023; % Forca constante de sustentacao, N
fiInt.c = 18.027; % Amortecimento do filme de fluido a 1800 RPM, N*s/m
% Filme de fluido entre anel externo e esfera
fiExt.k = 68.3; % Rigidez do filme de fluido a 1800 RPM, N/m^nf
fiExt.n = 1.388; % Expoente para calculo da forca de restauracao
fiExt.Fs = 4.023; % Forca constante de sustentacao, N
fiExt.c = 18.027; % Amortecimento do filme de fluido a 1800 RPM, N*s/m

% Propriedades do defeito e carregamento
wz = 100; % Carga maxima aplicada no eixo, newtons