function out = norm1tanh_prime(x)
%      x = tanh(x)./norm(tanh(x));
%      nrm = norm(x);
%      y = (x-x.^3);
% %     
%      out = diag(1-x.^2)./nrm - y*x'./nrm^3;

    tx = tanh(x);
    nm = norm(tx);
    p = (eye(size(x,1))./nm) - (tx*tx')./nm^3;
    out = diag(1-tx.^2)*p;

%     tx = tanh(x);
%     out = diag(1-tx.^2);
end