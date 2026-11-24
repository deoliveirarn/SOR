# Subgrupos de chi(G) e nu(G): identidades publicadas conferidas (2026-11-21).
gap> START_TEST("subgrupos.tst");
gap> LoadPackage("SOR", false);;

# chi: R(G) nao trivial (valores do chi_DL1L2.out do Ricardo, Conference_NRR_p)
gap> List( [ [32,34], [81,12] ], function( id )
>      local C;  C := SidkiChiGroup( SmallGroup( id ) );
>      return List( [ SidkiR, SidkiD, SidkiL1, SidkiL2 ], f -> Size( f( C ) ) );
>    end );
[ [ 4, 256, 256, 256 ], [ 3, 729, 729, 729 ] ]

# chi(G)' = D L1 L2 (Bastos, de Oliveira, Ortega 2026); D/R ~ L1/R ~ L2/R
gap> ChiOk := function( G )
>   local C, D, L1, L2;
>   C := SidkiChiGroup( G );  D := SidkiD( C );  L1 := SidkiL1( C );  L2 := SidkiL2( C );
>   return DerivedSubgroup( C ) = ClosureGroup( D, Concatenation(
>            GeneratorsOfGroup( L1 ), GeneratorsOfGroup( L2 ) ) )
>          and Size( D ) = Size( L1 ) and Size( D ) = Size( L2 )
>          and IsSubgroup( SidkiR( C ), CommutatorSubgroup( L1, L2 ) );
> end;;
gap> ForAll( [ [6,1], [8,3], [8,4], [12,3], [27,3], [32,34] ], id -> ChiOk( SmallGroup( id ) ) );
true

# nu(G)' = Ups1 Ups2 Ups3, Ups_i ~ G (x) G, [Ups2, G^phi] = 1 = [Ups3, G]
gap> NuOk := function( G )
>   local N, U, h;
>   N := RoccoNuGroup( G );
>   U := [ RoccoUpsilon1( N ), RoccoUpsilon2( N ), RoccoUpsilon3( N ) ];
>   h := [ Image( Embedding( N, 1 ) ), Image( Embedding( N, 2 ) ) ];
>   return DerivedSubgroup( N ) = ClosureGroup( U[1], Concatenation(
>            GeneratorsOfGroup( U[2] ), GeneratorsOfGroup( U[3] ) ) )
>          and Size( U[1] ) = Size( U[2] ) and Size( U[1] ) = Size( U[3] )
>          and IsTrivial( CommutatorSubgroup( U[2], h[2] ) )
>          and IsTrivial( CommutatorSubgroup( U[3], h[1] ) );
> end;;
gap> ForAll( [ [6,1], [8,3], [8,4], [12,3], [27,3], [32,34] ], id -> NuOk( SmallGroup( id ) ) );
true

# Theta e L pela definicao (todos os elementos)
gap> G := SmallGroup( 12, 3 );;  N := RoccoNuGroup( G );;
gap> RoccoTheta( N ) = Subgroup( N, List( G, g ->
>      Image( Embedding( N, 1 ), g )^-1 * Image( Embedding( N, 2 ), g ) ) );
true

# a ponte nu(G)/Delta(G) ~ chi(G)/R(G): ordens, por dois caminhos independentes
# (nu pelo Polycyclic ou Rocco 1994; chi pelo produto livre)
gap> ForAll( [ [6,1], [8,3], [8,4], [12,3], [16,3], [27,3], [32,34] ], function( id )
>      local G, N, C;
>      G := SmallGroup( id );  N := RoccoNuGroup( G );  C := SidkiChiGroup( G );
>      return Size( N ) / Size( RoccoDelta( N ) ) = Size( C ) / Size( SidkiR( C ) );
>    end );
true
gap> STOP_TEST("subgrupos.tst");
