# Date: 2026-03-12
chin:=function(g,n)
local pl, emb, eg, rel, i, j, k , l, x, y, z, c, pi, imersao, cn, grupo;

pl:=FreeProduct(List([1..n], x -> g));
emb:= List([1..n], x -> Embedding(pl, x)); 
eg:=Difference(Elements(g), [One(g)]);
######################
######################
######################
######################  Relacoes do tipo [h^x, h^x*psi] 
rel:=[];

for i in [1..n] do
	for j in [i+1..n] do
		for x in eg do
			Add(rel, Iterated( [Image(emb[i], x), Image(emb[j], x)], Comm ));
		od;
	od;
od;
		

######################
######################
######################
######################  Relacoes do tipo [D,L] 

for i in [1..n] do 
	for j in [i+1..n] do 
		for k in [1..n] do
			for l in [k+1..n] do
				for x in eg do
					for y in eg do
						for z in eg do
							Add(rel,  Iterated( [Image(emb[i], x), Image(emb[j], y), Image(emb[k], z)^-1*Image(emb[l], z)], Comm)  );
						od;
					od;
				od;
			od;
		od;
	od;
od;


c:=FactorGroupFpGroupByRels(pl, rel);
pi:=GroupHomomorphismByImagesNC(pl,c);
emb:=List(emb, x -> x*pi);



return rec( imersao:=emb,  cn:=c, grupo:=g);
end;







              


