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

N = 100;

std = 0.05;
mean = C;
C_rand = std.*randn(N,1) + mean;


%E = linspace(-10, 10, N);
E = 1;
F = zeros(8,1);
F(8) = E;

w = 3*pi;
s = 1j*w;

for n = 1:N    
    C = C_rand(n);
    C = [C, -C, 0, 0, 0, 0, 0, 0;
    -C, C, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, -L, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0];

    A = G + s.*C;
    X = A\F;

    V_out(n) = X(5);
    V_3(n) = X(3);
end

figure('Name','C Pertubations');
histogram(C_rand, 10);
grid;
title('C Pertubations', 'FontSize',16);
xlabel('C  (F)','FontSize',16);
ylabel('Number','FontSize',16);
legend('C', 'FontSize',16)

figure('Name','Gain');
histogram(abs(V_out./E), 10);
grid;
title('Gain', 'FontSize',16);
xlabel('Gain  (V/V)','FontSize',16);
ylabel('Number','FontSize',16);
legend('Gain', 'FontSize',16)