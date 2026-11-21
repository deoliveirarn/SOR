chi_perm :=  function(n)
local g, sym, aut, eg, aut_perm, laux, alpha, x, lista, pl, e1, e2, lrel, sigma, i, rel;

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
