q:=2;
#g:=AllSmallGroups(Size,2^2,IsElementaryAbelian,true);
g:=SymmetricGroup(3); eg:=Elements(g);



niq:= function(g,q)
local eg, f, pl, i1, i2, i3, s1, s2, r1, r2, r3, r4, r5, r6, niq, theta;

eg:=Elements(g);
f:=FreeGroup(Size(eg));
pl:=FreeProduct([g,g,f]);
i1:=function(x); return Image(Embedding(pl,1), x); end;
i2:=function(x); return Image(Embedding(pl,2), x); end;
i3:=function(x); return Image(Embedding(pl,3), f.(Position(eg,x)));end;
################################################################################################
################################################################################################ Relações do tipo S1
s1:=[];

for x in eg do 
	for y in eg do
		for z in eg do
			Add( s1, 
			Comm(i1(x^z),i2(y^z)) / Comm(i1(x),i2(y))^i1(z)  
			);
		od;
	od;
od; 

################################################################################################
################################################################################################ Relações do tipo S2
s2:=[];

for x in eg do 
	for y in eg do
		for z in eg do
			Add( s2, 
			Comm(i1(x^z),i2(y^z)) / Comm(i1(x),i2(y))^i2(z)  
			);
		od;
	od;
od; 

################################################################################################
################################################################################################ Relações do tipo R1
r1:=[];

for x in eg do
	for y in eg do
		Add( r1, 
		i3(x)^i1(y)/i3(x^y) 
		);
	od;
od;

################################################################################################
################################################################################################ Relações do tipo R2
r2:=[];

for x in eg do
	for y in eg do
		Add( r1, 
		i3(x)^i2(y)/i3(x^y) 
		);
	od;
od;

################################################################################################
################################################################################################ Relações do tipo R3
r3:=[];

for x in eg do
	for y in eg do
		for z in eg do
			Add(r3,
			Comm(i1(x),i2(y))^i3(z)/Comm(i1(x^(z^q)),i2(y^(z^q)))
			);
		od;
	od;
od;

################################################################################################
################################################################################################ Relações do tipo R4
r4:=[];

for x in eg do
	for y in eg do
		l:= List( [1..(q-1)], i -> Comm( i1(x) , i2(y^-i)  )^(i1(x)^(q-1-i)) ) ;
		Add(r4, i3(x)*Product(l)*i3(y)/i3(x*y));
	od;
od;

################################################################################################
################################################################################################ Relações do tipo R5
r5:=[];

for x in eg do
	for y in eg do
		Add( r5,
		Comm(i3(x),i3(y)) / Comm(i1(x^q),i2(y^q))  
		);
	od;
od;

################################################################################################
################################################################################################ Relações do tipo R6
r6:=[];

for x in eg do
	for y in eg do
		Add( r6,
		i3( Comm(x,y) ) / Comm(i1(x),i2(y))^q
		);
	od;
od;

Relations:=Concatenation(s1, s2, r1, r2, r3, r4, r5, r6 );

niq:=FactorGroupFpGroupByRels(pl,Relations);

return niq;


#theta:= GroupHomomorphismByImages(pl,niq,GeneratorsOfGroup(pl),GeneratorsOfGroup(niq));

#G:=Image(  theta,  Image(Embedding(pl,1))   ); genG:=GeneratorsOfGroup(G);
#Gf:=Image(  theta,  Image(Embedding(pl,2))   ); genGf:=GeneratorsOfGroup(Gf);
#K:=Image(  theta,  Image(Embedding(pl,3))   ); genK:=GeneratorsOfGroup(K);

#CGGf:=CommutatorSubgroup(G,Gf); genCGGf:=GeneratorsOfGroup(CGGf);

#qt:= Group(  Concatenation(genCGGf , genK)  );







	


	























		

