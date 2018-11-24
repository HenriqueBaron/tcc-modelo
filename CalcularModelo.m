tf = 4; % Instante final, segundos
Fs = 50e3; % Frequencia de amostragem, hertz

[resultados, FImp, t] = FalhaPistaExterna(tf, Fs);
ext = resultados(1);
esf = resultados(2);
int = resultados(3);

ExibirResultados;