function decision = decision(signal, M, spacing, fig)
%DECISION D�tecteur � seuils
%   signal : Signal � traiter
%   M : Nombre de symboles
%   spacing : Espace entre chaque symboles
%   fig : Poign�e de la figure sur laquelle afficher le r�sultat
    if ~exist('fig', 'var')
        fig = -1;
    end
    if(fig == 0)
        figure();
        fig = gcf;
        fig = fig.Number;
    end

    M_re = 2 * round(log2(M)/2);
    M_im = 2 * floor(log2(M)/2);
    mapping_re = generateMapping(M_re, spacing);
    mapping_im = generateMapping(M_im, spacing);
    seuil_re = (repmat(mapping_re, 2, 1) - [spacing/2; -spacing/2])' * max(real(signal))/(max(mapping_re));
    seuil_im = (repmat(mapping_im, 2, 1) - [spacing/2; -spacing/2])' * max(real(signal))/(max(mapping_im));
    
    decision_re = mapping_re(log2(bi2de((real(signal) > seuil_re(:, 1) & real(signal) <= seuil_re(:, 2))')) + 1);
    decision_im = mapping_im(log2(bi2de((imag(signal) > seuil_im(:, 1) & imag(signal) <= seuil_im(:, 2))')) + 1);
    
    decision = decision_re + 1i * decision_im;
    
    if(fig > 0)
        figure(fig)
        ratio(1000, 500);
        hold on;
        plot(1:length(decision), real(decision), 'b+'); 
        plot(1:length(decision), imag(decision), 'cx');
        ylim([min(min(real(decision), imag(decision)))-1 max(max(real(decision), imag(decision)))+1])
        title('Symboles décidés');
        xlabel('Temps');
        ylabel('Tension');
        legend('Partie réelle', 'Partie imaginaire');
    end
end