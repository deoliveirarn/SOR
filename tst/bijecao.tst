# chi(H, sigma): checks against Oliveira-Sidki 2009.
gap> START_TEST( "bijecao.tst" );
gap> LoadPackage( "SOR", false );;
gap> SetInfoLevel( InfoSOR, 0 );
gap> H := ElementaryAbelianGroup( 8 );;
gap> Length( SidkiBijectionClasses( H ) );   # Oliveira-Sidki 2009: 4
4
gap> Collected( List( SidkiBijectionClasses( H ), c ->
>      Size( SidkiChiGroupByBijection( H, c[1] ) ) ) );
[ [ 256, 2 ], [ 1024, 2 ] ]
gap> Length( SidkiSubgroupPermutationClasses( ElementaryAbelianGroup( 27 ) ) );   # 2009: 252
252
gap> ForAll( [ CyclicGroup( 4 ), CyclicGroup( 5 ) ], H -> ForAll( SidkiBijectionClasses( H ),
>      c -> Size( SidkiChiGroupByBijection( H, c[1] ) ) = Size( H )^2 ) );   # cyclic: H x H
true
gap> STOP_TEST( "bijecao.tst" );
