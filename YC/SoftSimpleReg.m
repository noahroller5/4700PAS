winstyle = 'docked';
% winstyle = 'normal';

set(0,'DefaultFigureWindowStyle',winstyle)
set(0,'defaultaxesfontsize',18)
set(0,'defaultaxesfontname','Times New Roman')
%set(0,'defaultfigurecolor',[1 1 1])

% clear VARIABLES;
clear
global spatialFactor;
global c_eps_0 c_mu_0 c_c c_eta_0
global simulationStopTimes;
global AsymForcing
global dels
global SurfHxLeft SurfHyLeft SurfEzLeft SurfHxRight SurfHyRight SurfEzRight

dels = 0.75;
spatialFactor = 1;

% constants
c_c = 299792458;                  % speed of light
c_eps_0 = 8.8542149e-12;          % vacuum permittivity
c_mu_0 = 1.2566370614e-6;         % vacuum permeability
c_eta_0 = sqrt(c_mu_0/c_eps_0);

tSim = 200e-15
f = 200e12;
lambda = c_c/f;

% size of simulations
xMax{1} = 20e-6;
nx{1} = 200;
ny{1} = 0.75*nx{1};

Reg.n = 1;

mu{1} = ones(nx{1},ny{1})*c_mu_0;

epi{1} = ones(nx{1},ny{1})*c_eps_0;

%  epi{1}(110:115,50:100)= c_eps_0*11.3;
%  epi{1}(120:125,50:100)= c_eps_0*11.3;
%  epi{1}(130:135,50:100)= c_eps_0*11.3;
%  epi{1}(140:145,50:100)= c_eps_0*11.3;
%  epi{1}(110:145,73:77)= c_eps_0;
% 
% epi{1}(10:20,15:40)= c_eps_0*11.3;
% epi{1}(25:30,15:40)= c_eps_0*11.3;

% % eyes
%  epi{1}(125:150,85:105)= c_eps_0*5;
%  epi{1}(50:75,85:105)= c_eps_0*5;
% % 
% % % mouth
%  epi{1}(25:175,35:70)= c_eps_0*5;
%  epi{1}(35:165,40:65)= c_eps_0;

sigma{1} = zeros(nx{1},ny{1});
sigmaH{1} = zeros(nx{1},ny{1});

dx = xMax{1}/nx{1};
dt = 0.25*dx/c_c;
nSteps = round(tSim/dt*2);
yMax = ny{1}*dx;
nsteps_lamda = lambda/dx

movie = 1;
Plot.off = 0;
Plot.pl = 0;
Plot.ori = '13';
Plot.N = 100;
Plot.MaxEz = 1.1;
Plot.MaxH = Plot.MaxEz/c_eta_0;
Plot.pv = [0 0 90];
Plot.reglim = [0 xMax{1} 0 yMax];

bc{1}.NumS = 1;
bc{1}.s(1).xpos = nx{1}/(4) + 1;
bc{1}.s(1).type = 'ss';
bc{1}.s(1).fct = @PlaneWaveBC;

bc{1}.NumS = 2;
bc{1}.s(2).xpos = 150;
bc{1}.s(2).type = 'ss';
bc{1}.s(2).fct = @PlaneWaveBC;


% mag = -1/c_eta_0;
mag = 1;
phi = 0;
omega = f*2*pi;
betap = 0;
t0 = 30e-15;
st = 15e-15;
%st = 0.05;
s = 0;     % delay before decay
y0 = yMax/2;
sty = 1.5*lambda;
bc{1}.s(1).paras = {mag,phi,omega,betap,t0,st,s,y0,sty,'s'};

% mag = -1/c_eta_0;
mag_2 = 1;
phi_2 = 0;
omega_2 = f*2*pi*1.1;
betap_2 = 0;
t0_2 = 30e-15;
st_2 = 15e-15;
%st = 0.05;
s_2 = 0;     % delay before decay
y0_2 = yMax/4;
sty_2 = 1.5*lambda;
bc{1}.s(2).paras = {mag_2,phi_2,omega_2,betap_2,t0_2,st_2,s_2,y0_2,sty_2,'s'};

Plot.y0 = round(y0/dx);

% 'a' - no reflection, 'e' - reflection
bc{1}.xm.type = 'e';    % left wall
bc{1}.xp.type = 'e';    % right wall
bc{1}.ym.type = 'e';
bc{1}.yp.type = 'e';

pml.width = 20 * spatialFactor;
pml.m = 3.5;

Reg.n  = 1;
Reg.xoff{1} = 0;
Reg.yoff{1} = 0;

RunYeeReg






