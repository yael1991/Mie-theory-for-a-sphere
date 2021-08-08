
%Matlab function for calculating Mie absorption, scattergin and
%extinction cross sections. It also plots the contribuion to these
%magnitudes of the mie dipolar and quadrupolar coefficients.

function [Q, a1, a2, b1, b2]=eficiencia(indices,lambdas,nmax,a)

maxi=length(lambdas) %number of wavelength to be considered.

for j=1:maxi
    
        qsca=0;
        qext=0;
       
        
        
        
        x=(2*pi*a/lambdas (j));
    
     
    for n=1:1:nmax
        
        an = coeficientes_an(indices(j),lambdas(j),n,a);
        bn = coeficientes_bn(indices(j),lambdas(j),n,a);

         
        
        if n==1 %dipolar contribution
            
            qsca1_a1 = (2*n+1)*(abs(an)^2);
            qsca1_b1 = (2*n+1)*(abs(bn)^2);
            qext1_a1 = (2*n+1)*real(an);
            qext1_b1 = (2*n+1)*real(bn);
        
        end
        
        
        if n==2 %quadrupolar contribution
            
            qsca1_a2 = (2*n+1)*(abs(an)^2);
            qsca1_b2 = (2*n+1)*(abs(bn)^2);
            qext1_a2 = (2*n+1)*real(an);
            qext1_b2 = (2*n+1)*real(bn);
        
        end
        
        
        qsca=qsca+(2*n+1)*(abs(an)^2+abs(bn)^2);
        qext=qext+(2*n+1)*real(an+bn);

        
                    
    end
   
    Qsca_a1(j) = (2/x^2)*qsca1_a1;
    Qsca_b1(j) = (2/x^2)*qsca1_b1;
    
    Qsca_a2(j) = (2/x^2)*qsca1_a2;
    Qsca_b2(j) = (2/x^2)*qsca1_b2;
    
    
    Qext_a1(j) = (2/x^2)*qext1_a1;
    Qext_b1(j) = (2/x^2)*qext1_b1;
    
    Qext_a2(j) = (2/x^2)*qext1_a2;
    Qext_b2(j) = (2/x^2)*qext1_b2;
    
    Qabs_a1(j) = Qext_a1(j) - Qsca_a1(j);
    Qabs_b1(j) = Qext_b1(j) - Qsca_b1(j);
    
    Qabs_a2(j) = Qext_a2(j) - Qsca_a2(j);
    Qabs_b2(j) = Qext_b2(j) - Qsca_b2(j);
    
    
    
    Qsca(j)=(2/x^2)*qsca;
    Qext(j)=(2/x^2)*qext;
    Qabs(j)=Qext(j)-Qsca(j);
end


Q=[Qext;Qsca;Qabs] ;
ev= 1242./lambdas;


%limits for de plots
xmin = min(lambdas);
xmax = max(lambdas);
xmin_ev = min(ev);
xmax_ev = max(ev);
ymax_s = max(Qsca)+0.2;
ymax_e = max(Qext)+0.2;
ymax_a = max(Qabs)+0.2;



figure;
plot(lambdas,Qsca,'r')
hold on
plot(lambdas,Qext,'b')
plot(lambdas,Qabs,'g')
hold off
xlabel('energy (eV)','FontSize',20);
ylabel('Q','FontSize',20);
l=legend('Q_s_c_a', 'Q_e_x_t', 'Q_a_b_s','Location','northeast' );
set(l,'FontSize',20);
set(gca,'FontSize',16);
axis([xmin xmax 0 max([ymax_s, ymax_a, ymax_e])]);
legend boxoff;
title('Cross sections')
box on;
hold off;



%%%%%%%%%% scattering %%%%%%%%%%%%

figure;
plot(ev, Qsca_a1, 'LineWidth',2)
hold on
plot(ev, Qsca_b1, 'r', 'LineWidth',2)
plot(ev, Qsca_a2, 'g', 'LineWidth',2)
plot(ev, Qsca_b2, 'c', 'LineWidth',2)
plot(ev,Qsca,'m', 'LineWidth',2)
xlabel('energy (eV)','FontSize',20);
ylabel('Q_s_c_a','FontSize',20);
l=legend('a1','b1', 'a2', 'b2', 'Q_s_c_a','Location','northeast' );
set(l,'FontSize',20);
set(gca,'FontSize',16);
axis([xmin_ev xmax_ev 0 ymax_s])
legend boxoff;
title('Scattering cross section')
box on;
hold off;

