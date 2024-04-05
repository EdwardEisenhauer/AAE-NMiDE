function [t, y] = midpoint(a, b, h, y_0, f)
% MIDPOINT  Find an approximate solution.
%
%   [T, Y] = MIDPOINT(A, B, H, Y_0) finds an approximate solution to
%   the initial value problem via the midpoint method.
%
%   Midpoint method
%   y^{n+1} = y^{n-1} + 2 * h * (f(t_n, y^n),
%   y^0 = y(a), y^1 = y(a) + h * f(a, y(a))
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
fprintf('The midpoint method will be used to calculate\n');
fprintf('an approximate solution to the\n%s\n', func2str(f));
% Calculate the number of steps
N = floor((b - a) / h);
fprintf('for %d steps of size %f\n', N + 1, h);

t = zeros(N + 1, 1);
y = zeros(N + 1, 1);

t(1) = a;
y(1) = y_0;
t(2) = a + h;
y(2) = y(1) + h * f(a, y(1));

for n = 2:N
    t(n + 1) = a + n * h;
    y(n + 1) = y(n - 1) + 2 * h * f(t(n), y(n));
end
