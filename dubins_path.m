%starting Pose
xs = 0; ys = 0; phis=deg2rad(0);  
%final Pose
xf = 10; yf = 10; phif=deg2rad(70); 
%curvature constraints: 
rhos = 3; rhof = 1; 
%center of curvature circles: 
xcs = xs - rhos*cos(phis - pi/2); 
ycs = ys - rhos*sin(phis - pi/2); 
xcf = xf - rhof*cos(phif - pi/2); 
ycf = xf - rhof*sin(phif - pi/2); 

%tangent entry (E) and exit (X)
c = sqrt((xcs - xcf)^2 + (ycs-ycf)^2); 
alpha = asin((rhof-rhos)/c); 
beta = atan2(ycf-ycs, xcf - xcs); 
%E
% phi = alpha+beta +pi/2; % left turn  
phi = beta-alpha +3*pi/2; % right turn 
xPX = xcs + rhos*cos(phi); 
yPX = ycs + rhos*sin(phi);
%X
phi = alpha+beta +pi/2; % left turn  
% phi = beta-alpha +3*pi/2; %right turn
xPN = xcf + rhof*cos(phi); 
yPN = ycf + rhof*sin(phi); 

close all; 
figure()
hold on 
%plot circles:
centers = [xcs ycs; xcf ycf]; radii = [rhos; rhof];
viscircles(centers,radii)

%plot poses: 
plot(xs, ys, 'ro', 'MarkerSize', 30);
plot(xf, yf, 'ro', 'MarkerSize', 30);


%plot center line
xc = [xcs xcf];
yc = [ycs ycf];
plot(xc, yc, '--')

xT = [xPX xPN]; yT = [yPX yPN]; 
plot(xT, yT, 'k','lineWidth', 3)
hold off
print -dpng path.png