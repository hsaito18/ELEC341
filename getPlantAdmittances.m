function Gp = getPlantAdmittances(Ym,Ye,Km, Ga)
    if ~exist('Ga','var')
        Ga = 1;
    end
    Gp = Ga*feedback(Ye*Km*Ym, Km);
end