# Date: 2019-07-05
nu:=function(g)
local  gaux, pl, i1, i2, rels, eg, x, y, z;


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

return FactorGroupFpGroupByRels(pl, rels);
end;

