function [ Phi dPhidr ] = WallPot(r, Epsilon, Sigma)

%Phi = 1e-31*r^-10;
%dPhidr = 10*-1e-31* r^-11;

Phi = 1 * Epsilon * (Sigma^13 * r^-13 - Sigma^7 * r^-7);
dPhidr = 1 * Epsilon * (Sigma^13 * (-13) * r^-14 - Sigma^7 * (-7) * r^-8);

end

