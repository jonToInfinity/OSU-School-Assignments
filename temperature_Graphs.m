%
% ENGR 1221
% Application 3
%
% Jonathan Glenn
%
% 10/7/2021


clc
clear

disp('ENGR 1221')
disp('Jonathan Glenn')
disp('Application 3')
 




%Prompt User for values

for i =1:3
t_Set = input('Enter the value of T_set: ');

P = input('Enter the value of P: ');

D = input('Enter the value of D: ');

I = input('Enter the value of I: ');

N = input('Enter the value of N: ');

%Initailize values
T = [];

y =0;
clear temperature_measurement

for k = 1:50
    curr_Temp = temperature_measurement(y);
    
    T(k)= curr_Temp;
    
    y = control_f(T,t_Set,P,D,I,N);
end
%plotting Temperature vs Time graph
hold on

time = [0:length(T)-1];

plot(T)

title('Temperature vs. Time')

xlabel('Time (Arbitrary Units)')

ylabel('Temperature (Arbitrary Units)')

legend('Test40', 'Test50', 'Test60')


f_Error= T(end)-t_Set;
fprintf('The final error is %.4f.\n', f_Error)



%%Classifying the system response
 if (f_Error/t_Set)<-0.01
     fprintf('System is overdamped\n\n')
     
 elseif ((max(T) - t_Set) /t_Set)>0.01
     fprintf('System is underdamped\n\n')
     
 else
     fprintf('System is near-critically damped\n\n')
 end

 
end
 
