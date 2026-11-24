#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups
#
# nu^q(G): declarations.
#
#! @Chapter The groups nu^q(G) and tau^q(G)
#!
#! @Section A polycyclic presentation of tau^q(G)
#!
#! For a non-negative integer $q$, the group $\nu^q(G)$ contains a normal
#! subgroup $\Delta^q(G)$ such that
#! $\tau^q(G) = \nu^q(G)/\Delta^q(G) \cong (G \wedge^q G) \rtimes (G \times G)$.
#! For $q = 0$, $\tau^0(G) = \nu(G)/\Delta(G) \cong \chi(G)/R(G)$.
#!
#! Dias and Rocco (J. Group Theory 23, 2020) give a consistent polycyclic
#! presentation of $\tau^q(G)$ for a polycyclic group $G$, from a consistent
#! polycyclic presentation $g_1, \ldots, g_n$ of $G$ and one of
#! $G \wedge^q G$, the latter obtained from the $q$-central extension
#! $E_q(G) = F/R^q[R,F]$ as $E_q(G)' E_q(G)^q$. This package builds that
#! presentation, starting from the Schur extension computed by the
#! <Package>Polycyclic</Package> package.
#!
#! The extension to a polycyclic presentation of $\nu^q(G)$ itself, and hence of
#! the $q$-tensor square $G \otimes^q G$, as the $q$-central extension
#! $\nu^q(G) = E_q(\tau^q(G))$ (Dias and Rocco, Section 7), is in preparation.

#! @Description
#!   Returns $\tau^q(G) = \nu^q(G)/\Delta^q(G)$ for a polycyclic group <A>G</A>
#!   (a finite solvable group in any representation, or a pcp group) and a
#!   non-negative integer <A>q</A>, as a pcp group given by the presentation
#!   of Dias and Rocco. <C>Embedding(</C><A>T</A><C>, 1)</C> and
#!   <C>Embedding(</C><A>T</A><C>, 2)</C> are the embeddings of $G$ and
#!   $G^\varphi$, and <Ref Attr="RoccoExteriorSquareQ" Label="for IsGroup"/>
#!   is the normal subgroup isomorphic to $G \wedge^q G$.
#! @Arguments G, q
#! @Returns a pcp group
DeclareOperation( "RoccoTauGroup", [ IsGroup, IsInt ] );

#! @Description
#!   For <A>T</A> $= \tau^q(G)$ returned by <Ref Oper="RoccoTauGroup"
#!   Label="for IsGroup, IsInt"/>, the subgroup $W \cong G \wedge^q G$.
#! @Arguments T
DeclareAttribute( "RoccoExteriorSquareQ", IsGroup );

#! @BeginExampleSession
#! gap> G := SymmetricGroup( 3 );;
#! gap> Size( RoccoTauGroup( G, 0 ) );   # = |chi(S_3)| / |R(S_3)|
#! 108
#! gap> List( [ 0, 2, 3 ], q -> Size( RoccoExteriorSquareQ( RoccoTauGroup( G, q ) ) ) );
#! [ 3, 6, 6 ]
#! @EndExampleSession

DeclareGlobalFunction( "RS_QCentralExtension" );
DeclareGlobalFunction( "RS_TauQCollector" );
DeclareAttribute( "RS_TauData", IsGroup );
