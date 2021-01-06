function [rho_F_1,theta_F_1] = RANSAC_2(rho,theta,parametres)

residu_min = Inf; 

for k = 1:parametres(3)
   indices_points = randperm(length(rho),2)
   rho_aleatoire = rho(indices_points);
   %rho_aleatoire = [rho(indices_points(1)), rho (indices_points(2))];
   %theta_aleatoire = [theta(indices_points(1)), theta(indices_points(2))];
   theta_aleatoire = theta(indices_points);
   
   [rho_estime,theta_estime, residu] = estimation_F(rho_aleatoire,theta_aleatoire);
   
   
   residu = abs(rho - rho_estime.*cos(theta - theta_estime));
   
   residu_conforme = residu(find(residu < parametres(1)));
   
   proportion_conforme = length(residu_conforme)/length(rho);
   
   
   if proportion_conforme > parametres(2)
       
       [rho_F,theta_F, residu_F] = estimation_F(rho(find(residu < parametres(1))),theta(find(residu < parametres(1))));
       
       if residu_F < residu_min
           
           residu_min = residu_F;
           rho_F_1 = rho_F;
           theta_F_1 = theta_F;
       end
   end
   
   
end 