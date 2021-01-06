function [dsp] = perio(x, mod)
    Fe  = 10000; 
    dsp = (1/length(x)).*abs(fft(x).*fft(x));

    figure();
    plot(linspace(0,Fe,length(dsp)), dsp);
    title("Périodogramme " + mod);
    xlabel("fréquence en Hertz");
    ylabel("Périodogramme");
end