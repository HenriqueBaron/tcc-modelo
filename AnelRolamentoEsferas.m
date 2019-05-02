classdef AnelRolamentoEsferas
    %ANELROLAMENTOESFERAS Define o anel de um rolamento de esferas
    %   Caracteriza as propriedades de um anel de rolamento de esferas.
    
    properties
        D % Diametro que fica em contato com o sistema (mancal ou eixo)
        D2 % Diametro que fica em contato com as esferas
        Massa
        MomentoArea % Segundo momento de area, m^4
        RaioNeutro % Raio da linha neutra do perfil
        RaioGrooveX % Raio de curvatura da cavidade da esfera, direcao X
        RaioGrooveY % Raio de curvatura da cavidade da esfera, direcao Y
    end
    
    methods
        function obj = AnelRolamentoEsferas(D,D2,m,I,Rneu,RgX,RgY)
            %ANELROLAMENTOESFERAS Construct an instance of this class
            %   Constroi uma instancia da classe com todas as suas
            %   propriedades.
            obj.D = D;
            obj.D2 = D2;
            obj.Massa = m;
            obj.MomentoArea = I;
            obj.RaioNeutro = Rneu;
            obj.RaioGrooveX = RgX;
            obj.RaioGrooveY = RgY;
        end
        
        function mu = GetMassaLinear(obj)
            %GETMASSALINEAR Retorna a massa linear do anel do rolamento
            mu = obj.Massa/(pi*(obj.D + obj.D2)/2);
        end
        
    end
end

