function [t, y] = explicit_euler(a, b, h, y_0, f)
% EXPLICIT_EULER  Find an approximate solution.
%
%   [T, Y] = EXPLICIT_EULER(A, B, H, Y_0) finds an approximate solution to
%   the initial value problem via the explicit Euler method.
%
%   Explicit Euler method
%   y^{n+1} = y^n + h * f(t_n, y^n), y^0 = y(a)
%
%   Arguments:
%     A, B --- domain
%     H --- step size
%     Y_0 --- initial value
%     F --- function definition
%
arguments
  a double
  b double
  h double
  y_0 double
  f function_handle
end
fprintf('The explicit Euler method will be used to calculate\n');
fprintf('an approximate solution to the\n%s\n', func2str(f));
% Calculate the number of steps
N = floor((b - a) / h);
fprintf('for %d steps of size %f\n', N + 1, h);

t = zeros(N + 1, 1);
y = zeros(N + 1, 1);

t(1) = a;
y(1) = y_0;

for n = 1:N
    t(n + 1) = a + n * h;
    y(n + 1) = y(n) + h * f(t(n), y(n));
end
