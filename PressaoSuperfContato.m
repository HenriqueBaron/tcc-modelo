function p = PressaoSuperfContato(x, y, wz, Dx, Dy)
%PRESSAOSUPERFCONTATO Distribuicao de pressao na superficie de contato.
%   Calcula a pressao em um ponto (x,y) da superficie de contato entre dois
%   solidos.
%   Parametros de entrada:
%   x, y - Ponto na superficie para o qual se deseja a pressao, em metros
%   wz - Forca aplicada ao contato, newtons
%   Dx, Dy - Diametros da elipse de contato entre os solidos, metros
pm = 6*wz/(pi*Dx.*Dy);
p = pm*sqrt(1 - (2*x./Dx).^2 - (2*y./Dy).^2);
end
