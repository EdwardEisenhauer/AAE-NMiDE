function [t, y] = implicit_euler(a, b, h, y_0, f)
% IMPLICIT_EULER  Find an approximate solution.
%
%   [T, Y] = IMPLICIT_EULER(A, B, H, Y_0) finds an approximate solution to
%   the initial value problem via the implicit Euler method.
%
%   Implicit Euler method
%   y^{n+1} = y^n + h * f(t_{n+1}, y^{n+1}), y^0 = y(a)
%
%   The equation above has y^{n+1} on both sides. To solve the algebraic
%   equation the Symbolic Math Toolbox is used.
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
fprintf('The implicit Euler method will be used to calculate\n');
fprintf('an approximate solution to the\n%s\n', func2str(f));
% Calculate the number of steps
N = floor((b - a) / h);
fprintf('for %d steps of size %f\n', N + 1, h);

t = zeros(N + 1, 1);
y = zeros(N + 1, 1);

t(1) = a;
y(1) = y_0;

syms h_sym t_next y_n y_next
y_next_solved = solve(y_next == y_n + h_sym * f(t_next, y_next), y_next);
fprintf("The next element's value will be calculated from:\n");
fprintf("y^{n+1} = %s\n", y_next_solved);
h_sym = h;

for n = 1:N
    t(n + 1) = a + n * h;
    t_next = t(n + 1);
    y_n = y(n);
    subs(y_next_solved);
    y(n + 1) = subs(y_next_solved);
end
