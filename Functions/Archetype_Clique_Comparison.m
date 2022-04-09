function CliqueDistribution=Archetype_Clique_Comparison(Cliques,Archetypes)
    nCliques=length(Cliques);
    nArch=length(Archetypes);
    CliqueDistribution={};
    for cliq=1:nCliques
        cliq_count=1;
        cliqList=[];
        for c1=1:length(Cliques{cliq})
            for c2=1:length(Cliques{cliq})
                if c1<c2
                    cliqList(cliq_count,:)=[Cliques{cliq}(c1),Cliques{cliq}(c2)];
                    cliq_count=cliq_count+1;
                end
            end
        end
        CliqueDistribution{cliq}=zeros(size(cliqList,1),10);
        for arch=1:nArch
            if ~isempty(Archetypes{arch})
                arc_count=1;
                arcList=[];
                for a1=1:length(Archetypes{arch})
                    for a2=1:length(Archetypes{arch})
                        if a1<a2
                            arcList(arc_count,:)=[Archetypes{arch}(a1),Archetypes{arch}(a2)];
                            arc_count=arc_count+1;
                        end
                    end
                end
                arcMap=Archetypes{arch};
                count=1;
                for m=1:size(cliqList,1)
                    if ismember(cliqList(m,:),arcList,'rows')
                        CliqueDistribution{cliq}(m,arch)=1;
                    end
                end
            end
        end
        subplot(1,nCliques,cliq); imagesc(CliqueDistribution{cliq}); title(num2str(cliq_count-1));
        ClR=sum(CliqueDistribution{cliq},2);
        ClRPercent(1,cliq)=size(ClR(ClR>0))/size(ClR);
        %colormap(flipud(gray));
        set(gca,'xtick',[]); set(gca,'ytick',[]);
    end
end