figure;
plot(lambdas, Qsca_a1, 'LineWidth',2)
hold on
plot(lambdas, Qsca_b1, 'r', 'LineWidth',2)
plot(lambdas, Qsca_a2, 'g', 'LineWidth',2)
plot(lambdas, Qsca_b2, 'c', 'LineWidth',2)
plot(lambdas,Qsca,'m', 'LineWidth',2)
xlabel('wavelength (nm)','FontSize',20);
ylabel('Q_s_c_a','FontSize',20);
l=legend('a1','b1', 'a2', 'b2', 'Q_s_c_a','Location','northwest' );
set(l,'FontSize',20);
set(gca,'FontSize',16);
axis([xmin xmax 0 ymax_s])
legend boxoff;
title('Scattering cross section')
box on;
hold off;



%%%%%%%%%%%% extinction %%%%%%%%%%%%



figure;
plot(ev, Qext_a1, 'LineWidth',2)
hold on
plot(ev, Qext_b1, 'r', 'LineWidth',2)
plot(ev, Qext_a2, 'g', 'LineWidth',2)
plot(ev, Qext_b2, 'c', 'LineWidth',2)
plot(ev,Qext,'m', 'LineWidth',2)
xlabel('energy (eV)','FontSize',20);
ylabel('Q_e_x_t','FontSize',20);
l=legend('a1','b1', 'a2', 'b2', 'Q_e_x_t','Location','northwest' );
set(l,'FontSize',20);
set(gca,'FontSize',16);
axis([xmin_ev xmax_ev 0 ymax_e])
legend boxoff;
title('Extinction cross section')
box on;
hold off;

figure;
plot(lambdas, Qext_a1, 'LineWidth',2)
hold on
plot(lambdas, Qext_b1, 'r', 'LineWidth',2)
plot(lambdas, Qext_a2, 'g', 'LineWidth',2)
plot(lambdas, Qext_b2, 'c', 'LineWidth',2)
plot(lambdas,Qext,'m', 'LineWidth',2)
xlabel('wavelength (nm)','FontSize',20);
ylabel('Q_e_x_t','FontSize',20);
l=legend('a1','b1', 'a2', 'b2', 'Q_e_x_t','Location','northeast' );
set(l,'FontSize',20);
set(gca,'FontSize',16);
axis([xmin xmax 0 ymax_e])
legend boxoff;
title('Extinction cross section')
box on;
hold off;


%%%%%%%%% absorption %%%%%%%%%


figure;
plot(ev, Qabs_a1, 'LineWidth',2)
hold on
plot(ev, Qabs_b1, 'r', 'LineWidth',2)
plot(ev, Qabs_a2, 'g', 'LineWidth',2)
plot(ev, Qabs_b2, 'c', 'LineWidth',2)
plot(ev,Qabs,'m', 'LineWidth',2)
xlabel('energy (eV)','FontSize',20);
ylabel('Q_a_b_s','FontSize',20);
l=legend('a1','b1', 'a2', 'b2', 'Q_a_b_s','Location','northwest' );
set(l,'FontSize',20);
set(gca,'FontSize',16);
axis([xmin_ev xmax_ev 0 ymax_a])
legend boxoff;
title('Absorption cross section')
box on;
hold off;

figure;
plot(lambdas, Qabs_a1, 'LineWidth',2)
hold on
plot(lambdas, Qabs_b1, 'r', 'LineWidth',2)
plot(lambdas, Qabs_a2, 'g', 'LineWidth',2)
plot(lambdas, Qabs_b2, 'c', 'LineWidth',2)
plot(lambdas, Qabs,'m', 'LineWidth',2)
xlabel('wavelength (nm)','FontSize',20);
ylabel('Q_a_b_s','FontSize',20);
l=legend('a1','b1', 'a2', 'b2', 'Q_a_b_s','Location','northeast' );
set(l,'FontSize',20);
set(gca,'FontSize',16);
axis([xmin xmax 0 ymax_a])
legend boxoff;
title('Absorption cross section')
box on;
hold off;