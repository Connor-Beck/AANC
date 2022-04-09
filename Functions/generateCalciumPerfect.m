function [dF,Events,Cliques]=generateCalciumPerfect(dM,tM,nCliques)
    Noise=0; %deltaF noise level
    corupt=0.00; %Corruption index


    %Generate dF waveform with noise
    dF=Noise*zeros(tM,dM);

    %Add events and Calcium Event Generation
    Events=zeros(tM,dM);


    %Create cliques
    Cliques={};
    Cliques{nCliques}=NaN;
    for cliq=1:nCliques
        Cliques{cliq}=sort(randperm(dM,randi(ceil(0.3*dM))+2));
    end

    for t=8:tM-8
        if rand()>0.9
            cell=randi(dM);
            Events(t,cell)=1;
            [dF,cPk]=CalciumEvent(dF,t,cell,0);
            for cliq=1:nCliques
                if ismember(cell,Cliques{cliq})
                    cPk=0;
                    for cellE=1:length(Cliques{cliq})
                        if rand()>corupt %<- Corrupt (Skips event corrI % of the time)
                            Events(t,Cliques{cliq}(cellE))=1;
                            [dF,cPk]=CalciumEvent(dF,t,Cliques{cliq}(cellE),cPk);
                        end
                    end
                elseif rand()<corupt %<- Corrupt (Adds event corrI % of the time)
                    fC=randperm(dM,2); %<-Select another cell to fire
                    if fC(1)==cell
                        fID=fC(2);
                    else
                        fID=fC(1);
                    end
                    Events(t,fID)=1;
                    [dF,cPk]=CalciumEvent(dF,t,fID,cPk);
                end
            end
        end
    end

    function [dF,cPk]=CalciumEvent(dF,tme,n,cPk)

        %Determine Peak magnitude
        if cPk==0
            Pk=0.15;
            cPk=Pk; %<-Set for cliques
        else
            Pk=cPk; %<-Match Peak with other members of the same clique
        end

        %Create Peak waveform
        eL=6; %Event length
        eForm=zeros(2*eL,1);
        for tN=1:2*eL
            if tN<=eL
                eForm(tN)=Pk*tN/eL;
            else
                eForm(tN)=Pk*(tN-2*eL)/(2*eL);
            end
        end
        [~,c]=max(eForm);
        dF(tme-c:tme-c+2*eL-1,n)=eForm;
    end
end