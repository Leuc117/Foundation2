%%13952      5A - 3/20/2019    Team 6
% Determines the specifics of the medical drone and uses inputted values to
% calcualte lift, drag, range.

clc;
clear;

%this section finds the dimensions and physical properties of various parts
%of the drone
wingTheo = input("Theoretical area of wing: ");
wingSpan = input("Wing Span: ");
wingThick = input("Wing Thickness: ");

wingWet = input("Wetted area of wing: ");
fuselWet = input("Wetted area of fuselage: ");
tailWet = input("Wetted area of tail: ");

fuselDiam = input("Average diameter of fuselage: ");
fuselLength = input("Overall length of fuselage: ");

horTailLength = input("Length of the horizontal tail: ");

avgWingThick = input("Average thickness of the wing: ");
avgHorTailThick = input("Average thickness of the horizontal tail: ");
avgVertTailThick = input("Average thickness of the vertical tail: ");

avgWingChord = input("Average chord length of wing: ");
avgHorTailChord = input("Average chord length of horizontal tail: ");
avgVertTailChord = input("Average chord length of horizontal tail: ");

droneMass = input("Mass of the drone: ");
battMass = input("Mass of the battery: ");

%some constants are defined
RPM = 1806; %emax 1806
pitch  =.0762;
diam = .1524;
velocity = 1:30;
drag = 1:30;
batteryEnergy = .36;

%output begins
fprintf('Overall fuselage length ...... %f m', fuselLength);
fprintf('Overall fuselage length ...... %f kg', droneWeight);
fprintf('Wing theoretical area ........ %f m^2', wingTheo);
fprintf('Wing span .................... %f m', wingSpan);
fprintf('Diameter of fuselage ......... %f m', fuselDiam);

Thrust = thrustFinder(RPM, pitch, diam);
[drag1, drag2] = dragCoeff(avgWingChord, wingSpan, avgWingThick, avgVertTailChord, ...
    avgVertTailThick, avgHorTailChord, horTailLength, avgHorTailThick, fuselLength, fuselDiam);

for i = 1 : 30
   drag(i) = drag1 * i^2 + (c2/(i^2)); 
end

plot(Thrust, velocity, 'g');
hold on;
plot(drag, velocity, 'r');

xlabel("Velocity m/s");
ylabel("Thrust(green), Drag(red)");
title("Thrust and Drag as a Function of Velocity");

myRange = range(batteryEnergy, battMass, droneMass, Thrust(30), drag(30));
fprintf("Range of the Drone.............. %f", myRange);