clc
clear
disp('Names: Edward Kill, Elizabeth Nogueira Meza, Jonathan Glenn, Dalton Dougherty')
disp('Class: ENGR 1221 AU2021')
disp('Instructor: Dr. Wesley Boyette')

% Part 1 - Simulation of automobile cruise control

%simulate the speed of an automobile based on a basic traction model as it 
%travels a road of varying grade. Simulate PID control of the vehicle’s speed
%and study how it responds to a sudden change in grade as a function of control parameters.

% Input Constants
m = 20000; % mass in kg
f = 0.015; % rolling resistance coefficient
p = 1.2; % density of air in kg/m^3
Cd = 0.5; % drag coefficient
A = 4; % area of front cross section in m^2
g = 9.82; % gravity
tau = 0.8; % engine time constant in s
k = 2000; % engine torque gain factor Nm/rad
i = 4; % gear ratio
Rw = 0.5; % wheel radius in m



% Variable Initilizations
v = 40; % initialized velocity at t = 0
x = 0; % initialized position at t = 0
a = 0; % initialized acceleration at t = 0
Fw = 0; % initialized force application to wheels at t = 0
theta = 0; % road inclinitation at t = 0
u = 0; % accelerator position in radians

% time interval
dt = .01; % time increment !! Not Seconds !!
td = 16; % time stop !! Not Seconds !!
t = (0:dt:td);

% PID Values
V_set = 55;
P = -0.0006;
I = -0.00001;
D = -0.45;
N = 3;

% Step Change Simulation Loop
for int = (1:length(t))
    % increase cruise speed
    if t(int) >= td/2
        V_set = 65;
    end
    Fw(end + 1) = ((-Fw(end)/tau) + (k*i/tau*Rw) * u(end)) + Fw(end);
    v(end + 1) = (v(end) + a(end) * t(int));
    a(end + 1) = ((Fw(end - 1) - m*g*f*cosd(theta) - .5*p*Cd*A*(v(end - 1)^2) - m*g*sind(theta))/m);
    x(end + 1) = x(end) + v(end - 1);
    u(end + 1) = u(end) + controlalg(v(end - 1),V_set,P,I,D,N); % using control algorithm function
end


% Plot
time = (0:length(x)-1);

yyaxis left
plot(time,x,'b')
hold on
yyaxis right
plot(time,v,'r')
hold on
plot(time,a,'k')
legend('pos','velocity','acceleration','Location','best')
title('Velocity, Position, Acceleration vs Time')
xlabel('Time (seconds)')
ylabel('Meters')
hold off

  function[y] = controlalg(T, T_set, P,I,D,N)
% P = proportional to current error
% I = proportional to integral of last several errors
% D = proportional to difference between last two error values
x = T-T_set;
if length(x) == 1
    y = P*x(end);
    
elseif length(x)>1&length(x)<N
        y = P*x(end)+ D*(x(end)-x(end-1))+I*sum(x);
        
elseif length(x)>=N
            y = P*x(end)+ D*(x(end)-x(end-1))+I*sum(x(end-N+1:end));
%else y = P*x(end)+I*sum(x)
end
end