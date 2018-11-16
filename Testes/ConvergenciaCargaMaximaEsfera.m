% Script para teste de convergência da função ObterCargaMaximaEsfera.m

%% Entrada de dados
GerarDadosEntrada;

wzPts = 50:50:200;
c_r = 0:1e-7:20e-6;
res = struct('c_r',[],'wz_max',[]);
res(length(wzPts)).c_r = [];
parfor i=1:length(res)
    wz = wzPts(i);
    
    wz_max = zeros(1,length(c_r));
    
    j = 0;
    while j < length(c_r)
        j = j + 1;
        c_d = 2*c_r(j); % Folga diametral (diametral clearance), metros
        % O raio das esferas e calculado considerando a folga diametral. Ele eh
        % portanto menor do que o valor nominal fornecido.
        rb = (anelExt.D2 - anelInt.D2 - c_d)/4;

        [Rx,Ry,R,Rd,IF,IE,k] = deal(zeros(2,1));
        aneis = [anelInt anelExt];

        for u=1:2
            [Rx(u),Ry(u),R(u),Rd(u)] = RaiosCurvatura(rb,rb,aneis(u).rx,aneis(u).ry);
            [IF(u),IE(u),k(u)] = ParametrosElipseContato(Rd(u));
        end

        Eef = E/(1-ni^2);

        wz_max(j) = ObterCargaMaximaEsfera(wz,Nb,c_d,Eef,R,IF,IE,k);
        if imag(wz_max(j)) ~= 0
            break;
        end
    end
    
    res(i).c_r = c_r(1:j);
    res(i).wz_max = wz_max(1:j);
end

figure('Name','Convergencia carga maxima esfera','NumberTitle','off')
hold on;
labels = {'$\rm w_z=50\ N$'  '$\rm w_z=100\ N$' ... 
    '$\rm w_z=150\ N$'  '$\rm w_z=200\ N$'};
for i=1:length(res)
    plot(res(i).c_r,real(res(i).wz_max));
    xarr = res(i).c_r;
    yarr = real(res(i).wz_max);
    xpt = xarr(floor(length(xarr)/2));
    ypt = yarr(floor(length(yarr)/2)) + 3;
    text(xpt,ypt,labels{i},'Interpreter','latex', ...
        'HorizontalAlignment','right',...
        'FontSize',12);
end
xlabel("$\rm c_d\ [m]$",'Interpreter','latex','FontSize',12)
ylabel("$\rm (w_z)_{max}\ [N]$",'Interpreter','latex','FontSize',12)