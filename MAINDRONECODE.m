%%13952      5A - 3/20/2019    Team 6
% Determines the specifics of the medical drone and uses inputted values to
% calcualte lift, drag, range.

clc;
clear;

%this section finds the dimensions and physical properties of various parts
%of the drone
drone = input('prototype or medical: ', 's');
wingSpan = input('Wing Span: ');

wingWet = input('Wetted area of wing: ');
fuselWet = input('Wetted area of fuselage: ');
horTailWet = input('Wetted area of horizontal tail: ');
vertTailWet = input('Wetted area of vertical tail: ');

fuselDiam = input('Average diameter of fuselage: ');
fuselLength = input('Overall length of fuselage: ');

avgWingThick = input('Average thickness of the wing: ');
avgHorTailThick = input('Average thickness of the horizontal tail: ');
avgVertTailThick = input('Average thickness of the vertical tail: ');

avgWingChord = input('Average chord length of wing: ');
avgHorTailChord = input('Average chord length of horizontal tail: ');
avgVertTailChord = input('Average chord length of vertical tail: ');

droneMass = input('Mass of the drone: ');
battMass = input('Mass of the battery: ');

if (strcmp(drone, 'prototype'))
    RPM = 15000;
    pitch  =.0762;
    diam = .1524;
    batteryEnergy = 360000;
elseif (strcmp(drone, 'medical'))
    RPM = 1806;
    pitch  =.22;
    diam = .254;
    batteryEnergy = 720000;
end

velocity = 1:30;
thrust = 1:30;
drag = 1:30;

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
    fuselLength, fuselDiam, fuselWet, droneMass + battMass);

for i = 1 : 30
    thrust(i) = thrustFinder(RPM, pitch, diam, i);
    drag(i) = (drag2 * i^2) + (drag1/(i^2)); 
end

plot(thrust, velocity, 'g');
hold on;
plot(drag, velocity, 'r');

xlabel('Velocity m/s');
ylabel('thrust(green), Drag(red)');
title('thrust and Drag as a Function of Velocity');

maxVelocity = 0;
for i = 1 : 30
    if (abs(thrust(i) - drag(i)) < 0.25)
        maxVelocity = i;
        break
    end
end

%this needs to be done at max velocity
if (maxVelocity > 0)
    myRange = range(batteryEnergy, battMass, droneMass, thrust(maxVelocity),...
    drag(maxVelocity));
    fprintf('Range of the Drone............ %f m\n', myRange);
    fprintf('Maximum Velocity.............. %f m/s\n', maxVelocity);
    myEndurance = endurance(batteryEnergy, drag(maxVelocity), maxVelocity);
    fprintf('Endurance of the Drone........ %f m\n', myEndurance);
else
    disp('Range of the Drone............ could not be calculated');
    disp('Maximum Velocity.............. could not be calculated');
    disp('Endurance..................... could not be calculated');
end