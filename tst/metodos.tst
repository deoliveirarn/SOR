#
# SOR: escolha do metodo de chi(G) e nu(G) (segundo argumento)
#
gap> START_TEST( "metodos.tst" );
gap> SetInfoLevel( InfoSOR, 0 );

# chi(G) como grupo finitamente apresentado, para qualquer G finito
gap> G := SymmetricGroup( 3 );;
gap> Q := SidkiChiGroup( G, "fp" );;
gap> IsFpGroup( Q );  Size( Q );
true
108
gap> HasSidkiChiGroup( G );   # o segundo argumento nao guarda o resultado em G
false
gap> ForAll( G, g -> IsOne( Comm( g^Embedding( Q, 1 ), g^Embedding( Q, 2 ) ) ) );
true
gap> Size( Image( Embedding( Q, 1 ) ) );
6
gap> psi := SidkiPsi( Q );;
gap> ForAll( GeneratorsOfGroup( G ), g ->
>      Image( psi, Image( Embedding( Q, 1 ), g ) ) = Image( Embedding( Q, 2 ), g ) );
true
gap> Size( SidkiChiGroup( SmallGroup( 8, 4 ), "fp" ) );
128
gap> Q := SidkiChiGroup( SymmetricGroup( 5 ), "fp" );;   # sem outro metodo ainda
gap> AbelianInvariants( Q );   # chi(G)^ab = G^ab x G^ab
[ 2, 2 ]
gap> SidkiChiGroup( SymmetricGroup( 5 ) );
Error, SidkiChiGroup: no method computes chi(G) for this <G> yet;
SidkiChiGroup( G, "fp" ) gives it as a finitely presented group
gap> SidkiChiGroup( DihedralPcpGroup( 0 ), "fp" );
Error, SidkiChiGroup: "fp" needs <G> finite (one relation per element)
gap> F := FreeGroup( 2 );;   # fp infinito de abelianizado infinito: recusa logo
gap> SidkiChiGroup( F / [ F.1^2 ], "fp" );
Error, SidkiChiGroup: "fp" needs <G> finite (one relation per element)
gap> RoccoNuGroup( F / [ F.1^2 ], "fp" );
Error, RoccoNuGroup: "fp" needs <G> finite (relations for all pairs)

# chi(G): cada metodo forcado
gap> Size( SidkiChiGroup( SymmetricGroup( 3 ), "T" ) );
108
gap> Size( SidkiChiGroup( AlternatingGroup( 5 ), "perfect" ) );
432000
gap> HirschLength( SidkiChiGroup( DihedralPcpGroup( 0 ), "tau" ) );
3
gap> Size( SidkiChiGroup( SmallGroup( 8, 3 ), "tau" ) );   # finito, 2-gerado: R = 1
256
gap> G := SmallGroup( 8, 4 );;
gap> C := SidkiChiGroup( G, "pquotient" );;  Size( C );
128
gap> ForAll( G, g -> IsOne( Comm( g^Embedding( C, 1 ), g^Embedding( C, 2 ) ) ) );
true
gap> Size( SidkiChiGroup( G, "solvable" ) );
128
gap> Size( SidkiChiGroup( AlternatingGroup( 4 ), "solvable" ) );
1152
gap> Size( SidkiChiGroup( AlternatingGroup( 4 ), "auto" ) );
1152

# chi(G): o metodo forcado confere a hipotese do teorema
gap> SidkiChiGroup( AlternatingGroup( 4 ), "T" );   # M(A_4) = C_2
Error, SidkiChiGroup: "T" needs trivial Schur multiplier M(G)
gap> SidkiChiGroup( SymmetricGroup( 3 ), "perfect" );
Error, SidkiChiGroup: "perfect" needs <G> finite and perfect
gap> A := Image( IsomorphismFpGroup( AlternatingGroup( 5 ) ) );;
gap> SidkiChiGroup( A, "perfect" );   # como o caminho automatico, nao em fp
Error, SidkiChiGroup: "perfect" does not take a finitely presented <G>;
convert it first, for instance with IsomorphismPermGroup
gap> SidkiChiGroup( Image( IsomorphismFpGroup( SymmetricGroup( 3 ) ) ), "T" );
Error, SidkiChiGroup: "T" does not take a finitely presented <G>;
convert it first, for instance with IsomorphismPermGroup
gap> SidkiChiGroup( ElementaryAbelianGroup( 8 ), "tau" );   # 3 geradores
Error, SidkiChiGroup: "tau" needs <G> 2-generated (no 2 generators found);
SidkiChiModRGroup( G ) gives chi(G)/R(G)
gap> SidkiChiGroup( SymmetricGroup( 5 ), "tau" );
Error, SidkiChiGroup: "tau" needs <G> polycyclic (finite solvable or pcp)
gap> SidkiChiGroup( SymmetricGroup( 3 ), "pquotient" );
Error, SidkiChiGroup: "pquotient" needs <G> a finite p-group
gap> SidkiChiGroup( SymmetricGroup( 5 ), "solvable" );
Error, SidkiChiGroup: "solvable" needs <G> finite and solvable
gap> SidkiChiGroup( SymmetricGroup( 3 ), "pc" );
Error, SidkiChiGroup: <method> must be one of
"auto", "fp", "T", "perfect", "tau", "pquotient", "solvable"
gap> SidkiChiGroup( TrivialGroup( IsPermGroup ), "fp" );
Error, SidkiChiGroup: <G> must be nontrivial

