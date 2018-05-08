%Define all the instructions

function assembler(ins)
        global L;
        global T;
        global C1;
        global C2;
        global C3;
        global E;
        global DRAM;
        global AC;
        global MAR;
        global Z;
        global i;
        if strcmp(ins,'CLAC') == 1
            AC = 0;
        elseif strcmp(ins,'LDL') == 1
            AC = 512;
        elseif strcmp(ins,'MVACMAR')  == 1
            MAR = AC;
        elseif strcmp(ins,'MVACC1') == 1
            C1 = AC;
        elseif strcmp(ins,'MVACC2') == 1
            C2 = AC;
        elseif strcmp(ins,'MVACC3') == 1
            C3 = AC;
        elseif strcmp(ins,'MVACL') == 1
            L = AC;
        elseif strcmp(ins,'MVACT') == 1
            T = AC;
        elseif strcmp(ins,'MVACE') == 1
            E = AC;
        elseif strcmp(ins,'LDAC') == 1
            AC = DRAM(MAR);
        elseif strcmp(ins,'INAC') == 1
            AC = AC + 1;
        elseif strcmp(ins,'DEAC') == 1
            AC = AC - 1;
        elseif strcmp(ins,'MVL') == 1
            AC = L;
        elseif strcmp(ins,'MVC1') == 1
            AC = C1;
        elseif strcmp(ins,'MVC2') == 1
            AC = C2;
        elseif strcmp(ins,'MVC3') == 1
            AC = C3;
        elseif strcmp(ins,'MVT') == 1
            AC = T;
        elseif strcmp(ins,'ADDT') == 1
            AC = AC + T;
        elseif strcmp(ins,'ADDL') == 1
            AC = AC + L;
        elseif strcmp(ins,'SUBL') == 1
            AC = AC - L;
            if (AC == 0) 
                Z = 1;
            else 
                Z = 0;
            end
        elseif strcmp(ins,'SUBE') == 1
            AC = AC - E;
            if (AC == 0) 
                Z = 1;
            else 
                Z = 0;
            end
        elseif strcmp(ins,'DIV') == 1
            AC = AC/16;
        elseif strcmp(ins,'MUL2') == 1
            AC = AC*2;
        elseif strcmp(ins,'MUL4') == 1
            AC = AC*4;
        elseif strcmp(ins,'MUL512') == 1
            AC = AC*512;
        elseif strcmp(ins,'STAC') == 1
            DRAM(MAR) = AC;
        elseif strcmp(ins,'JMPZ') == 1
            if Z == 1;
                i = 111;
            end
        elseif strcmp(ins,'JMNZ') == 1
            if Z == 0
                i = 17;
            end
        elseif strcmp(ins,'JUMP') == 1
            i = 17;
    end
end

    
                
                
            
        
            
