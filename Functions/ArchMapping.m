function Archetypes=ArchMapping(XC)
    Rep=imbinarize(XC,0.025);
    [dM,nArch]=size(XC);
    for j=1:nArch
        count=1;
        CorrList=[];
        arc=find(Rep(:,j));
        Archetypes{j}=arc;
        Archetypes{j}=zeros(dM);
        for m=1:length(arc)
            for n=1:length(arc)
                Archetypes{j}(arc(m),arc(n))=1;
            end
        end
    end
end