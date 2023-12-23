function [wnp, wnr, wns, zeta, beta] = getOmegaNs(Tp,Tr,Ts,OS)
    os_log_squared = (log(OS))^2;
    zeta = sqrt(os_log_squared/(pi^2 + os_log_squared));
    beta = sqrt(1 - zeta^2);
    wnp = pi/(beta*Tp);
    wnr = 1/(beta*Tr)*(pi - atan(beta/3));
    wns = 1/(zeta * Ts)*log(50/beta);
    