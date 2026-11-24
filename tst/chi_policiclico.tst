# chi(G) e chi(G)/R(G) por tau(G) de Dias-Rocco (2026-11-21).
gap> START_TEST("chi_policiclico.tst");
gap> LoadPackage("SOR", false);;

# |chi/R| = |chi| / |R|, comparando com o produto livre; R = 1 nos 2-gerados
gap> ForAll( [ [6,1], [8,3], [8,4], [12,3], [27,3], [32,34], [81,12] ], function( id )
>      local G, C, M;
>      G := SmallGroup( id );  C := SidkiChiGroup( G );  M := SidkiChiModRGroup( G );
>      return Size( M ) = Size( C ) / Size( SidkiR( C ) )
>         and Size( SidkiD( M ) ) * Size( SidkiR( C ) ) = Size( SidkiD( C ) );
>    end );
true
gap> ForAll( [ [8,3], [8,4], [16,3], [27,3], [32,6] ], id ->
>      Length( MinimalGeneratingSet( SmallGroup( id ) ) ) > 2 or
>      IsTrivial( SidkiR( SidkiChiGroup( SmallGroup( id ) ) ) ) );
true

# policiclicos infinitos 2-gerados: chi(G) com mergulhos e subgrupos
gap> ChiInf := function( G )
>   local C, e1, e2, gs;
>   C := SidkiChiGroup( G );  e1 := Embedding( C, 1 );  e2 := Embedding( C, 2 );
>   gs := Concatenation( GeneratorsOfGroup( G ),
>           List( Tuples( GeneratorsOfGroup( G ), 2 ), Product ),
>           List( Tuples( GeneratorsOfGroup( G ), 3 ), Product ) );
>   return [ IsFinite( C ),
>            ForAll( gs, g -> IsOne( Comm( Image( e1, g ), Image( e2, g ) ) ) ),
>            IsTrivial( SidkiR( C ) ) ];
> end;;
gap> ChiInf( DihedralPcpGroup( 0 ) );
[ false, true, true ]
gap> ChiInf( HeisenbergPcpGroup( 1 ) );
[ false, true, true ]

# T(G) = chi(G)/W(G) <= G x G x G (Sidki 1980); |W|/|R| = |M(G)| (Rocco 1982)
gap> ForAll( [ [6,1], [8,3], [8,4], [12,3], [16,3], [27,3], [32,34], [81,12], [24,3] ], function( id )
>      local G, C;
>      G := SmallGroup( id );  C := RS_ChiByFreeProduct( G );
>      return Size( SidkiChiModWGroup( G ) ) = Size( C ) / Size( SidkiW( C ) )
>         and Size( SidkiW( C ) ) / Size( SidkiR( C ) ) = Product( AbelianInvariantsMultiplier( G ) );
>    end );
true

# W = 1 (2-gerado, M = 1): chi(G) = T(G) bate com o produto livre (Q8, SL(2,3))
gap> List( [ [8,4], [24,3] ], id -> Size( SidkiChiGroup( SmallGroup( id ) ) )
>          = Size( RS_ChiByFreeProduct( SmallGroup( id ) ) ) );
[ true, true ]

# nao soluvel: PSL(2,8)
gap> G := PSL( 2, 8 );;  C := SidkiChiGroup( G );;
gap> Size( C ) = Size( G )^3 and IsTrivial( SidkiW( C ) );
true
gap> STOP_TEST("chi_policiclico.tst");
