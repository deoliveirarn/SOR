#20150830 transforma um Pcp presentation em string


Spres:=function(PcpGroup)
local gen, sgen, coll, laux, i, F, rel_order, rel, j;

gen:=GeneratorsOfGroup(PcpGroup);
sgen:=Size(gen);

coll:=Collector(PcpGroup);
laux:=[];
for i in [1..sgen] do
	Add(laux, Concatenation("g_", String(i)));
od;
F:=FreeGroup(laux);
AssignGeneratorVariables(F);
rel_order:=RelativeOrders(coll);
rel:=[];

for i in [1..sgen] do
	if rel_order[i] <> 0 then
		Add
		(
		rel,
		[
		ObjByExtRep(FamilyObj( g_1 ) , [i,rel_order[i]] ),
		ObjByExtRep(FamilyObj( g_1 ) , GetPower(coll, i) )
		]
		);
	fi;
od;

for i in [1..sgen] do
	for j in [i+1..sgen] do
		if rel_order[i]<>0 then
			Add
			(
			rel,
			[
			ObjByExtRep(FamilyObj( g_1 ) , [i,-1,j,1,i,1] ),
			ObjByExtRep(FamilyObj( g_1 ) , GetConjugate( coll, j, i ) )
			]
			);
		elif rel_order[i]=0 and Comm(gen[i],gen[j])<>gen[i]^0 then
			Add
			(
			rel,
			[
			ObjByExtRep(FamilyObj( g_1 ) , [i,-1,j,1,i,1] ),
			ObjByExtRep(FamilyObj( g_1 ) , GetConjugate( coll, j, i ) )
			]
			);
			Add
			(
			rel,
			[
			ObjByExtRep(FamilyObj( g_1 ) , [i,1,j,1,i,-1] ),
			ObjByExtRep(FamilyObj( g_1 ) , GetConjugate( coll, j, -i ) )
			]
			);
		elif rel_order[i]=0 and Comm(gen[i],gen[j])=gen[i]^0 then
			Add
			(
			rel,
			[
			ObjByExtRep(FamilyObj( g_1 ) , [i,-1,j,1,i,1] ),
			ObjByExtRep(FamilyObj( g_1 ) , GetConjugate( coll, j, i ) )
			]
			);
		fi;
	od;
od;

rel:=List(rel, i -> [String(i[1]), String(i[2])]);
rel:=List(rel, i -> [ReplacedString(i[1], "<identity ...>", "g_1^0"),  ReplacedString(i[2], "<identity ...>", "g_1^0")]);

return rel;
  
end;











		
