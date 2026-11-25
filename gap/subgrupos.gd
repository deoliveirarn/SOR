#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups
#
# Subgroups and invariants of chi(G) and nu(G): declarations.
#
#! @Chapter The weak commutativity group
#!
#! @Section Subgroups of chi(G)
#!
#! For $C = \chi(G)$, with the copies $G$ and $G^\psi$ given by the embeddings:
#! <List>
#! <Item>$L(G) = \langle g^{-1} g^\psi \mid g \in G \rangle$, the kernel of
#!   $\chi(G) \to G$, $g, g^\psi \mapsto g$;</Item>
#! <Item>$D(G) = [G, G^\psi]$, the kernel of $\chi(G) \to G \times G$;</Item>
#! <Item>$W(G) = L(G) \cap D(G)$;</Item>
#! <Item>$R(G) = [G, L(G), G^\psi]$.</Item>
#! </List>

#! @Description
#!   The subgroup $D(G) = [G, G^\psi]$ of <A>C</A> $= \chi(G)$.
#! @Arguments C
DeclareAttribute( "SidkiD", IsGroup );

#! @Description
#!   The subgroup $L(G) = \langle g^{-1} g^\psi \mid g \in G \rangle$ of
#!   <A>C</A> $= \chi(G)$.
#! @Arguments C
DeclareAttribute( "SidkiL", IsGroup );

#! @Description
#!   The subgroup $W(G) = L(G) \cap D(G)$ of <A>C</A> $= \chi(G)$.
#! @Arguments C
DeclareAttribute( "SidkiW", IsGroup );

#! @Description
#!   The subgroup $R(G) = [G, L(G), G^\psi]$ of <A>C</A> $= \chi(G)$.
#! @Arguments C
DeclareAttribute( "SidkiR", IsGroup );

#! @BeginExampleSession
#! gap> C := SidkiChiGroup( SmallGroup( 8, 3 ) );;   # the dihedral group
#! gap> List( [ SidkiD, SidkiL, SidkiW, SidkiR ], f -> Size( f( C ) ) );
#! [ 4, 32, 2, 1 ]
#! @EndExampleSession

#! @Description
#!   The subgroups $L_1(G) = [L(G), G]$ and $L_2(G) = [L(G), G^\psi]$ of
#!   <A>C</A> $= \chi(G)$ <Cite Key="BastosEtAl2026"/>. Then
#!   $\chi(G)' = D(G) L_1(G) L_2(G)$.
#! @Arguments C
DeclareAttribute( "SidkiL1", IsGroup );
#! @Arguments C
DeclareAttribute( "SidkiL2", IsGroup );

#! @BeginExampleSession
#! gap> C := SidkiChiGroup( DihedralGroup( 8 ) );;
#! gap> DerivedSubgroup( C ) =
#! >    ClosureGroup( SidkiD( C ), ClosureGroup( SidkiL1( C ), SidkiL2( C ) ) );
#! true
#! gap> [ Size( SidkiL1( C ) ), Size( SidkiL2( C ) ) ];
#! [ 4, 4 ]
#! @EndExampleSession

#! @Section Subgroups of nu(G)
#!
#! For $N = \nu(G)$, with the copies $G$ and $G^\varphi$ given by the
#! embeddings <Cite Key="BastosEtAl2022"/>:
#! <List>
#! <Item>$\Theta(G) = \langle g^{-1} g^\varphi \mid g \in G \rangle$, the kernel of
#!   $\nu(G) \to G$, $g, g^\varphi \mapsto g$;</Item>
#! <Item>$\Upsilon_1(G) = [G, G^\varphi] \cong G \otimes G$,
#!   $\Upsilon_2(G) = [\Theta(G), G]$, $\Upsilon_3(G) = [\Theta(G), G^\varphi]$;
#!   then $\nu(G)' = \Upsilon_1 \Upsilon_2 \Upsilon_3$;</Item>
#! <Item>$\Delta(G) = \langle [g, g^\varphi] \mid g \in G \rangle$, for finite
#!   $G$; then $\nu(G)/\Delta(G) \cong \chi(G)/R(G)$.</Item>
#! </List>

#! @Description
#!   The subgroup $\Theta(G)$ of <A>N</A> $= \nu(G)$.
#! @Arguments N
DeclareAttribute( "RoccoTheta", IsGroup );

#! @BeginExampleSession
#! gap> N := RoccoNuGroup( DihedralGroup( 8 ) );;
#! gap> Index( N, RoccoTheta( N ) );   # nu(G) / Theta(G) = G
#! 8
#! @EndExampleSession

#! @Description
#!   The subgroups $\Upsilon_1(G) = [G, G^\varphi]$, $\Upsilon_2(G) = [\Theta(G), G]$
#!   and $\Upsilon_3(G) = [\Theta(G), G^\varphi]$ of <A>N</A> $= \nu(G)$.
#! @Arguments N
DeclareAttribute( "RoccoUpsilon1", IsGroup );
#! @Arguments N
DeclareAttribute( "RoccoUpsilon2", IsGroup );
#! @Arguments N
DeclareAttribute( "RoccoUpsilon3", IsGroup );

#! @Description
#!   The subgroup $\Delta(G) = \langle [g, g^\varphi] \mid g \in G \rangle$ of
#!   <A>N</A> $= \nu(G)$, for finite $G$.
#! @Arguments N
DeclareAttribute( "RoccoDelta", IsGroup );

#! @BeginExampleSession
#! gap> G := SymmetricGroup( 3 );;
#! gap> N := RoccoNuGroup( G );;  C := SidkiChiGroup( G );;
#! gap> List( [ RoccoUpsilon1, RoccoUpsilon2, RoccoUpsilon3 ], f -> Size( f( N ) ) );
#! [ 6, 6, 6 ]
#! gap> Size( N ) / Size( RoccoDelta( N ) ) = Size( C ) / Size( SidkiR( C ) );
#! true
#! @EndExampleSession
