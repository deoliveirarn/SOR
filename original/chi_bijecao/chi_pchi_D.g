chi:=function(g)
local pl, e1, e2, eg, rel, c, x, gen_g, s_gen_g, h, hp, D;

pl:=FreeProduct([g,g]);
e1:=Embedding(pl, 1);
e2:=Embedding(pl, 2); 
eg:=Difference(Elements(g), [One(g)]);
rel:=List(eg, x-> Comm(Image(e1,x),Image(e2,x)));

c:=FactorGroupFpGroupByRels(pl, rel);
gen_g:=GeneratorsOfGroup(g);
s_gen_g:=Size(gen_g);

h:=Subgroup(c,  List([1..s_gen_g], i ->  c.(i)         ));
hp:=Subgroup(c, List([1..s_gen_g], i -> c.(i+s_gen_g)  ));
D:=CommutatorSubgroup(h,hp);
return [c,D];
end;



p_chi:=function(g,p)
local gen_g, s_gen_g, cg, epi, c, h, hp, psi, D, L, R;

gen_g:=GeneratorsOfGroup(g);
s_gen_g:=Size(gen_g);
cg:=chi(g);
epi:= EpimorphismPGroup(cg,p);
c:=Image(epi);
h:=Subgroup(c,  List([1..s_gen_g], i -> Image(epi, cg.(i))          )     );
hp:=Subgroup(c, List([1..s_gen_g], i -> Image(epi, cg.(i+s_gen_g))  )     );
D:=CommutatorSubgroup(h,hp);
return [c, D];
end;


chi_perm :=  function(g)
local  sym, aut, eg, aut_perm, laux, alpha, x, lista, pl, e1, e2, lrel, sigma, i, rel;

g:=CyclicGroup(n);
sym:=SymmetricGroup( n-1 );
aut:= AutomorphismGroup(g);
eg:=Difference ( Elements( g ), [One(g)] );

laux:= List( aut, alpha-> List( eg, x -> x^alpha ) );
aut_perm:= Group( List( laux, lista -> PermListList(eg,lista) ) );

cd:=DoubleCosetRepsAndSizes(sym, aut_perm, aut_perm);
cd:=List( cd, lista -> lista[1] );

pl:=FreeProduct([g,g]);
e1:=Embedding(pl, 1);
e2:=Embedding(pl, 2); 
lrel:= List( cd, sigma -> List([1..Size(eg)], i -> Comm(Image(e1, eg[i]),Image(e2, eg[i^sigma])) ));
return List( lrel, rel ->  FactorGroupFpGroupByRels(pl, rel));


end;



              


