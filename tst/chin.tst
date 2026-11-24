# chi(n,H), chi_n(H) e chi de grupos perfeitos (2026-11-21).
# Referencias: Sidki, Rocco, de Oliveira, arXiv:2610.07330; Sidki 1980, 4.4.1.
gap> START_TEST("chin.tst");
gap> LoadPackage("SOR", false);;

# chi(2,H) = chi(H); |chi(3, C2 x C2)| = 2^9; Teorema A: |chi(n,H)| divide
# |chi(H)|^binom(n,2) |H|^(n - 2 binom(n,2))
gap> ForAll( [ [4,2], [8,3], [8,4], [9,2] ], function( id )
>      local H, c, c3;
>      H := SmallGroup( id );  c := Size( SidkiChiGroup( H ) );
>      c3 := Size( SidkiChiNGroup( H, 3 ) );
>      return Size( SidkiChiNGroup( H, 2 ) ) = c and ( c^3 / Size( H )^3 ) mod c3 = 0;
>    end );
true
gap> Size( SidkiChiNGroup( SmallGroup( 4, 2 ), 3 ) );
512

# mergulhos e relacoes de chi(n,H)
gap> H := SmallGroup( 8, 4 );;  C := SidkiChiNGroup( H, 3 );;
gap> e := List( [ 1 .. 3 ], i -> Embedding( C, i ) );;
gap> ForAll( e, IsInjective );
true
gap> ForAll( Combinations( [ 1 .. 3 ], 2 ), p -> ForAll( H, h ->
>      IsOne( Comm( Image( e[p[1]], h ), Image( e[p[2]], h ) ) ) ) );
true
gap> D12 := CommutatorSubgroup( Image( e[1] ), Image( e[2] ) );;
gap> L23 := Subgroup( C, List( H, h -> Image( e[2], h )^-1 * Image( e[3], h ) ) );;
gap> IsTrivial( CommutatorSubgroup( D12, L23 ) );
true

# grupo mae: fp, com mergulhos; chi_2(H) tem a ordem de chi(H)
gap> M := SidkiChiMotherGroup( SmallGroup( 4, 2 ), 2 );;
gap> Size( Image( EpimorphismPGroup( M, 2 ) ) );
32

# perfeitos: chi(H) = T(H~) (Sidki 4.4.1), |chi| = |H|^2 |H~|, D ~ H~
gap> H := AlternatingGroup( 5 );;  C := SidkiChiGroup( H );;
gap> Size( C ) = Size( H )^2 * 120;
true
gap> IdGroup( SidkiD( C ) );   # SL(2,5)
[ 120, 5 ]
gap> ForAll( H, h -> IsOne( Comm( h^Embedding( C, 1 ), h^Embedding( C, 2 ) ) ) );
true

# hibrido Q(H) = chi^2(H)/N0: as seis relacoes de chi_4, o Lema da identidade,
# mergulhos injetivos; para H ciclico, Q(H) = H^4
gap> HibOk := function( H )
>   local Q, e;
>   Q := SidkiHybridGroup( H );  e := List( [ 1 .. 4 ], i -> Embedding( Q, i ) );
>   return ForAll( Combinations( [ 1 .. 4 ], 2 ), p -> ForAll( H, h ->
>            IsOne( Comm( h^e[p[1]], h^e[p[2]] ) ) ) )
>      and ForAll( H, h -> ForAll( H, k -> IsOne( Comm( h^e[1], k^e[4] )^( k^e[2] )
>                                * Comm( k^e[2], h^e[3] )^( k^e[4] ) ) ) )
>      and ForAll( e, IsInjective );
> end;;
gap> ForAll( [ [2,1], [3,1], [4,2], [8,4] ], id -> HibOk( SmallGroup( id ) ) );
true
gap> List( [ [2,1], [3,1], [4,1], [4,2], [8,4] ], id -> Size( SidkiHybridGroup( SmallGroup( id ) ) ) );
[ 16, 81, 256, 8192, 131072 ]
gap> STOP_TEST("chin.tst");
