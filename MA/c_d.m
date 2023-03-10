R1 = 1;
C = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
alpha = 100;
R4 = 0.1;
Ro = 1000;

g1 = 1/R1;
g2 = 1/R2;
g3 = 1/R3;
g4 = 1/R4;
go = 1/Ro;

G = [g1, -g1, 0, 0, 0, 0, 0, 1;
    -g1, g1+g2, 0, 0, 0, 1, 0, 0;
    0, 0, g3, 0, 0, -1, 0, 0;
    0, 0, 0, g4, -g4, 0, 1, 0;
    0, 0, 0, -g4, g4+go, 0, 0, 0;
    0, 1, -1, 0, 0, 0, 0, 0;
    0, 0, -alpha*g3, 1, 0, 0, 0, 0;
    1, 0, 0, 0, 0, 0, 0, 0];

C = [C, -C, 0, 0, 0, 0, 0, 0;
    -C, C, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, -L, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0];

N = 100;

%E = linspace(-10, 10, N);
E = 1;
F = zeros(8,1);
F(8) = E;

%w = 0;
w = linspace(0, 100, N);
%s = 1j*w;

for n = 1:N
    s = 1i*w(n);
    %F(8) = E(n);
    
    A = G + s.*C;
    X = A\F;

    V_out(n) = X(5);
    V_3(n) = X(3);
end

%figure('Name','DC Response');
%plot(E, V_out,'LineWidth',3); hold on;
%plot(E, V_3,'LineWidth',3); hold off
plot(w, abs(V_out./E),'LineWidth',3); hold on;
plot(w, abs(V_3./E),'LineWidth',3); hold off;
grid;
title('DC Response', 'FontSize',16);
%xlabel('V_{in}  (V)','FontSize',16);
xlabel('\omega  (Hz)','FontSize',16);
%ylabel('V_{out}  (Volts)','FontSize',16);
ylabel('|V_{out}/V_{in}|  (dB)','FontSize',16);
legend('V_{out}','V_3', 'FontSize',16)