# nu(G) como grupo finitamente apresentado
gap> G := SymmetricGroup( 3 );;
gap> N := RoccoNuGroup( G, "fp" );;
gap> IsFpGroup( N );  Size( N );
true
216
gap> HasRoccoNuGroup( G );
false
gap> phi := RoccoPhi( N );;
gap> ForAll( GeneratorsOfGroup( G ), g ->
>      Image( phi, Image( Embedding( N, 1 ), g ) ) = Image( Embedding( N, 2 ), g ) );
true
gap> G := DihedralGroup( 8 );;
gap> Size( RoccoNuGroup( G, "fp" ) );
2048
gap> AbelianInvariants( RoccoNuGroup( AlternatingGroup( 5 ), "fp" ) );   # perfeito
[  ]
gap> RoccoNuGroup( AlternatingGroup( 5 ) );
Error, RoccoNuGroup: no method computes nu(G) for this <G> yet;
RoccoNuGroup( G, "fp" ) gives it as a finitely presented group

# nu(G): cada metodo forcado, e as recusas
gap> Size( RoccoNuGroup( DihedralGroup( 8 ), "pquotient" ) );
2048
gap> Size( RoccoNuGroup( DihedralGroup( 8 ), "polycyclic" ) );
2048
gap> Size( RoccoNuGroup( SymmetricGroup( 3 ), "polycyclic" ) );
216
gap> Size( RoccoNuGroup( SymmetricGroup( 3 ), "auto" ) );
216
gap> RoccoNuGroup( SymmetricGroup( 3 ), "pquotient" );
Error, RoccoNuGroup: "pquotient" needs <G> a finite p-group
gap> RoccoNuGroup( AlternatingGroup( 5 ), "polycyclic" );
Error, RoccoNuGroup: "polycyclic" needs <G> finite solvable or a pcp group
gap> RoccoNuGroup( DihedralPcpGroup( 0 ), "fp" );
Error, RoccoNuGroup: "fp" needs <G> finite (relations for all pairs)
gap> RoccoNuGroup( SymmetricGroup( 3 ), "pc" );
Error, RoccoNuGroup: <method> must be one of
"auto", "fp", "pquotient", "polycyclic"

# chi(G,S;m): a projecao vai, por padrao, para o chi(G) finitamente apresentado
gap> A := ElementaryAbelianGroup( 4 );;
gap> C := SidkiChiHatGroup( A, 1 );;
gap> P := SidkiChiHatProjection( C );;
gap> IsFpGroup( Range( P ) );
true
gap> AbelianInvariants( Kernel( P ) );   # Z x Z
[ 0, 0 ]
gap> P2 := SidkiChiHatProjection( C, "auto" );;   # para o chi(G) calculado
gap> IsPcGroup( Range( P2 ) );  AbelianInvariants( Kernel( P2 ) );
true
[ 0, 0 ]
gap> # a composta G -> chi(G,S;m) -> chi(G) e a imersao de G em chi(G), nos dois
gap> # alvos; injetiva, logo as imersoes em chi(G,S;m) tambem sao
gap> ForAll( [ P, P2 ], p -> ForAll( [ 1, 2 ], i ->
>      ForAll( A, g -> Image( p, Image( Embedding( C, i ), g ) ) =
>                      Image( Embedding( Range( p ), i ), g ) ) and
>      Size( Image( Embedding( C, i ) * p ) ) = Size( A ) ) );
true
gap> Size( Image( SidkiChiHatProjection( SidkiChiHatGroup( A, 2 ), "auto" ) ) )
>    = Size( SidkiChiGroup( A ) );   # Corolario 1: sobrejetora
true
gap> C := SidkiChiHatGroup( SymmetricGroup( 5 ), 1 );;   # chi(S_5): so fp
gap> R := Range( SidkiChiHatProjection( C ) );;
gap> IsFpGroup( R );  AbelianInvariants( R );
true
[ 2, 2 ]
gap> SidkiChiHatProjection( C, "solvable" );
Error, SidkiChiGroup: "solvable" needs <G> finite and solvable
gap> STOP_TEST( "metodos.tst" );
