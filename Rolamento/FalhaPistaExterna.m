% Calcula a vibracao em um rolamento com dano pontual na pista externa.

clearvars;

%----- Entrada de dados -----%
t0 = 0; % Instante inicial
tf = 0.04; % Instante final
N = 1800; % Velocidade de rotacao, em revolucoes por minuto

% Dados do rolamento - 6004 2RSH
Db = 6.35e-3; % Diametro das esferas, metros
Nb = 9; % Numero de esferas
m_b = 1.05e-3; % Massa de cada esfera, kg
alpha = 0; % Angulo de contato do rolamento
c_r = 7e-6; % Folga radial (radial clearance), metros
E = 200e9; % Modulo de elasticidade do aco dos aneis e esferas, Pa
ni = 0.3; % Coeficiente de Poisson para aneis e esferas
rolos = false; % Rolamento é de rolos?

% Propriedades do anel externo do rolamento
anelExt.D = 42e-3; % Diametro externo da pista externa, metros
anelExt.D2 = 37.19e-3; % Diametro interno da pista externa, metros
anelExt.m = 0.035; % Massa, kg
anelExt.mu = 0.289; % Massa linear, kg/m
anelExt.I = 31.802e-12; % Momento de inercia, m^4
anelExt.Rneu = 19.43e-3; % Raio da linha neutra, m
anelExt.rx = 18.68e-3; % Raio de curvatura no eixo X, m
anelExt.ry = 3.18e-3; % Raio de curvatura no eixo Y (groove), m

% Propriedades do anel interno do rolamento
anelInt.D = 20e-3; % Diametro interno da pista interna, metros
anelInt.D2 = 24.65e-3; % Diametro externo da pista interna, metros
anelInt.m = 0.022; % Massa, kg
anelInt.mu = 0.301; % Massa linear, kg/m
anelInt.I = 37.424e-12; % Momento de inercia, m^4
anelInt.Rneu = 11.65e-3; % Raio da linha neutra, m
anelInt.rx = 12.32e-3; % Raio de curvatura no eixo X, m
anelInt.ry = 3.18e-3; % Raio de curvatura no eixo Y (groove), m

% Propriedades do lubrificante - ISO VG 32 @ 40°C
visc = 32e-6; % Viscosidade cinematica, m^2/s (1 m^2/s = 10^6 centistokes)
rho = 861; % Massa especifica, kg/m^3
% Filme de fluido entre anel externo e esfera
kfExt = 68.3; % Rigidez do filme de fluido a 1800 RPM, N/m^nf
nfExt = 1.388; % Expoente para calculo da forca de restauracao
cfExt = 18.027; % Amortecimento do filme de fluido a 1800 RPM, N*s/m
% Filme de fluixo entre anel interno e esfera
kfInt = 68.3; % Rigidez do filme de fluido a 1800 RPM, N/m^nf
nfInt = 1.388; % Expoente para calculo da forca de restauracao
cfInt = 18.027; % Amortecimento do filme de fluido a 1800 RPM, N*s/m

% Propriedades do defeito e carregamento
Cmax = 100; % Carga maxima aplicada no eixo, newtons
theta = 0; % Angulo entre a carga e o defeito na pista externa
d_def = 0.1e-3; % Tamanho do defeito, metros
da = 0; % Deslocamento axial provocado pelo defeito, metros
dr = 1e-3; % Deslocamento radial provocado pelo defeito, metros

%------------------------------------------------------------------------%
% Propriedades derivadas do rolamento
c_d = 2*c_r; % Folga diametral (diametral clearance), metros
Dp = (anelExt.D + anelInt.D)/2; % Pitch diameter, metros
rb = Db/2; % Raio das esferas, metros

% Velocidades angulares dos aneis interno e externo
% Como os rolamentos são embutidos no mancal, a velocidade angular do
% anel externo e sempre nula.
anelInt.omega = N*pi/30;
anelExt.omega = 0;

% Frequencias principais do rolamento
% Fundamental Train Frequency
FTF = 0.5*(anelInt.omega*(1-cos(alpha)*Db/Dp) + ...
        anelExt.omega*(1+cos(alpha)*Db/Dp));
% Ball Pass Frequency, Outer
BPFO = Nb/2*(anelInt.omega-anelExt.omega)*(1-cos(alpha)*Db/Dp);
% Ball Pass Frequency, Inner
BPFI = Nb/2*(anelInt.omega-anelExt.omega)*(1+cos(alpha)*Db/Dp);
% Ball Spin Frequency
BSF = Dp/(2*Db)*(anelInt.omega-anelExt.omega)*(1-cos(alpha)^2*Db^2/Dp^2);

% Determinacao do carregamento estatico
epsilon = 1/2*(1+tan(alpha)*da/dr);

% Frequencias naturais - aneis externo e interno
% Segundo modo de vibração do anel considerado
FreqNatural = @(n,E,I,mu,R) n*(n^2-1)/sqrt(1+n^2)*sqrt(E*I/(mu*R^4));
anelExt.omega_n = FreqNatural(2,E,anelExt.I,anelExt.mu,anelExt.Rneu);
anelInt.omega_n = FreqNatural(2,E,anelInt.I,anelInt.mu,anelInt.Rneu);

% Rigidezes anel externo e interno
anelExt.k = anelExt.m*anelExt.omega_n^2;
anelInt.k = anelInt.m*anelInt.omega_n^2;

[Rx,Ry,R,Rd,IF,IE,k] = deal(zeros(2,1));

aneis = [anelInt anelExt];

parfor i=1:2
    [Rx(i),Ry(i),R(i),Rd(i)] = RaiosCurvatura(rb,rb,aneis(i).rx,aneis(i).ry);
    [IF(i),IE(i),k(i)] = ParametrosElipseContato(Rd(i));
end

Eef = E/(1-ni^2);
wz_max = ObterCargaMaximaEsfera(Cmax,Nb,c_d,Eef,R,IF,IE,k);

% Montagem das matrizes do sistema
[M, K, C] = deal(zeros(3,3));
M(1,1) = anelExt.m;
M(2,2) = m_b;
M(3,3) = anelInt.m;

K(1,1) = anelExt.k + kfExt;
K(1,2) = -kfExt;
K(2,1) = -kfExt;
K(2,2) = kfExt + kfInt;
K(2,3) = -kfInt;
K(3,2) = -kfInt;
K(3,3) = anelInt.k + kfInt;

C(1,1) = cfExt;
C(1,2) = -cfExt;
C(2,1) = -cfExt;
C(2,2) = cfExt + cfInt;
C(2,3) = -cfInt;
C(3,2) = -cfInt;
C(3,3) = cfInt;

% Referencias de funcao para definir a forca externa em cada instante
fImpacto = @(t)wz_max*square(t*BPFO, 0.5);
F = @(t)[fImpacto(t); 0; 0]; % Vetor de forcas - apenas na pista externa

% Resolucao das ODEs
[t, y] = ode45(@(t,y) SisLinOrdem2(t,y,M,C,K,F(t)),[t0 tf], zeros(6,1));

% Determinacao de parametros para o espectro de frequencias
Y = fft(y(:,1));
L = length(Y);
Fs = L/(t(end) - t(1)); % Frequencia de amostragem
f = (0:L-1)*(Fs/L);
Ps = abs(Y).^2/L;

figure(1);
plot(t,fImpacto(t));
title('Perfil dos impulsos de impacto');

figure(2)
plot(t,y(:,1),t,y(:,2),t,y(:,3));
title('Deslocamentos [m]');

figure(3)
plot(f,Ps);