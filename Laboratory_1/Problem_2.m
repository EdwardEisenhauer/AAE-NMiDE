% Numerical Methods in Differential Equations
% Laboratory 1
% Problem 2

clear;
clc;

% We have an initial value problem:
%  y' = -100y + 100cos(t) - sin(t)
f = @(t, y) - 100. * y + 100. * cos(t) - sin(t);

% for t in [0, pi]
a = 0.;
b = pi;

% for y(0) = 1
y_0 = 1.;

% which the exact solution is:
yd = @(t) cos(t);

% Define the flow parameters
n = 5; % Number of step divisions
h_init = 0.5; % Initial step size
% Define the variable vectors
h = zeros(n, 1); % Step size
e_explicit = zeros(n, 1); % Error of approximation of the explicit Euler method
e_implicit = zeros(n, 1); % Error of approximation of the implicit Euler method
e_midpoint = zeros(n, 1); % Error of approximation of the midpoint method

for i = 1:n
    % Calculate the step size
    h(i) = h_init/2^(i - 1);
    % Calculate the approximate solution with the explicit Euler method
    [t, y_explicit] = explicit_euler(a, b, h(i), y_0, f);
    % Calculate the approximate solution with the explicit Euler method
    [t, y_implicit] = implicit_euler(a, b, h(i), y_0, f);
    % Calculate the approximate solution with the midpoint method
    [t, y_midpoint] = midpoint(a, b, h(i), y_0, f);
    % Calculate the exact solution
    y_exact = yd(t);
    % Calculate the errors of approximation
    e_explicit(i) = approximation_error(y_explicit, y_exact);
    e_implicit(i) = approximation_error(y_implicit, y_exact);
    e_midpoint(i) = approximation_error(y_midpoint, y_exact);
    if i > 1
        % Calculate the convergence rate
        r_explicit = e_explicit(i - 1) / e_explicit(i);
        r_midpoint = e_midpoint(i - 1) / e_midpoint(i);
        alpha_explicit(i) = log2(r_explicit);
        log2(r_midpoint); 
    end
    % Plot the approximate and exact solutions
    figure("Name", sprintf("Approximate and exact solutions for h = %f", h(i)))
    plot(t, y_explicit, t, y_midpoint, t, y_exact)
    legend( ...
       sprintf("Explicit Euler method e = %f", e_explicit(i)), ...
       sprintf("Midpoint method e = %f", e_midpoint(i)), ...
       "Exact solution" ...
    )
end

figure("Name", "Error of approximation in function of the step size")
semilogx(h, e_explicit, "o--", "DisplayName", sprintf("Explicit Euler method e_n = %f", e_explicit(end)))
hold on
semilogx(h, e_implicit, "o--", "DisplayName", sprintf("Implicit Euler method e_n = %f", e_implicit(end)))
hold on
semilogx(h, e_midpoint, "o--", "DisplayName", sprintf("Midpoint method e_n = %f", e_midpoint(end)))
legend

figure("Name", "")
semilogx(h, alpha_explicit, "o--")
