% Script para teste de convergência da função ObterCargaMaximaEsfera.m

%% Entrada de dados
GerarDadosEntrada;

c_r = 0:1e-7:9.5e-6;
wz_max = zeros(1,length(c_r));

parfor i=1:length(c_r)
    c_d = 2*c_r(i); % Folga diametral (diametral clearance), metgitros
    % O raio das esferas e calculado considerando a folga diametral. Ele eh
    % portanto menor do que o valor nominal fornecido.
    rb = (anelExt.D2 - anelInt.D2 - c_d)/4;

    [Rx,Ry,R,Rd,IF,IE,k] = deal(zeros(2,1));
    aneis = [anelInt anelExt];

    for j=1:2
        [Rx(j),Ry(j),R(j),Rd(j)] = RaiosCurvatura(rb,rb,aneis(j).rx,aneis(j).ry);
        [IF(j),IE(j),k(j)] = ParametrosElipseContato(Rd(j));
    end

    Eef = E/(1-ni^2);

    wz_max(i) = ObterCargaMaximaEsfera(wz,Nb,c_d,Eef,R,IF,IE,k);
end

plot(c_r,real(wz_max))