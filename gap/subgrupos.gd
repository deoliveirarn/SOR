#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
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
