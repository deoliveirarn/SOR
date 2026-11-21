# p-groups only
ching:=function(g,n)
local pl, emb, eg, rel, i, j, k , l, x, y, z, c, pi, p, epi, c1;

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
c:=FactorGroupFpGroupByRels(pl, rel);
pi:=GroupHomomorphismByImagesNC(pl,c);
p:=FactorsInt( Size(g) )[1];
epi:= EpimorphismPGroup(c,p);
c1:=Image(epi );
emb:=List(emb, x -> (x*pi)*epi);	

return rec( imersao:=emb, cng:=c1);
end;


# 3 copias somente
DL := function(cng)

	local e1, e2,e3, G, G1, G2, G3, D12, D13, D23, g, L12, L13, L23;
	e1 := cng.imersao[1];
	e2 := cng.imersao[2];
	e3 := cng.imersao[3];
	
	G  := Source(e1);
	G1 := Image(e1);
	G2 := Image(e2);
	G3 := Image(e3);

	D12 := CommutatorSubgroup(G1, G2);
	D13 := CommutatorSubgroup(G1, G3);
	D23 := CommutatorSubgroup(G2, G3);

	

	L12 := Group( List( G, g -> Image(e1,g)^-1 * Image(e2,g)) );

	L13 := Group( List( G, g -> Image(e1,g)^-1 * Image(e3,g)) );

	L23 := Group( List( G, g -> Image(e2,g)^-1 * Image(e3,g)) );

	return rec(
		D12 := D12,
		D13 := D13,
		D23 := D23,
		L12 := L12,
		L13 := L13,
		L23 := L23
	);

end;


              


