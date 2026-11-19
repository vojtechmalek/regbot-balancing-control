function [G_ol, Kp, tau_i, tau_d] = Controller(G, N_i, alpha, gamma_m, shift)
    if shift > 0 && alpha ~= 0
        phaseG=rad2deg(deg2rad(gamma_m)-asin((1-alpha)/(1+alpha))-pi+atan(1/N_i));
        disp("Crossover frequency at: "+phaseG+"° phase.")
        [mag,phase,w]=bode(G);
        phase=squeeze(phase-shift); w=squeeze(w);
        omega_c=interp1(phase,w,phaseG,'linear');
        disp("Please check if omega_c of "+omega_c+" rad/s is reasonable...")
        tau_i=N_i*(1/omega_c);
        tau_d=(1)/(omega_c*sqrt(alpha));
        C_pi=tf([tau_i,1],[tau_i,0]);
        C_D=tf([tau_d,1],[alpha*tau_d,1]);
        Kp=1/(abs(freqresp((G*C_D*C_pi),1j*omega_c)));
        G_ol=minreal(G*C_D*C_pi*Kp);
    elseif shift > 0 && alpha == 0
        phaseG=rad2deg(deg2rad(gamma_m)-pi+atan(1/N_i));
        disp("Crossover frequency at: "+phaseG+"° phase.")
        [mag,phase,w]=bode(G);
        phase=squeeze(phase-shift); w=squeeze(w);
        omega_c=interp1(phase,w,phaseG,'linear');
        disp("Please check if omega_c of "+omega_c+" rad/s is reasonable...")
        tau_i=N_i*(1/omega_c);
        C_pi=tf([tau_i,1],[tau_i,0]);
        Kp=1/(abs(freqresp((G*C_pi),1j*omega_c)));
        G_ol=minreal(G*C_pi*Kp);
        tau_d = 0;
    elseif alpha ~= 0
        phaseG=rad2deg(deg2rad(gamma_m)-asin((1-alpha)/(1+alpha))-pi+atan(1/N_i));
        disp("Crossover frequency at: "+phaseG+"° phase.")
        [mag,phase,w]=bode(G);
        phase=squeeze(phase); w=squeeze(w);
        omega_c=interp1(phase,w,phaseG,'linear');
        disp("Please check if omega_c of "+omega_c+" rad/s is reasonable...")
        tau_i=N_i*(1/omega_c);
        tau_d=(1)/(omega_c*sqrt(alpha));
        C_pi=tf([tau_i,1],[tau_i,0]);
        C_D=tf([tau_d,1],[alpha*tau_d,1]);
        Kp=1/(abs(freqresp((G*C_D*C_pi),1j*omega_c)));
        G_ol=minreal(G*C_D*C_pi*Kp);
    elseif alpha == 0
        phaseG=rad2deg(deg2rad(gamma_m)-pi+atan(1/N_i));
        disp("Crossover frequency at: "+phaseG+"° phase.")
        [mag,phase,w]=bode(G);
        phase=squeeze(phase); w=squeeze(w);
        omega_c=interp1(phase,w,phaseG,'linear');
        disp("Please check if omega_c of "+omega_c+" rad/s is reasonable...")
        tau_i=N_i*(1/omega_c);
        C_pi=tf([tau_i,1],[tau_i,0]);
        Kp=1/(abs(freqresp((G*C_pi),1j*omega_c)));
        G_ol=minreal(G*C_pi*Kp);
        tau_d = 0;
    end
end