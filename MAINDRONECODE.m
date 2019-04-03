%%13952      5A - 3/20/2019    Team 6
% Determines the specifics of the medical drone and uses inputted values to
% calcualte lift, drag, range.

clc;
clear;

%this section finds the dimensions and physical properties of various parts
%of the drone
drone = input('prototype or medical: ', 's');
wingSpan = input('Wing Span in m: ');

wingWet = input('Wetted area of wing in m^2: ');
fuselWet = input('Wetted area of fuselage in m^2: ');
horTailWet = input('Wetted area of horizontal tail in m^2: ');
vertTailWet = input('Wetted area of vertical tail in m^2: ');

fuselDiam = input('Average diameter of fuselage in m: ');
fuselLength = input('Overall length of fuselage in m: ');

avgWingThick = input('Average thickness of the wing in m: ');
avgHorTailThick = input('Average thickness of the horizontal tail in m: ');
avgVertTailThick = input('Average thickness of the vertical tail in m: ');

avgWingChord = input('Average chord length of wing in m: ');
avgHorTailChord = input('Average chord length of horizontal tail in m: ');
avgVertTailChord = input('Average chord length of vertical tail in m: ');

droneMass = input('Mass of the drone without battery in kg: ');

if (strcmp(drone, 'prototype')) %given values for tiny trainer and prototype
    RPM = 15000;
    pitch  =.0762;
    diam = .1524;
    battMass = .0765;
    batteryEnergy = 31968;
    batteryOutput = 360000;
elseif (strcmp(drone, 'medical')) %given values for option 2 full-scale drone
    RPM = 1806;
    pitch  =.22;
    diam = .254;
    battMass = .48;
    batteryEnergy = 219780;
    batteryOutput = 720000;
    
end

%output begins
fprintf('\nOverall fuselage length ...... %.4f m\n', fuselLength);
fprintf('Overall drone weight ......... %.4f kg\n', droneMass + battMass);
fprintf('Wing theoretical area ........ %.4f m^2\n', ...
    wingWet + (avgWingChord * fuselDiam));
fprintf('Wing span .................... %.4f m\n', wingSpan);
fprintf('Diameter of fuselage ......... %.4f m\n', fuselDiam);

[drag1, drag2] = dragCoeff(avgWingChord, wingSpan, avgWingThick, wingWet,...
    avgVertTailChord, avgVertTailThick, vertTailWet, ...
    avgHorTailChord, avgHorTailThick, horTailWet,...
    fuselLength, fuselDiam, fuselWet, droneMass);

%creates and gives value to thrust and drag vectors
velocity = 0:.25:30;
thrust = zeros(121, 1);
drag = zeros(121, 1);
for i = 0:.25:30
    thrust((i * 4) + 1) = thrustFinder(RPM, pitch, diam, i);
    drag((i * 4) + 1) = (drag1 * i^2) + (drag2/(i^2)); 
end

%plots thrust and drag
plot(velocity, thrust, 'g');
hold on;
plot(velocity, drag, 'r');

ylim([0, thrust(1)]);
xlabel('Velocity in m/s');
ylabel('Thrust(green), Drag(red)in N');
title('Thrust and Drag as a Function of Velocity');

%finds the second point where thrust and drag lines intersect
maxVelocityIdx = 0;
for i = 1:121
    if (abs(thrust(i) - drag(i)) < 0.1)
        maxVelocityIdx = i;
    end
end

%final outputs
if (maxVelocityIdx > 0)
    myRange = range(batteryOutput, battMass, droneMass, drag(maxVelocityIdx));
    fprintf('Range of the Drone............ %.2f m\n', myRange);
    fprintf('Maximum Velocity.............. %.1f m/s\n', (maxVelocityIdx / 4));
    myEndurance = endurance(batteryEnergy, drag(maxVelocityIdx), (maxVelocityIdx / 4));
    fprintf('Endurance of the Drone........ %.2f h\n', myEndurance);
else
    disp('Range of the Drone............ could not be calculated');
    disp('Maximum Velocity.............. could not be calculated');
    disp('Endurance..................... could not be calculated');
end