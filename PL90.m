function PL=PL90(indices,lambdas,a)

maxi=length(lambdas) %number of wavelength to be considered.
for j=1:maxi

        
        a1 = coeficientes_an(indices(j),lambdas(j),1,a);
        b1 = coeficientes_bn(indices(j),lambdas(j),1,a);
        
        a2 = coeficientes_an(indices(j),lambdas(j),2,a);
        b2 = coeficientes_bn(indices(j),lambdas(j),2,a);
        
        f1 = (9*a1 - 15*b2) * conj((9*a1 - 15*b2));
        f2 = (9*b1 - 15*a2) * conj((9*b1 - 15*a2)); 
       
        
        PL(j) = (f1 - f2) / (f1 + f2);
            
end

xmax = max(lambdas);
xmin = min(lambdas);

figure;
cero  =  @(x) 0
hold on
plot(lambdas,PL,'r', 'LineWidth',2)
fplot(cero,[xmin,xmax],'k')
xlabel('wavelength (nm)','FontSize',20);
ylabel('PL(90º)','FontSize',20);
set(gca,'FontSize',16);
axis([xmin xmax -1 1]);
title('PL (90º)')
hold off;

