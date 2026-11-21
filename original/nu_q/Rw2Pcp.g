# Date: 2015-08-30 (last change 2015-08-31)
### 20150830 transform a rewriting system, from KBMAG, into a PcpGroup,
### by setting values to a collector, using the polycyclic package.

Rw2Pcp:=function(rewriting_g_gast)
local R, Rw, n, mF, gen_mF, gen_Fg, i, Fg, rel_g, coll_g, rel_order_and_word, rel_order_power, j, laux;


Rw:=rewriting_g_gast;
mF:=FreeStructureOfRewritingSystem(Rw); 
gen_mF:=GeneratorsOfMonoid(mF);



gen_Fg:=
	( 
	List( [1..Size(gen_mF)/2], i -> String(gen_mF[2*i-1]) )
	);
Fg:=FreeGroup(gen_Fg);
gen_Fg:=GeneratorsOfGroup(Fg);
AssignGeneratorVariables(Fg);
rel_g:=[];
for i in Rules(Rw) do 
	Add
	( 
	rel_g,
	[ InternalWordToExternalWordOfRewritingSystem(Rw, i[1]), InternalWordToExternalWordOfRewritingSystem(Rw, i[2]) ]
	); 
od;
rel_g:=List(rel_g, i -> [String(i[1]), String(i[2])]);

rel_g:=List
	( rel_g , i -> 
		[
		ReplacedString(i[1], "<identity ...>", "g_1^0" )
		, 
		ReplacedString(i[2], "<identity ...>", "g_1^0" )
		]
	);

rel_g:=List(rel_g, i -> [EvalString(i[1]), EvalString(i[2])]);
rel_g:=Filtered(rel_g, i -> i <> [One(Fg), One(Fg)]);

coll_g:=FromTheLeftCollector( Size(GeneratorsOfGroup(Fg) ) );

rel_order_power:=List(rel_g, i -> [ ExtRepOfObj(i[1]), ExtRepOfObj(i[2])] ) ;
rel_order_power:=Filtered(rel_order_power, i -> Size(i[1])=2 and i[1][2] > 0);
for i in rel_order_power do 	
	SetRelativeOrder( coll_g, i[1][1], i[1][2] );
od;

for i in rel_order_power do 
	SetPower( coll_g, i[1][1], i[2] );
od;


laux:=[];
for i in [1..Size(gen_mF)/2] do
	for j  in [i+1..Size(gen_mF)/2] do
		Add(laux, [j,i, String(ReducedForm(Rw, gen_mF[2*i]*gen_mF[2*j-1]*gen_mF[2*i-1] ) ) ] );
	od;
od;
laux:=List(laux, i -> [i[1],i[2],ExtRepOfObj(EvalString(i[3])) ]);
for i in laux do
	SetConjugate( coll_g, i[1], i[2], i[3] );
od;

laux:=[];
for i in [1..Size(gen_mF)/2] do
	for j  in [i+1..Size(gen_mF)/2] do
		Add(laux, [-j,i, String(ReducedForm(Rw, gen_mF[2*i]*gen_mF[2*j]*gen_mF[2*i-1] ) ) ] );
	od;
od;
laux:=List(laux, i -> [i[1],i[2],ExtRepOfObj(EvalString(i[3])) ]);
for i in laux do
	SetConjugate( coll_g, i[1], i[2], i[3] );
od;

laux:=[];
for i in [1..Size(gen_mF)/2] do
	for j  in [i+1..Size(gen_mF)/2] do
		Add(laux, [j,-i, String(ReducedForm(Rw, gen_mF[2*i-1]*gen_mF[2*j-1]*gen_mF[2*i] ) ) ] );
	od;
od;
laux:=List(laux, i -> [i[1],i[2],ExtRepOfObj(EvalString(i[3])) ]);
for i in laux do
	SetConjugate( coll_g, i[1], i[2], i[3] );
od;

laux:=[];
for i in [1..Size(gen_mF)/2] do
	for j  in [i+1..Size(gen_mF)/2] do
		Add(laux, [-j,i, String(ReducedForm(Rw, gen_mF[2*i]*gen_mF[2*j]*gen_mF[2*i-1] ) ) ] );
	od;
od;
laux:=List(laux, i -> [i[1],i[2],ExtRepOfObj(EvalString(i[3])) ]);
for i in laux do
	SetConjugate( coll_g, i[1], i[2], i[3] );
od;



return coll_g;
end;
	









