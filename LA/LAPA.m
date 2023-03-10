set(0, 'DefaultFigureWindowStyle', 'docked')

nx = 100;
ny = 100;
ni = 5000;
V = zeros(nx, ny);

BC_x1 = 5;
BC_x2 = 0;
BC_y1 = -1;
BC_y2 = 7;

imbox = 0;

ZL = max([BC_x1 BC_x2 BC_y1 BC_y2]);

for k = 1:ni
    for i = 1:nx
        for j = 1:ny

            if (~imbox)
                % corners
                if (j == 1 && i == 1)
                    V(i,j) = (V(i+1,j) + V(i, j+1))/2;
                elseif (j == ny && i == nx)
                    V(i,j) = (V(i-1,j) + V(i, j-1))/2;
                elseif (j == 1 && i == nx)
                    V(i,j) = (V(i-1,j) + V(i, j+1))/2;
                elseif (j == ny && i == 1)
                    V(i,j) = (V(i+1,j) + V(i, j-1))/2;

                    % edges
                elseif (i == 1)
                    V(i,j) = (V(i+1,j) + V(i, j-1) + V(i, j+1))/3;
                elseif (j == 1)
                    V(i,j) = (V(i+1,j) + V(i-1, j) + V(i, j+1))/3;
                elseif (j == ny)
                    V(i,j) = (V(i+1,j) + V(i-1, j) + V(i, j-1))/3;
                elseif (i == nx)
                    V(i,j) = (V(i-1,j) + V(i, j+1) + V(i, j-1))/3;
                else

                    % main calculation - non boundry condition
                    V(i,j) = (V(i-1,j) + V(i+1, j) + V(i, j+1) + V(i, j-1))/4;
                end
            end

            % boundry conditions
            if (BC_x1 ~= -1 && i == 1)
                V(i,j) = BC_x1;
            elseif (BC_x2 ~= -1 && i == nx)
                V(i,j) = BC_x2;
            elseif (BC_y1 ~= -1 && j == 1)
                V(i,j) = BC_y1;
            elseif (BC_y2 ~= -1 && j == ny)
                V(i,j) = BC_y2;
            end
        end
    end

    if (imbox)
        V = imboxfilt(V,15);
    end
    if mod(k, 50) == 0
        %imboxfilt(V,3);
        surf(V')
        zlim([0 ZL])
        pause(0.05)
    end
end

[Ex, Ey] = gradient(V);

figure
quiver(-Ey', -Ex', 3)