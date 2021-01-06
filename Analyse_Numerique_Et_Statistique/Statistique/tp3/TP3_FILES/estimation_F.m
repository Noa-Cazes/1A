function [rho_F,theta_F, residu] = estimation_F(rho,theta)
    % X = [x_F;y_F]
    A = [cos(theta), sin(theta)];
    B = rho;
    X = pinv(A)*B;
    rho_F = sqrt(X(1)^2 + X(2)^2);
    theta_F = atan2(X(2),X(1));
    
    residu = mean(abs(rho - X(1)*cos(theta-X(2))))

end
