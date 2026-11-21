nu:=function(g)
local  pl, i1, i2, rels, eg, x, y, z, n, phi, e1, e2;


pl:=FreeProduct(g, g);
i1:=Embedding(pl,1);
i2:=Embedding(pl,2);

rels:=[];
eg:=Difference(Elements(g), [One(g)]);

for x in eg do
	for y in eg do 
		for z in eg do 
			Add(rels, Comm(Image(i1, x),Image(i2, y))^Image(i1, z) / Comm(Image(i1, x^z), Image(i2, y^z) ) );
			Add(rels, Comm(Image(i1, x),Image(i2, y))^Image(i1, z) / Comm(Image(i1, x), Image(i2, y) )^Image(i2, z) );
		od;
	od;
od;

n:=FactorGroupFpGroupByRels(pl, rels);
phi:=GroupHomomorphismByImages( pl, n, GeneratorsOfGroup(pl), GeneratorsOfGroup(n));

e1:=function(x)
return Image( phi, Image(i1,x));
end;

e2:=function(y)
return Image( phi, Image(i2,y));
end;


e1:=GroupHomomorphismByImages(g, n, GeneratorsOfGroup(g),  List(GeneratorsOfGroup(g), x->e1(x) ));
e2:=GroupHomomorphismByImages(g, n, GeneratorsOfGroup(g),  List(GeneratorsOfGroup(g), y->e2(y) ));



return [n, e1, e2];
end;

