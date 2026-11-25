# nu(G): os dois metodos (Rocco 1994 pelo produto livre; Polycyclic) conferidos
# entre si, contra NonAbelianTensorSquare e contra as relacoes de Rocco (2026-11-21).
gap> START_TEST("nu.tst");
gap> LoadPackage("SOR", false);;

# relacoes de Rocco com x, y em todo G e z nos geradores; mergulhos injetivos
gap> Confere := function( G, r )
>   local e1, e2, x, y, z, c;
>   e1 := r.emb[1];  e2 := r.emb[2];
>   if not ( IsInjective( e1 ) and IsInjective( e2 ) ) then return false; fi;
>   for x in G do for y in G do for z in GeneratorsOfGroup( G ) do
>     c := Comm( Image( e1, x ), Image( e2, y ) );
>     if c^Image( e1, z ) <> Comm( Image( e1, x^z ), Image( e2, y^z ) ) or
>        c^Image( e1, z ) <> c^Image( e2, z ) then return false; fi;
>   od; od; od;
>   return true;
> end;;
gap> Tensor := r -> Size( CommutatorSubgroup( Image( r.emb[1] ), Image( r.emb[2] ) ) );;
gap> TensorPolycyclic := G -> Size( NonAbelianTensorSquare(
>        Image( IsomorphismPcpGroup( Image( IsomorphismPcGroup( G ) ) ) ) ) );;

# p-grupos: os dois metodos dao a mesma ordem
gap> ForAll( [ [8,3], [8,4], [16,3], [27,3], [32,6], [32,49] ], function( id )
>      local G, a, b;
>      G := SmallGroup( id );  a := RS_NuRocco1994( G );  b := RS_NuPolycyclic( G );
>      return Size( a.group ) = Size( b.group ) and Tensor( a ) = Tensor( b )
>             and Tensor( a ) = TensorPolycyclic( G );
>    end );
true
gap> ForAll( [ [8,3], [8,4], [16,3] ], function( id )
>      local G;  G := SmallGroup( id );  return Confere( G, RS_NuRocco1994( G ) );
>    end );
true

# soluveis nao nilpotentes (Polycyclic)
gap> List( [ [6,1], [12,3], [24,12], [24,3] ], id -> Size( RoccoNuGroup( SmallGroup( id ) ) ) );
[ 216, 3456, 27648, 13824 ]
gap> ForAll( [ [6,1], [12,3], [24,12] ], function( id )
>      local G;  G := SmallGroup( id );  return Confere( G, RS_NuPolycyclic( G ) );
>    end );
true

# todas as representacoes do mesmo grupo
gap> G := SmallGroup( 24, 12 );;
gap> Set( [ G, Image( IsomorphismPermGroup( G ) ), Image( IsomorphismFpGroup( G ) ),
>           Image( IsomorphismPcpGroup( G ) ) ],
>         K -> [ Size( RoccoNuGroup( K ) ),
>                Size( CommutatorSubgroup( Image( Embedding( RoccoNuGroup( K ), 1 ) ),
>                                          Image( Embedding( RoccoNuGroup( K ), 2 ) ) ) ) ] );
[ [ 27648, 48 ] ]
gap> Size( RoccoNuGroup( Group( [ [ 0, 1 ], [ -1, 0 ] ] ) ) );   # C4: |C4 (x) C4| * 4^2
64

# phi
gap> Q := SmallGroup( 8, 4 );;  N := RoccoNuGroup( Q );;
gap> IsBijective( RoccoPhi( N ) ) and ForAll( Q, g ->
>      Image( RoccoPhi( N ), Image( Embedding( N, 1 ), g ) ) = Image( Embedding( N, 2 ), g ) );
true

# policiclico infinito: grupo de Heisenberg sobre Z
gap> H := HeisenbergPcpGroup( 1 );;
gap> N := RoccoNuGroup( H );;
gap> IsFinite( N );
false
gap> IsInjective( Embedding( N, 1 ) ) and IsInjective( Embedding( N, 2 ) );
true

# fora do escopo por enquanto
gap> RoccoNuGroup( AlternatingGroup( 5 ) );
Error, RoccoNuGroup: no method computes nu(G) for this <G> yet;
RoccoNuGroup( G, "fp" ) gives it as a finitely presented group
gap> STOP_TEST("nu.tst");
