#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
#
# chi_n(G), n copies: declarations.
#
#! @Chapter Weak commutativity among n copies
#!
#! @Section The groups chi_n(H) and chi(n,H)
#!
#! For $n$ copies $H = H^{\psi_0}, H^{\psi_1}, \ldots, H^{\psi_{n-1}}$ of a
#! group $H$ (S. N. Sidki, N. R. Rocco, R. N. de Oliveira, <E>On weak
#! commutativity between $n$ isomorphic groups, $n \geq 2$</E>,
#! arXiv:2610.07330, with an appendix by D. Savchuk):
#! $$\chi_n(H) = \langle H, H^{\psi_1}, \ldots, H^{\psi_{n-1}} \mid
#!   [h^{\psi_i}, h^{\psi_j}] = 1 \ \forall h \in H,\ i \neq j \rangle,$$
#! the "mother group", and its quotient
#! $$\chi(n, H) = \langle \chi_n(H) \mid [D_{ij}, L_{kl}] = 1 \ \forall i \neq j,\ k \neq l \rangle,$$
#! with $D_{ij} = [H^{\psi_i}, H^{\psi_j}]$ and
#! $L_{ij} = \langle h^{-\psi_i} h^{\psi_j} \mid h \in H \rangle$; the group
#! $\chi(n, H)$ was introduced in the doctoral thesis of R. N. de Oliveira
#! (2007). The operator $\chi(n, -)$ preserves finiteness, nilpotency and
#! perfectness, while $\chi_n(H)$ may be infinite for finite $H$ (for instance
#! $\chi_3(C_2 \times C_2)$). For a perfect group $H$,
#! $\chi(n, H) \cong T_n(\tilde{H})$, a subquotient of $\tilde{H}^{n+1}$ for the
#! Schur cover $\tilde{H}$ of $H$; for $n = 2$ this is Sidki's theorem
#! $\chi(H) \cong T(\tilde{H})$ (1980, Theorem 4.4.1).

#! @Description
#!   Returns $\chi(n, H)$ for a finite $p$-group or a finite perfect group
#!   <A>H</A> and an integer <A>n</A> $\geq 2$. <C>Embedding(</C><A>C</A>
#!   <C>, i)</C>, $1 \leq i \leq n$, is the embedding of the $i$-th copy.
#!   For $p$-groups it is the largest $p$-quotient of the quotient of the free
#!   product of $n$ copies of $H$ by the defining relations; for perfect groups,
#!   the group $T_n(\tilde{H})$.
#! @Arguments H, n
#! @Returns a group
DeclareOperation( "SidkiChiNGroup", [ IsGroup, IsPosInt ] );

#! @Description
#!   Returns the finitely presented group $\chi_n(H)$, as the quotient of the
#!   free product of <A>n</A> copies of <A>H</A>, with the embeddings
#!   <C>Embedding(</C><A>C</A><C>, i)</C>. It may be infinite; quotients can
#!   be computed from it, for instance by <C>EpimorphismPGroup</C> with a
#!   bound on the class.
#! @Arguments H, n
#! @Returns a finitely presented group
DeclareOperation( "SidkiChiMotherGroup", [ IsGroup, IsPosInt ] );

#! @BeginExampleSession
#! gap> H := SmallGroup( 4, 2 );;   # C2 x C2
#! gap> Size( SidkiChiNGroup( H, 3 ) );
#! 512
#! gap> Size( SidkiChiNGroup( H, 2 ) ) = Size( SidkiChiGroup( H ) );
#! true
#! gap> C := SidkiChiGroup( AlternatingGroup( 5 ) );;   # perfect: T(SL(2,5))
#! gap> Size( C ) = 60^2 * 120;
#! true
#! @EndExampleSession

DeclareGlobalFunction( "RS_TnTilde" );
DeclareGlobalFunction( "RS_ChiNRelations" );
