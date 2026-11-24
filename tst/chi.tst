# chi(G) pelo produto livre com mergulhos: ordens e subgrupos conferidos
# (2026-11-21) contra o chi_D original do Ricardo e contra o HAP.
gap> START_TEST("chi.tst");
gap> LoadPackage("SOR", false);;
gap> Dados := function( K )
>   local C;
>   C := SidkiChiGroup( K );
>   return [ Size( C ), Size( SidkiD( C ) ), Size( SidkiL( C ) ),
>            Size( SidkiW( C ) ), Size( SidkiR( C ) ) ];
> end;;
gap> Repr := G -> [ G, Image( IsomorphismPermGroup( G ) ),
>                   Image( IsomorphismPcpGroup( G ) ),
>                   Image( IsomorphismFpGroup( G ) ) ];;

# Q8, D8, 16#3, 27#3, 32#6, cada um em quatro representacoes
gap> List( Repr( SmallGroup( 8, 4 ) ), Dados );
[ [ 128, 2, 16, 1, 1 ], [ 128, 2, 16, 1, 1 ], [ 128, 2, 16, 1, 1 ], 
  [ 128, 2, 16, 1, 1 ] ]
gap> List( Repr( SmallGroup( 8, 3 ) ), Dados );
[ [ 256, 4, 32, 2, 1 ], [ 256, 4, 32, 2, 1 ], [ 256, 4, 32, 2, 1 ], 
  [ 256, 4, 32, 2, 1 ] ]
gap> Set( Repr( SmallGroup( 16, 3 ) ), Dados );
[ [ 2048, 8, 128, 4, 1 ] ]
gap> Set( Repr( SmallGroup( 27, 3 ) ), Dados );
[ [ 19683, 27, 729, 9, 1 ] ]
gap> Set( Repr( SmallGroup( 32, 6 ) ), Dados );
[ [ 16384, 16, 512, 4, 1 ] ]

# grupo matricial
gap> Size( SidkiChiGroup( Group( [ [ 0, 1 ], [ -1, 0 ] ] ) ) );
16

# mergulhos injetivos, relacoes de chi, psi isomorfismo, L pela definicao
gap> G := SmallGroup( 16, 3 );;  C := SidkiChiGroup( G );;
gap> e1 := Embedding( C, 1 );;  e2 := Embedding( C, 2 );;
gap> IsInjective( e1 ) and IsInjective( e2 );
true
gap> ForAll( G, g -> IsOne( Comm( Image( e1, g ), Image( e2, g ) ) ) );
true
gap> IsBijective( SidkiPsi( C ) );
true
gap> ForAll( G, g -> Image( SidkiPsi( C ), Image( e1, g ) ) = Image( e2, g ) );
true
gap> SidkiL( C ) = Subgroup( C, List( G, g -> Image( e1, g )^-1 * Image( e2, g ) ) );
true
gap> IsNormal( C, SidkiD( C ) ) and IsNormal( C, SidkiL( C ) );
true

# soluveis nao nilpotentes (quociente soluvel) e fora do escopo por enquanto
gap> List( [ [6,1], [6,2], [10,1], [12,3] ], id -> Size( SidkiChiGroup( SmallGroup( id ) ) ) );
[ 108, 36, 500, 1152 ]
gap> SidkiChiGroup( SymmetricGroup( 5 ) );   # nem soluvel nem perfeito
Error, SidkiChiGroup: for now <G> must be a nontrivial finite solvable group
gap> STOP_TEST("chi.tst");
