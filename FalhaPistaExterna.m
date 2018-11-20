% Calcula a vibracao em um rolamento com dano pontual na pista externa.

%% Entrada de dados
GerarDadosEntrada;

%% Propriedades derivadas do rolamento
c_d = 2*c_r; % Folga diametral (diametral clearance), metros
Dp = (anelExt.D + anelInt.D)/2; % Pitch diameter, metros
% O raio das esferas e calculado considerando a folga diametral. Ele eh
% portanto menor do que o valor nominal fornecido.
rb = (anelExt.D2 - anelInt.D2 - c_d)/4;

% Velocidades angulares dos aneis interno e externo
% Como os rolamentos sao embutidos no mancal, a velocidade angular do
% anel externo e sempre nula.
anelInt.omega = N*pi/30;
anelExt.omega = 0;

% Ball Pass Frequency, Outer
BPFO = Nb/2*(anelInt.omega-anelExt.omega)*(1-cos(alpha)*Db/Dp);

% Frequencias naturais - aneis externo e interno
% Segundo modo de vibracao do anel considerado
FreqNatural = @(n,E,I,mu,R) n*(n^2-1)/sqrt(1+n^2)*sqrt(E*I/(mu*R^4));
anelExt.omega_n = FreqNatural(2,E,anelExt.I,anelExt.mu,anelExt.Rneu);
anelInt.omega_n = FreqNatural(2,E,anelInt.I,anelInt.mu,anelInt.Rneu);

% Rigidezes anel externo e interno
anelExt.k = anelExt.m*anelExt.omega_n^2;
anelInt.k = anelInt.m*anelInt.omega_n^2;

%% Parametros do contato entre as superficies
[Rx,Ry,R,Rd,IF,IE,k] = deal(zeros(2,1));

aneis = [anelInt anelExt];

parfor i=1:2
    [Rx(i),Ry(i),R(i),Rd(i)] = RaiosCurvatura(rb,rb,...
        aneis(i).rx,aneis(i).ry);
    [IF(i),IE(i),k(i)] = ParametrosElipseContato(Rd(i));
end

Eef = E/(1-ni^2);
wz_max = ObterCargaMaximaEsfera(wz,Nb,c_d,Eef,R,IF,IE,k);

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
if impulsoTriangular
    fImpacto = @(t)wz_max*ImpulsosTriangulo(t,BPFO,0.00025);
else
    fImpacto = @(t)(wz_max*square(t*BPFO, 0.5) + wz_max)/2;
end
F = @(t)[fImpacto(t); 0; 0]; % Vetor de forcas - apenas na pista externa

%% Definicao de condicoes iniciais
% As condicoes de posicao inicial correspondem a espessura do filme

eta = visc*rho; % Viscosidade absoluta
coefVisc = z*(log(eta) + 9.67)/1.96e8; % Coeficiente de viscosidade-pressao

h = EspessuraFilmeLub(Dp,Db,Rx,k,[aneis.omega],wz_max,Eef, ...
    eta,coefVisc);

conds_ini = [0; h(2); h(1); 0; 0; 0];

%% Resolucao do sistema
% Montagem do vetor tempo para os dados de saida
Ts = 1/Fs; % Periodo da amostra
tb = t0:Ts:tf-Ts; % Tempo-base (o solver abaixo gera o vetor tempo t)

% Resolucao das ODEs
[t, y] = ode113(@(t,y) SisNaoLinOrdem2(t,y,M,C,Klin,KfInt,KfExt,F(t),...
    fiInt,fiExt) ,tb, conds_ini);

%% Tratamento dos resultados
resultados = struct('pos',{},'vel',{},'acc',{});
resultados(3).pos = [];
for i=1:3
    resultados(i).pos = y(:,i); 
    resultados(i).vel = [diff(resultados(i).pos)./Ts; 0]; 
    resultados(i).acc = [diff(resultados(i).vel)./Ts; 0]; 
end

ext = resultados(1);
esf = resultados(2);
int = resultados(3);

%% Exibicao dos resultados
ExibirResultados;