%
% ENGR 1221
% Application 6
%
% Jonathan Glenn
%
% 11/9/2021


clc
clear

disp('ENGR 1221')
disp('Jonathan Glenn')
disp('Application 6')

c2(1) = 0;
c1(1) = 0;
a_gi(1) = 1;
v1 = 1;
t = 0;
ka = 5.0*10^(-3);
k10 = 2.33*10^(-3);
k12 = 2.50*10^(-3);
k21 = 1.25*10^(-3);
dt = 1;
t = 1:dt:4000;


%Simulation
for k = 1:length(t) - 1
    
    
    a_gi(k+1) = (- ka * a_gi(k)) * dt + a_gi(k);
    c1(k+1) = ((ka * a_gi(k)) / v1) - (k10 + k12) * c1(k) + k21 * c2(k) * dt + c1(k);
    c2(k+1) = k12 * c1(k) - k21 * c2(k) * dt + c2(k);
    
end

%plot
%Labels for 2D plot chart
plot(t,a_gi,'*b')
hold on
plot(t,c1,'-k')
plot(t,c2,'--r')
hold off
xlabel('time')
ylabel('Arbitrary Units')
title('2-Compartment model')
legend('AGI', 'c1', 'c2')

%Question b
med_full = find(c2 > c1);
fprintf('The medication is fully effective in %.2f minutes\n',med_full(1)/60)
%Question C
med_empty = find(c2 <= (0.5*max(c2)));

med_empty(find(med_empty < med_full(1))) = [];
%Question D
fprintf('The medication is effective between %2.f and %2.f minutes',med_full(1)/60,med_empty(1)/60)


%3 compartment
it = 1;
c1_two(1) = 0;
c2_two(1) = 0;
c3_two(1) = 0;
k10 = 2.33*10^(-3);
k12 = 2.50*10^(-3);
k21 = 1.25*10^(-3);
k13 = 0.8*10^(-3);
k31 = 0.4*10^(-3);
dt = 1;
t = 1:dt:16000;


%Simulation 2
for j = 1:length(t)-1
    
    c1_two(j+1) = (it - (k10 + k12 + k13) * c1_two(j) + k21 * c2_two(j) + k31 * c3_two(j)) * dt + c1_two(j); 
    
    c2_two(j+1) = (k12 * c1_two(j) - k21 * c2_two(j)) * dt + c2_two(j);
    
    c3_two(j+1) = (k13 * c1_two(j) - k31 * c3_two(j)) * dt + c3_two(j);
    
end

%plot

plot(t,c1_two,'--b')
hold on
plot(t,c2_two,'-g')
plot(t,c3_two,'*k')
hold off
xlabel('time')
ylabel('Arbitrary Units')
title('3-Compartment Model')
legend('C1','C2','C3')

%Question B
med_full2 = find(c2_two > c1_two & c3_two > c1_two);

%Qustion C
fprintf('The medication is effective from t = %2.f minutes',med_full2(1)/60)

%Qustion D
findValues = c2_two(end) / c3_two(end);
