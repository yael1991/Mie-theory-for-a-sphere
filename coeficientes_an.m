%%Calcula los an.

function an=coeficientes_an(indice, lambda, n, a)


    x=(2*pi*a/lambda);
    nu=n+0.5;
    m=indice;
    mx=m*x;
    
        sqmx=sqrt(pi/(2*mx));
        sqx=sqrt(pi/(2*x));
        
        %orden n
        bmx=besselj(nu,mx)*sqmx;
        bx=besselj(nu,x)*sqx;
        by=bessely(nu,x)*sqx;
        h1x=bx+ 1i*by;
        
        %orden n-1 necesarias para derivadas
        bmx_1=besselj(nu-1,mx)*sqmx;
        bx_1=besselj(nu-1,x)*sqx;
        by_1=bessely(nu-1,x)*sqx;
        h1x_1=bx_1+ 1i* by_1;
        
        %derivadas
        dbmx=mx*bmx_1-n*bmx;
        dbx=x*bx_1-n*bx;
        dh1x=x*h1x_1-n*h1x;
        
        an=( m^2*bmx*dbx - bx*dbmx ) / (m^2*bmx*dh1x - h1x*dbmx);
