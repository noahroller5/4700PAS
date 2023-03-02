set(0,'DefaultFigureWindowStyle', 'docked')
set(0,'defaultaxesfontsize', 10)
set(0,'defaultaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth', 2);

nx = 51;
ny = 50;
V = zeros(nx, ny);
G = sparse(nx*ny, nx*ny);

dx = 1;
dy = 1;

%Inclusion = 0;

for i = 1:nx                                 
    for j = 1:ny %...
        n = j + (i-1) * ny;
            
        if (i > 10 & i < 20 & j > 10 & j < 20)
            material = 2;
        else
            material = 4;
        end           

        if (i == 1 || i == nx || j == 1 || j == ny)
            % initialize entire row to zeros - or do we want to
            % keep it sparse?
            G(n,:) = 0;
            G(n,n) = 1;
        else
            % calculate new n for indexing G
            nxm = j + (i-2) * ny;       % i-1
            nxp = j + i * ny;           % i+1
            nym = (j-1) + (i-1) * ny;   % j-1
            nyp = (j+1) + (i-1) * ny;   % j+1

            G(n,n) = -material/dx^2;
            G(n, nxm) = 1/dx^2;
            G(n, nxp) = 1/dx^2;
            G(n, nym) = 1/dx^2;
            G(n, nyp) = 1/dx^2;
        end
    end
end

figure('name','Matrix')
spy(G)

nmodes = 20;
[E,D] = eigs(G,nmodes,'SM');

figure('name','EigenValues')
plot(diag(D),'*');

np = ceil(sqrt(nmodes))
figure('name','Modes')
for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = j + (i-1) * ny;
            V(i,j) = M(n);
        end

        subplot(np, np, k), surf(V,'linestyle','none')
        title(['EV= ' num2str(D(k,k))])
        view(0,90)
    end
end 

