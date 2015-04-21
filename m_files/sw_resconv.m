function M = sw_resconv(M,x,dx)
% Convolute Gaussian with variable width along the first dimension of a matrix
%
% M = SW_RESCONV(M,x,dx)
%
% Input:
%
% M     Arbitrary matrix with dimensions of (m1,m2).
% x     Column vector of coordinates along the first dimension of the
%       matrix.
% dx    Standard deviation as a function of dx. Either a function handle
%       with a header:
%           stdG = dx(xVal)
%       or a vector of polynomial coefficients that produces the right
%       standard deviation. In this case in the function the following line
%       will be executed:
%           stdG = polyval(dx,xVal)
%
% Output:
%
% M     Matrix with same dimensions as the input storing the convoluted
%       data.
%
% See also SW_RES.
%

Mtemp = M * 0;

for ii = 1:numel(x)
    % standard deviation of the energy resolution Gaussian
    if isa(dx,'function_handle')
        stdG = dx(x(ii))/2.35482;
    else
        stdG = polyval(dx,x(ii))/2.35482;
    end
    
    % Gaussian with intensity normalised to 1, centered on E(ii)
    fG = exp(-((x-x(ii))/stdG).^2/2);
    fG = fG/sum(fG);
    
    Mtemp = Mtemp + fG * M(ii,:);
    
end

M = Mtemp;

end