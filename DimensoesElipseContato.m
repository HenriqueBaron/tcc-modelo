function [Dx, Dy] = DimensoesElipseContato(wz, Eef, R, IE, k)
%DIMENSOESELIPSECONTATO Calcula os diametros da elipse de contato.
%   Calcula os diametros da elipse formada no contato entre duas
%   superficies.
%   Parametros de entrada:
%   wz - Forca aplicada ao contato, newtons
%   Eef - Modulo de elasticidade efetivo, Pa
%   R - Soma de curvatura, metros
%   IE - Integral eliptica de primeiro tipo
%   k - Parametro de elipticidade
a = 2*(6.*IE.*wz.*R/(pi*Eef)).^(1/3);
Dy = a.*k.^(2/3);
Dx = a.*k.^(-1/3);
end

