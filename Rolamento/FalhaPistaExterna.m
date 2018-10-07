% Calcula a vibracao em um rolamento com dano pontual na pista externa.

clearvars;

%----- Entrada de dados -----%
t0 = 0; % Instante inicial
tf = 5; % Instante final
N = 1800; % Velocidade de rotacao, em revolcoes por minuto

% Dados do rolamento - 6004 2RSH
D = 42; % Diametro externo da pista externa, milimetros
d = 20; % Diametro interno da pista interna, milimetros
D2 = 37.19; % Diametro interno da pista externa, milimetros
d2 = 24.65; % Diametro externo da pista interna, milimetros
Db = 6.35; % Diametro das esferas, milimetros
Nb = 9; % Numero de esferas
m_b = 1.05e-3; % Massa de cada esfera, kg
alpha = 0; % Angulo de contato do rolamento
c_r = 12.5e-3; % Folga radial (radial clearance), milimetros
E = 200e3; % Modulo de elasticidade do aco dos aneis e esferas, MPa
ni = 0.3; % Coeficiente de Poisson para aneis e esferas
rolos = 0; % Rolamento de esferas = 0; rolamento de rolos = 1

% Propriedades do anel externo do rolamento
anelExt.m = 0.035; % Massa, kg
anelExt.mu = 0.289e-3; % Massa linear, kg/mm
anelExt.I = 31.802; % Momento de inercia, mm^4
anelExt.Rneu = 19.43; % Raio da linha neutra, mm
anelExt.rx = 18.68; % Raio de curvatura no eixo X, mm
anelExt.ry = 3.18; % Raio de curvatura no eixo Y (groove), mm

% Propriedades do anel interno do rolamento
anelInt.m = 0.022; % Massa, kg
anelInt.mu = 0.301e-3; % Massa linear, kg/mm
anelInt.I = 37.424; % Momento de inercia, mm^4
anelInt.Rneu = 11.65; % Raio da linha neutra, mm
anelInt.rx = 12.32; % Raio de curvatura no eixo X, mm
anelInt.ry = 3.18; % Raio de curvatura no eixo Y (groove), mm

% Propriedades do lubrificante - ISO VG 32 @ 40°C
visc = 32e-6; % Viscosidade cinemática, anelExt.m^2/s (1 anelExt.m^2/s = 10^6 centistokes)
rho = 861; % Massa específica, kg/anelExt.m^3

% Propriedades do defeito e carregamento
Cmax = 450; % Carga maxima aplicada no eixo, newtons
psi_m = pi/3; % Angulo maximo de distribuicao do carregamento, radianos
theta = 0; % Angulo entre a carga e o defeito na pista externa
d_def = 0.1; % Tamanho do defeito, milimetros
da = 0; % Deslocamento axial provocado pelo defeito, milimetros
dr = 1; % Deslocamento radial provocado pelo defeito, milimetros

%------------------------------------------------------------------------%

% Propriedades derivadas do rolamento
c_d = 2*c_r; % Folga diametral (diametral clearance), milimetros
Dp = (D + d)/2; % Pitch diameter, milimetros

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
n = 2; % Modo de vibracao considerado
FreqNatural = @(n,E,I,mu,R) n*(n^2-1)/sqrt(1+n^2)*sqrt(E*I/(mu*R^4));
anelExt.omega_n = FreqNatural(2,E,anelExt.I,anelExt.mu,anelExt.Rneu);
anelInt.omega_n = FreqNatural(2,E,anelInt.I,anelInt.mu,anelInt.Rneu);

% Rigidezes anel externo e interno
anelExt.k = anelExt.m*anelExt.omega_n^2;
anelInt.k = anelInt.m*anelInt.omega_n^2;

[Rx,Ry,R,Rd,IF,IE,k] = deal(zeros(2,1));

aneis = [anelInt anelExt];
rb = Db*1e-3/2;

for i=1:2
    [Rx(i),Ry(i),R(i),Rd(i)] = RaiosCurvatura(rb,rb,aneis(i).rx,aneis(i).ry);
    
end
[Rx,Ry,R,Rd] = RaiosCurvatura
