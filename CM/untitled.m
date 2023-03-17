set(0, 'defaultaxesfontsize', 14)
set(0, 'DefaultFigureWindowStyle', 'docked')
set(0, 'DefaultLineLineWidth', 2)
set(0, 'Defaultaxeslinewidth', 2)

I_s = 0.01e-12;
I_b = 0.1e-12;

V_b = 1.3;
G_p = 0.1;

V = linspace(-1.95, 0.7, 200);
%I = zeros(200, 1);
%I_noise = zeros(200, 1);

for n = 1:200
I(n) = I_s * (exp(V(n)*1.2/25e-3)-1) + G_p*V(n) - I_b * (exp(-(V(n)+V_b)*1.2/25e-3)-1);
I_noise(n) = I(n)*0.2*(2*rand()-1) + I(n);
end

p4 = polyfit(V,I_noise,4);
poly4 = polyval(p4,V);

p8 = polyfit(V,I_noise,8);
poly8 = polyval(p8,V);

figure('name', 'PA-8')

subplot(3,2,1)
plot(V,I_noise,'b'); hold on;
plot(V,poly4,'r--');
plot(V,poly8,'m--'); hold off;
xlabel('Volts  (V)');
ylabel('I   (A)');
legend('Data','Poly4', 'Poly8')

subplot(3,2,2)
semilogy(V,abs(I_noise),'b'); hold on;
semilogy(V,abs(poly4),'r');
semilogy(V,abs(poly8),'m'); hold off;
xlabel('Volts  (V)');
ylabel('I   (A)');
legend('Data','Poly4', 'Poly8')

I_noise = I_noise.';
x = V.';

fo1 = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
fo2 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
fo3 = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');

ff1 = fit(x,I_noise,fo1);
ff2 = fit(x,I_noise,fo2);
ff3 = fit(x,I_noise,fo3);

If1 = ff1(x);
If2 = ff2(x);
If3 = ff3(x);

subplot(3,2,3);
plot(V,I_noise,'b'); hold on;
plot(V,If1, 'r--', 'Linewidth',1);
plot(V,If2, 'g--','LineWidth',1);
plot(V,If3, 'm--','LineWidth',1); hold off;
xlabel('Volts  (V)');
ylabel('I   (A)');
ylim([-5 5]);
legend('Data','fit1', 'fit2', 'fit3');

subplot(3,2,4);
semilogy(V,abs(I_noise),'b'); hold on;
semilogy(V,abs(If1), 'r--', 'Linewidth',1);
semilogy(V,abs(If2), 'g--','LineWidth',1);
semilogy(V,abs(If3), 'm--','LineWidth',1); hold off;
xlabel('Volts  (V)');
ylabel('I   (A)');
legend('Data','fit1', 'fit2', 'fit3');

% subplot(3,2,2)
% semilogy(V,abs(I_noise),'LineWidth',2); hold on;

inputs = V.';
targets = I_noise;
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net)
Inn = outputs;

subplot(3,2,5);
plot(V,I_noise,'b'); hold on;
plot(V,Inn, 'r--', 'Linewidth',1);
xlabel('Volts  (V)');
ylabel('I   (A)');
legend('Data','NN');

subplot(3,2,6);
semilogy(V,abs(I_noise),'b'); hold on;
semilogy(V,abs(Inn), 'r--', 'Linewidth',1);
xlabel('Volts  (V)');
ylabel('I   (A)');
legend('Data','NN');

