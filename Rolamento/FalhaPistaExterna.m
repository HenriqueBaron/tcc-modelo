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
eta = 0.04; % Visosidade absoluta do lubrificante, N*s/m^2
ksi = 2.3e-8; % Coeficiente de visosidade-pressao, m^2/N
rolos = 0; % Rolamento de esferas = 0; rolamento de rolos = 1

% Propriedades do anel externo do rolamento
m_or = 0.035; % Massa, kg
I_or = 31.802; % Momento de inercia, mm^4
R_or = 19.43; % Raio da linha neutra, mm
mu_or = 0.289e-3; % Massa linear, kg/mm
rGroove_or = 3.18; % Raio da calha (groove), mm

% Propriedades do anel interno do rolamento
m_ir = 0.022; % Massa, kg
I_ir = 37.424; % Momento de inercia anel interno, mm^4
R_ir = 11.65; % Raio da linha neutra, mm
mu_ir = 0.301e-3; % Massa linear, kg/mm
rGroove_ir = 3.18; % Raio da calha (groove), mm

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
omega_i = N*pi/30; % Anel interno
omega_o = 0; % Anel externo

% Frequencias principais do rolamento
% Fundamental Train Frequency
FTF = 0.5*(omega_i*(1-cos(alpha)*Db/Dp) + omega_o*(1+cos(alpha)*Db/Dp));
% Ball Pass Frequency, Outer
BPFO = Nb/2*(omega_i-omega_o)*(1-cos(alpha)*Db/Dp);
% Ball Pass Frequency, Inner
BPFI = Nb/2*(omega_i-omega_o)*(1+cos(alpha)*Db/Dp);
% Ball Spin Frequency
BSF = Dp/(2*Db)*(omega_i-omega_o)*(1-cos(alpha)^2*Db^2/Dp^2);

% Determinacao do carregamento estatico
epsilon = 1/2*(1+tan(alpha)*da/dr);

% Frequencias naturais - aneis externo e interno
n = 2; % Modo de vibracao considerado
FreqNatural = @(n,E,I,mu,R) n*(n^2-1)/sqrt(1+n^2)*sqrt(E*I/(mu*R^4));
omega_n_or = FreqNatural(2,E,I_or,mu_or,R_or);
omega_n_ir = FreqNatural(2,E,I_ir,mu_ir,R_ir);

% Rigidezes anel externo e interno
k_or = m_or*omega_n_or^2;
k_ir = m_ir*omega_n_ir^2;

% Espessura do filme de lubrificacao
h = EspessuraFilmeLubrificacao(Dp,c_d,Db,Nb,[rGroove_ir rGroove_or], ...
alpha,Cmax,[omega_i omega_o],eta,ksi,E,ni);

% Funcoes para propriedades da camada de lubrificante
EccRatio = @(h,c) 1-h/c;
TanPhi = @(ecr) pi*sqrt(1-ecr^2)/(4*ecr);
SinPhi = @(tanPhi) sqrt(1/(tanPhi^-2+1));
CosPhi = @(tanPhi) sqrt(1/(tanPhi^2+1));
ConstCarga = @(ecr,tanPhi) (CosPhi(tanPhi))^2*(1-ecr^2)^2/...
    (ecr*sqrt(16*ecr^2+pi^2*(1-ecr^2)));
KLub = @(cCarga,tanPhi,ecr) cCarga*(SinPhi(tanPhi)^2*ecr/(1-ecr^2)^2 ...
    + SinPhi(tanPhi)*CosPhi(tanPhi)*3*pi*ecr^2/(4*(1-ecr^2)^(5/2)) ...
    + CosPhi(tanPhi)^2*2*ecr*(1+ecr^2)/(1-ecr^2)^3);
CLub = @(cCarga,tanPhi,ecr) cCarga*(SinPhi(tanPhi)^2*pi/ ...
    (2*(1-ecr^2)^(3/2)) + SinPhi(tanPhi)*CosPhi(tanPhi)*4*ecr/ ...
    (1-ecr^2)^2 + CosPhi(tanPhi)^2*pi*(1+2*ecr^2)/(2*(1-ecr^2)^(5/2)));

% Determincacao das propriedades das camadas de lubrificante
[eccRatio,tanPhi,cCarga,k_f,c_f] = deal(zeros(2,1));
for i=1:2
    eccRatio(i) = EccRatio(h(i),c_d);
    tanPhi(i) = TanPhi(eccRatio(i));
    cCarga(i) = ConstCarga(eccRatio(i),tanPhi(i));
    k_f(i) = KLub(cCarga(i),tanPhi(i),eccRatio(i));
    c_f(i) = CLub(cCarga(i),tanPhi(i),eccRatio(i));
end