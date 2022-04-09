function barcode=generateBarcode(dM,Cliques)

nCliques=length(Cliques);

for cA=1:dM
    count=1;
    for cNxt=1:dM
        for j=1:nCliques
            if any(ismember(Cliques{1,j},cA)) && any(ismember(Cliques{1,j},cNxt)) 
                barcode{cA}(1,count)=0;
            else
                barcode{cA}(1,count)=1;
            end
            barcode{dM+1}(1,count)=cNxt;
            count=count+1;
            
        end
    end
end