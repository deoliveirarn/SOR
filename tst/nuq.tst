# tau^q(G) de Dias-Rocco (2026-11-21): consistencia, q = 0 contra o Polycyclic,
# ordem |G|^2 |G ^q G|, mergulhos e a ponte com chi(G)/R(G).
gap> START_TEST("nuq.tst");
gap> LoadPackage("RoccoSidki", false);;

# q = 0: igual ao tau(G) = nu(G)/Delta(G) do Polycyclic (Eick-Nickel)
gap> ForAll( [ [6,1], [4,2], [8,3], [8,4], [12,3], [27,3], [24,12] ], function( id )
>      local P;
>      P := Image( IsomorphismPcpGroup( SmallGroup( id ) ) );
>      return Size( RoccoTauGroup( P, 0 ) ) =
>               Size( Range( NonAbelianExteriorSquarePlusEmbedding( P ) ) )
>         and Size( RoccoExteriorSquareQ( RoccoTauGroup( P, 0 ) ) ) =
>               Size( NonAbelianExteriorSquare( P ) );
>    end );
true

# q > 0: |tau^q| = |G|^2 |G ^q G| e tau^q/W ~ G x G
gap> ForAll( [ [6,1], [4,2], [8,3], [8,4], [12,3], [27,3] ], id -> ForAll( [ 2, 3, 4 ],
>      function( q )
>        local G, T, W;
>        G := SmallGroup( id );  T := RoccoTauGroup( G, q );  W := RoccoExteriorSquareQ( T );
>        return IsNormal( T, W ) and Size( T ) = Size( G )^2 * Size( W );
>      end ) );
true
gap> List( [ 0, 2, 3, 4 ], q -> Size( RoccoExteriorSquareQ( RoccoTauGroup( SmallGroup( 8, 3 ), q ) ) ) );
[ 4, 16, 8, 16 ]

# a ponte (q = 0): |tau(G)| = |chi(G)| / |R(G)|
gap> ForAll( [ [6,1], [8,3], [32,34], [81,12] ], function( id )
>      local G, C;
>      G := SmallGroup( id );  C := SidkiChiGroup( G );
>      return Size( RoccoTauGroup( G, 0 ) ) = Size( C ) / Size( SidkiR( C ) );
>    end );
true

# mergulhos e relacao (4): g^-1 (h^phi) g = h^phi (g ^ h)^-1 com (g ^ h) em W
gap> G := SymmetricGroup( 3 );;  T := RoccoTauGroup( G, 2 );;
gap> e1 := Embedding( T, 1 );;  e2 := Embedding( T, 2 );;
gap> IsInjective( e1 ) and IsInjective( e2 );
true
gap> ForAll( G, g -> ForAll( G, h ->
>      Image( e2, h )^-1 * Image( e2, h )^Image( e1, g ) in RoccoExteriorSquareQ( T ) ) );
true

# todas as representacoes
gap> Set( [ G, Image( IsomorphismPcGroup( G ) ), Image( IsomorphismFpGroup( G ) ) ],
>         K -> Size( RoccoTauGroup( K, 2 ) ) );
[ 216 ]

# policiclicos infinitos: D_infinito (Exemplo 3.4 de Dias-Rocco) e Heisenberg
gap> IsFinite( RoccoExteriorSquareQ( RoccoTauGroup( DihedralPcpGroup( 0 ), 0 ) ) );
false
gap> AbelianInvariants( RoccoExteriorSquareQ( RoccoTauGroup( HeisenbergPcpGroup( 1 ), 2 ) ) );
[ 0, 0, 2, 2, 4 ]
gap> STOP_TEST("nuq.tst");
