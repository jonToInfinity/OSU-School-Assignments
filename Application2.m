%
% ENGR 1221
% Application 2
%
% Jonathan Glenn
%
% 9/21/2021


clc
clear

disp('ENGR 1221')
disp('Jonathan Glenn')
disp('Application 2')


load temp_data.mat
vec_Year = temp_data(:,1);
vec_Month = temp_data(:,2);
vec_Day = temp_data(:,3);
vec_Temp = temp_data(:,4);

% Problem a.   
 prob_a = mean(vec_Temp(vec_Year>=1880 & vec_Year<=1948));
fprintf('The mean from 1880 to 1948 is %.3f degrees \n', prob_a) 

%Problem b.
prob_b = mean(vec_Temp(vec_Year>=1958 & vec_Year <= 2018));
fprintf('The mean from 1958 to 2018 is %.3f degrees \n', prob_b)

%Problem c.
prob_c = sum(vec_Temp(vec_Year>=1880 & vec_Year<=1948)>=0);
fprintf('The temperature was positive on %.3f days from 1880 to 1948 \n', prob_c)

%Problem d. 
prob_d = sum(vec_Temp(vec_Year>=1958 & vec_Year<= 2018)>=0);
fprintf('The temperature was positive on %.3f days from 1958 to 2018 \n', prob_d)

%Problem e.
[e,i] = max(vec_Year);
e_i = temp_data(i,1);
e_ii = temp_data(i,2);
e_iii = temp_data(i,3);
fill_one = 'The highest temperature anomaly ever occured on %.f-%.f-%.f';
fprintf(fill_one,e_i,e_ii,e_iii)


%Problem f.
[f,i] = min(vec_Temp);
f_i = temp_data(i,1);
f_ii = temp_data(i,2);
f_iii = temp_data(i,3);
fill_two = 'The lowest temperature anomaly ever occured on %.f-%.f-%.f';
fprintf(fill_two,f_i,f_ii,f_iii)

%problem g. 
prob_g = max(vec_Temp) - min(vec_Temp);
fprintf('The difference between the highest and lowest temperature anomalies is %.3f.\n', prob_g)

%problem h.
prob_h = min(vec_Temp(vec_Temp>=2.0));
h_i = temp_data(prob_h,1);
h_ii = temp_data(prob_h,2);
h_iii = temp_data(prob_h,3);
fill_three = 'The first time the temperature anomaly was greater than 2.0 degrees was on %.f-%.f-%.f.\n';
fprintf(fill_three,h_i,h_ii,h_iii)

%problem j.
j_one = std(vec_Temp(vec_Year>=1900 & vec_Year<=1918));
j_two = std(vec_Temp(vec_Year>=2000 & vec_Year<=2018));
fprintf('The Standard Deviation of the temperature from 1900 to 1918 is %.3f. \n', j_one)
fprintf('The Standard Deviation of the temperature from 2000 to 2018 is %.3f. \n', j_two)
fprintf('The Standard Deviation from 2000 to 2018 is higher than from the year 1900 to 1918 %.3f. \n')
%problem k.
Na_N = find(isnan(vec_Temp));
NaN_year = vec_Year(Na_N(1));
fprintf('The year where the NaNs occured was %i. \n', NaN_year)

%problem l.
temp_data(Na_N, :) = [];
check = sum(isnan(temp_data))