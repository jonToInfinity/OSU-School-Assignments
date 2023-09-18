%
% ENGR 1221
% Application 1
%
% Jonathan Glenn
%
% 9/7/2021


clc
clear

disp('ENGR 1221')
disp('Jonathan Glenn')
disp('Application 1')


% Problem 1 - Loading, Displaying, and Modifying a Grey-Scale

disp('****** Problem 1 ******')

% loading/ displaying puppy variable

load puppy;
imshow(puppy)

% increasing brightness 
inc = 50;
new_puppy = inc + puppy;
imshow(new_puppy)

% increasing contrast
org_pup = single(puppy);
con_pup = (0.5 / 255) * (org_pup.^ 2) + (0.5 * org_pup);
newer_puppy = uint8(con_pup);
imshow(newer_puppy)

% displaying darkest features of the puppy
diff_pup = puppy - newer_puppy;
dark_puppy = puppy.* diff_pup;
imshow(dark_puppy)


% All 4 images of the puppy on subplot
subplot(2,2,1)
imshow(puppy)

subplot(2,2,2)
imshow(new_puppy)


subplot(2,2,3)
imshow(newer_puppy)

subplot(2,2,4)
imshow(dark_puppy)

disp('******Problem 2******')
% Char Array Creation
my_life = ['I love myself'];
key = randi([-5,5], 1, 13);
% Encryption of my_life array
char('I love myself' + key)

% Decryption of my_life array
char(ans - key)



disp('******Problem 3******')
% Equation Variables
t = [-2*pi:0.1: 2*pi];
A = 1;
w_O = 1;
a_O = 0;
n = 1;

% Array of series
series_1 = 8 / (pi^2) * cos(t);
series_2 = 8 / 9 * (pi^2) * cos(3 * t);
series_3 = 8 / 25 * (pi^2) * cos(5 * t);
series_4 = 8 / 49 * (pi^2) * cos(7 * t);


x_exact = sawtooth(t+pi, 1/2);
sum_two = series_1 + series_2;
sum_four = series_1 + series_2 + series_3 + series_4;
x_T = [series_1, series_2, series_3, series_4];

figure

% plot the following versus t
plot(t, series_1, 'r')
hold on

plot(t, sum_two, 'g')

plot(t, sum_four, 'b')

plot(t, x_exact, 'c')

% Features of the Graph
title('Fundamental and Hermonic series')
legend(' n = 1','sum of first two terms', 'sum of all terms', 'sawtooth')
xlabel('Time(ms)')
ylabel('Amplitude(cm)')








