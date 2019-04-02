function [dragCoeff1, dragCoeff2] = dragCoeff(avgChordWing, ...
    wingSpan, thickWing, wetWing, avgChordVertTail,  ...
    thickVertTail, wetVertTail, avgChordHorTail,  ...
    thickHorTail, wetHorTail, lengthFuse, diamFuse, wetFuse, massDrone)
%calculates drag coefficients 

%dragCoeff2         coefficient for drag that will be multiplied by v^2
%dragCoeff1         coefficient for drag that will be multiplied by 1/v^2

%avgChordxxx        average chord of wing
%wetxxx             wetted area of part
%thickxxx           average depth of wing
%lengthFuse         distance on fuselage from tip to tail
%diamFuse           width of fuselage sideways while looking down at drone

%% Zero lift drag
%Precalculated coefficients of friction
coeffFricWings = (0.455) / (4.556 ^ 2.58);
coeffFricFuse = (0.455) / (5.26 ^ 2.58);

%main wings
sRef = wetWing + (avgChordWing * diamFuse);
actAreaWing = sRef - (avgChordWing * diamFuse);
ffWing = 1 + 2 * (thickWing / avgChordWing) + 60 * ...
    ((thickWing / avgChordWing) ^ 4);
zeroLDragWing = (coeffFricWings * ffWing * actAreaWing) / sRef;

%horizontal tail
ffHorTail = 1 + 2 * (thickHorTail / avgChordHorTail) + 60 * ...
    ((thickHorTail / avgChordHorTail) ^ 4);
zeroLDragHorTail = (coeffFricWings * ffHorTail) / sRef;

%vertical tail
ffVertTail = 1 + 2 * (thickVertTail / avgChordVertTail) + 60 * ...
    ((thickVertTail / avgChordVertTail) ^ 4);
zeroLDragVertTail = (coeffFricWings * ffVertTail) / sRef;

%fuselage
ffFuse = 1 + 1.5 * ((diamFuse / lengthFuse) ^ (3 / 2)) + 7 *...
    ((diamFuse / lengthFuse) ^ 3);
zeroLDragFuse = (coeffFricFuse * ffFuse * wetFuse) / sRef;

ZLDragCoeff = zeroLDragWing + zeroLDragHorTail + zeroLDragVertTail +...
    zeroLDragFuse;

%% Induced Drag
aspectRatio = (wingSpan ^ 2) / sRef;
liftCoeff = (2 * massDrone * 9.8) / (1.134 * sRef);
IDragCoeff = (liftCoeff ^ 2) / (pi * 0.85 * aspectRatio);

%% Final drag coefficients
dragCoeff1 = (1 / 2) * 1.134 * (sRef) * ZLDragCoeff;
dragCoeff2 = (1 / 2) * 1.134 * (sRef) * IDragCoeff;
