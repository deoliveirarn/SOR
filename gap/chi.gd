#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
#
# chi(G) (Sidki): declarations.
#
#! @Chapter The weak commutativity group
#!
#! @Section Construction
#!
#! Let $G$ be a group and $G^\psi$ an isomorphic copy of $G$, with
#! $\psi : G \to G^\psi$ an isomorphism. Sidki's weak commutativity group is
#! $$\chi(G) = \langle G, G^\psi \mid [g, g^\psi] = 1 \ \forall g \in G \rangle.$$
#! Here it is computed as the quotient of the free product $G * G$ by these
#! relations, keeping the two embeddings of $G$.

#! @Description
#!   Returns $\chi(G)$ for a finite solvable group <A>G</A> given in any
#!   representation (permutation, pc, pcp, matrix or finitely presented).
#!   The result is a pc group. <C>Embedding(</C><A>C</A><C>, 1)</C> and
#!   <C>Embedding(</C><A>C</A><C>, 2)</C> are the embeddings of $G$ and of
#!   $G^\psi$ into it, and <Ref Attr="SidkiPsi" Label="for IsGroup"/> is $\psi$.
#! @Arguments G
#! @Returns a pc group
DeclareAttribute( "SidkiChiGroup", IsGroup );

#! @Description
#!   For a group <A>C</A> returned by <Ref Attr="SidkiChiGroup" Label="for IsGroup"/>, the
#!   isomorphism $\psi$ from the first copy of $G$ in <A>C</A> to the second.
#! @Arguments C
#! @Returns an isomorphism of groups
DeclareAttribute( "SidkiPsi", IsGroup );

#! @BeginExampleSession
#! gap> G := SmallGroup( 8, 4 );;   # the quaternion group
#! gap> C := SidkiChiGroup( G );;
#! gap> Size( C );
#! 128
#! gap> H := Image( Embedding( C, 1 ) );;  Hpsi := Image( Embedding( C, 2 ) );;
#! gap> Size( H ) = 8 and Size( Hpsi ) = 8;
#! true
#! gap> ForAll( G, g -> IsOne( Comm( g^Embedding( C, 1 ), g^Embedding( C, 2 ) ) ) );
#! true
#! gap> P := Image( IsomorphismPermGroup( G ) );;   # same group, other representation
#! gap> Size( SidkiChiGroup( P ) );
#! 128
#! @EndExampleSession

# Internal record kept with the result: the input group and the embeddings.
DeclareAttribute( "RS_ChiData", IsGroup );
