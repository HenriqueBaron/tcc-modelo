% Calcula a vibracao em um rolamento com dano pontual na pista externa.

%% Entrada de dados
t0 = 0; % Instante inicial
tf = 4; % Instante final
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

% Propriedades do lubrificante - ISO VG 32 @ 40�C
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
Cmax = 100; % Carga maxima aplicada no eixo, newtons
theta = 0; % Angulo entre a carga e o defeito na pista externa
d_def = 0.1e-3; % Tamanho do defeito, metros
da = 0; % Deslocamento axial provocado pelo defeito, metros
dr = 1e-3; % Deslocamento radial provocado pelo defeito, metros

%% Propriedades derivadas do rolamento
c_d = 2*c_r; % Folga diametral (diametral clearance), metros
Dp = (anelExt.D + anelInt.D)/2; % Pitch diameter, metros
% O raio das esferas e calculado considerando a folga diametral. Ele eh
% portanto menor do que o valor nominal fornecido.
rb = (anelExt.D2 - anelInt.D2 - c_d)/4;

% Velocidades angulares dos aneis interno e externo
% Como os rolamentos s�o embutidos no mancal, a velocidade angular do
% anel externo e sempre nula.
anelInt.omega = N*pi/30;
anelExt.omega = 0;

% Ball Pass Frequency, Outer
BPFO = Nb/2*(anelInt.omega-anelExt.omega)*(1-cos(alpha)*Db/Dp);

% Frequencias naturais - aneis externo e interno
% Segundo modo de vibra��o do anel considerado
FreqNatural = @(n,E,I,mu,R) n*(n^2-1)/sqrt(1+n^2)*sqrt(E*I/(mu*R^4));
anelExt.omega_n = FreqNatural(2,E,anelExt.I,anelExt.mu,anelExt.Rneu);
anelInt.omega_n = FreqNatural(2,E,anelInt.I,anelInt.mu,anelInt.Rneu);

% Rigidezes anel externo e interno
anelExt.k = anelExt.m*anelExt.omega_n^2;
anelInt.k = anelInt.m*anelInt.omega_n^2;

%% Par�metros do contato entre as superficies
[Rx,Ry,R,Rd,IF,IE,k] = deal(zeros(2,1));

aneis = [anelInt anelExt];

parfor i=1:2
    [Rx(i),Ry(i),R(i),Rd(i)] = RaiosCurvatura(rb,rb,aneis(i).rx,aneis(i).ry);
    [IF(i),IE(i),k(i)] = ParametrosElipseContato(Rd(i));
end

Eef = E/(1-ni^2);
wz_max = ObterCargaMaximaEsfera(Cmax,Nb,c_d,Eef,R,IF,IE,k);

%% Montagem das matrizes do sistema
M = [anelExt.m      0       0; ...
     0              m_b     0; ...
     0              0       anelInt.m];

C = [fiExt.c      -fiExt.c              0; ...
     -fiExt.c     fiExt.c + fiInt.c     -fiInt.c; ...
     0            -fiInt.c              fiInt.c];
 
Klin = [anelExt.k      0       0; ...
        0              0       0; ...
        0              0       anelInt.k];

KfExt = [1     -1       0; ...
        -1      1       0; ...
         0      0       0];

KfInt = [0      0       0; ...
         0      1      -1; ...
         0     -1       1];

% Referencias de funcao para definir a forca externa em cada instante
fImpacto = @(t)(wz_max*square(t*BPFO, 0.5) + wz_max)/2;
F = @(t)[fImpacto(t); 0; 0]; % Vetor de forcas - apenas na pista externa

%% Definicao de condicoes iniciais

% As condicoes de posicao inicial correspondem a espessura do filme
eta = visc*rho;

h = EspessuraFilmeLub(Dp,Db,Rx,k,[aneis.omega],wz_max,Eef, ...
    eta,2.3e-8);

conds_ini = [0; h(2); sum(h); 0; 0; 0];

%% Resolucao do sistema
% Montagem do vetor tempo para os dados de saida
Ts = 1/Fs; % Periodo da amostra
tb = t0:Ts:tf-Ts; % Tempo-base (o solver abaixo gera o vetor tempo t)

% Resolucao das ODEs
[t, y] = ode45(@(t,y) SisNaoLinOrdem2(t,y,M,C,Klin,KfInt,KfExt,F(t),...
    fiInt,fiExt) ,tb, conds_ini);

%% Tratamento dos resultados
resultados = struct('pos',{},'vel',{},'acc',{});
resultados(3).pos = [];
parfor i=1:3
    resultados(i).pos = y(:,i); 
    resultados(i).vel = [diff(resultados(i).pos)./Ts; 0]; 
    resultados(i).acc = [diff(resultados(i).vel)./Ts; 0]; 
end

ext = resultados(1);
esf = resultados(2);
int = resultados(3);

% Determinacao de parametros para o espectro de frequencias
Y = fft(ext.pos);
L = length(y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = (0:L/2)*(Fs/L);

%% Exibicao dos resultados
figure(1);
plot(t,fImpacto(t));
title('Perfil dos impulsos de impacto','Interpreter','latex');
xlabel('Tempo [s]','Interpreter','latex');
ylabel('For\c{c}a [N]','Interpreter','latex');
xlim([0 0.1]);
ylim('auto');

figure(2)
xlimTempo = [0 0.5];
ylimTempo = 'auto';
subplot(3,1,1);
plot(t,ext.pos);
title('Deslocamento','Interpreter','latex');
ylabel('[m]','Interpreter','latex');
xlim(xlimTempo);
ylim(ylimTempo);

subplot(3,1,2);
plot(t,ext.vel);
title('Velocidade','Interpreter','latex');
ylabel('[m/s]','Interpreter','latex');
xlim(xlimTempo);
ylim(ylimTempo);

subplot(3,1,3);
plot(t,ext.acc);
title('Acelera\c{c}\~ao','Interpreter','latex');
ylabel('[m/s^{2}]','Interpreter','latex');
xlim(xlimTempo);
ylim(ylimTempo);

figure(3)
plot(f,P1);
title('Espectro de frequ\^encias','Interpreter','latex');
xlabel('Frequ\^encia [Hz]','Interpreter','latex');