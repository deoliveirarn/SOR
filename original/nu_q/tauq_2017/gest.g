# Date: 2017-06-07
gest:=function(g,q)
local epi_gast, gast, gen_gast, rel_gqast, elto, gqast, laux, epi, gen_gqast, gen_gest, i, j, gest;

## Abaixo o calculo do homomorfismo,  epi : G_q^ast --> G
epi_gast:= SchurExtensionEpimorphism(g);
gast:=Source(epi_gast);
gen_gast:=GeneratorsOfGroup(gast);
rel_gqast:=Filtered(gen_gast, elto -> Image(epi_gast, elto)=One(g));
rel_gqast:=List(rel_gqast, elto -> elto^q);
rel_gqast:=Filtered(rel_gqast, elto -> elto <> elto^0);
gqast:=FactorGroup( gast, Group(rel_gqast));
laux:=ShallowCopy( GeneratorsOfGroup(g) );
for elto in [Size(laux)+1..Size(GeneratorsOfGroup(gqast))] do
	Add(laux, One(g));
od;
epi:=GroupHomomorphismByImages(gqast, g, GeneratorsOfGroup(gqast), laux);

## Abaixo o calculo do Pcp-Group, G ^_q G
gen_gqast:=GeneratorsOfGroup(gqast);
gen_gest:=[];

for i  in [1..Size(gen_gqast)] do
	for j in [i+1..Size(gen_gqast)] do 
		Add(gen_gest, Comm(gen_gqast[j], gen_gqast[i]));
	od;
od; 
for i  in [1..Size(gen_gqast)] do
	Add(gen_gest, gen_gqast[i]^q);
od;
gen_gest:=Filtered(gen_gest, i -> i <> i^0);
gest:=Subgroup(gqast, gen_gest);
#gest:=PcpGroupByCollector(Collector(gest));

# retorna a lista [epi : G_q^ast --> G, G ^_q G], onde todos os grupos sao Pcp-Groups.
return [epi, gest]; 
end;

