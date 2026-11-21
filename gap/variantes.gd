#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
#
# chi(H, sigma): weak commutativity defined by a bijection (declarations).
#
#! @Chapter Weak commutativity by bijections
#!
#! @Section Construction
#!
#! Let $H$ be a finite group, $\dot H$ an isomorphic copy of $H$, and
#! $\sigma : H^\# \to \dot H^\#$ a bijection, where $H^\# = H \setminus \{1\}$.
#! The weak commutativity group defined by $\sigma$ is
#! $$\chi(H,\sigma) = \langle H, \dot H \mid [h, h^\sigma] = 1
#!   \ \forall h \in H^\# \rangle$$
#! (Oliveira and Sidki, Bull. Braz. Math. Soc. 40, 2009). When $\sigma$ is the
#! isomorphism $\psi$, it is Sidki's group $\chi(H)$. The group $\chi(H,\sigma)$
#! is the group $S(H, \dot H; \sigma, \sigma, 1)$ of Sidki (J. Algebra 63, 1980,
#! Theorem 3.5 and Remark 3.3 (iii)), hence it is finite for every finite $H$.
#! The package computes it exactly, by coset enumeration in the finitely
#! presented group, and returns a pc group when it is solvable and a
#! permutation group otherwise.
#!
#! Oliveira and Sidki (2009) conjecture that $\chi(H,\sigma)$ is a finite
#! $p$-group whenever $H$ is a finite $p$-group. This is open, so the package
#! does not take the largest $p$-quotient for the group: <C>IsPGroup</C> of
#! the result tests the conjecture for the given $\sigma$.
#!
#! A bijection $\sigma$ is given by a permutation $s$ of
#! $[1 .. |H| - 1]$: if $H^\# = [ h_1, \ldots, h_{|H|-1} ]$ is the list
#! <Ref Func="SidkiNonIdentityElements"/>, then $\sigma(h_i)$ is the copy of
#! $h_{i^s}$. The identity permutation gives $\chi(H)$.

#! @Description
#!   The list of the non-identity elements of <A>H</A>, in the order of
#!   <C>Elements</C>. Bijections $\sigma$ are permutations of its positions.
#! @Arguments H
#! @Returns a list
DeclareGlobalFunction( "SidkiNonIdentityElements" );

#! @Description
#!   The permutation of $[1 .. |H|-1]$ that encodes the bijection given by
#!   <A>f</A>, a function from $H^\#$ to $H^\#$ or the list of the images of
#!   <Ref Func="SidkiNonIdentityElements"/>.
#! @Arguments H, f
#! @Returns a permutation
DeclareGlobalFunction( "SidkiBijectionAsPermutation" );

#! @Description
#!   Returns $\chi(H,\sigma)$ for a finite group <A>H</A> and the permutation
#!   <A>s</A> encoding $\sigma$, computed exactly. <C>Embedding(</C><A>C</A>
#!   <C>, 1)</C> and <C>Embedding(</C><A>C</A><C>, 2)</C> are the embeddings of
#!   $H$ and $\dot H$, and <Ref Attr="SidkiD" Label="for IsGroup"/> is
#!   $[H, \dot H]$. Coset enumeration limits this to groups of moderate order.
#! @Arguments H, s
#! @Returns a pc group or a permutation group
DeclareOperation( "SidkiChiGroupByBijection", [ IsGroup, IsPerm ] );

#! @BeginExampleSession
#! gap> H := ElementaryAbelianGroup( 8 );;
#! gap> Size( SidkiChiGroupByBijection( H, () ) ) = Size( SidkiChiGroup( H ) );
#! true
#! gap> C := SidkiChiGroupByBijection( H, (1,2) );;
#! gap> Size( C );  IsPGroup( C );
#! 1024
#! true
#! gap> Size( SidkiChiGroupByBijection( CyclicGroup( 8 ), (1,5,3) ) );   # cyclic: H x H
#! 64
#! @EndExampleSession

#! @Section Reductions (Oliveira and Sidki, 2009)
#!
#! For $\alpha \in \mathrm{Aut}(H)$ and $\beta \in \mathrm{Aut}(\dot H)$,
#! $\chi(H,\sigma) \cong \chi(H, \alpha\sigma\beta)$; so it suffices to let
#! $\sigma$ run over the double cosets
#! $\mathrm{Aut}(H) \backslash \mathrm{Sym}(H^\#) / \mathrm{Aut}(H)$. For an
#! elementary abelian group $H = C_p^n = \langle a_1, \ldots, a_n \rangle$,
#! every class contains a $\tilde\sigma$ with $a_i^{\tilde\sigma} = \dot a_i$;
#! and, for $p$ odd, every $\chi(H,\sigma)$ is a quotient of some
#! $\chi(H,\hat\sigma)$ with $\hat\sigma$ permuting the cyclic subgroups of $H$
#! (Sidki). For cyclic $H$, $\chi(H,\sigma) \cong H \times \dot H$ for every
#! $\sigma$ (Oliveira and Sidki 2009, Proposition 5).

#! @Description
#!   Representatives of the double cosets
#!   $\mathrm{Aut}(H) \backslash \mathrm{Sym}(H^\#) / \mathrm{Aut}(H)$, as pairs
#!   <C>[ s, size ]</C>, with <C>s</C> a permutation encoding $\sigma$ and
#!   <C>size</C> the number of bijections in the class.
#! @Arguments H
#! @Returns a list of pairs
DeclareGlobalFunction( "SidkiBijectionClasses" );

#! @Description
#!   For an elementary abelian group <A>H</A>, with basis $a_1, \ldots, a_n$
#!   the pc generators of <A>H</A>, a permutation encoding a bijection
#!   $\tilde\sigma = \alpha\sigma\beta$ ($\alpha, \beta$ automorphisms) with
#!   $a_i^{\tilde\sigma} = \dot a_i$, so that
#!   $\chi(H,\tilde\sigma) \cong \chi(H,\sigma)$.
#! @Arguments H, s
#! @Returns a permutation
DeclareGlobalFunction( "SidkiBasisFixingBijection" );

#! @Description
#!   For an elementary abelian $p$-group <A>H</A>, one generator of each
#!   subgroup of order $p$, normalised so that its first nonzero coordinate
#!   (with respect to the pc generators) is $1$.
#! @Arguments H
#! @Returns a list
DeclareGlobalFunction( "SidkiCyclicSubgroupGenerators" );

#! @Description
#!   For an elementary abelian $p$-group <A>H</A> with cyclic subgroups
#!   $\langle u_1 \rangle, \ldots, \langle u_k \rangle$
#!   (<Ref Func="SidkiCyclicSubgroupGenerators"/>), a permutation <A>tau</A>
#!   of $[1..k]$ and optionally a list <A>t</A> of nonzero residues mod $p$
#!   (the twists, default $1$), the permutation encoding the bijection
#!   $u_i^j \mapsto \dot u_{\tau(i)}^{t_i j}$, which permutes the cyclic
#!   subgroups.
#! @Arguments H, tau[, t]
#! @Returns a permutation
DeclareGlobalFunction( "SidkiSubgroupPermutingBijection" );

#! @Description
#!   If the bijection encoded by <A>s</A> maps each cyclic subgroup of the
#!   elementary abelian group <A>H</A> onto a cyclic subgroup, the induced
#!   permutation $\tau$ of $[1..k]$; otherwise <K>fail</K>.
#! @Arguments H, s
#! @Returns a permutation or <K>fail</K>
DeclareGlobalFunction( "SidkiInducedPermutation" );

#! @Description
#!   For an elementary abelian group <A>H</A>, representatives $\tau$ of the
#!   double cosets of $\mathrm{Aut}(H)$, acting on the $k$ cyclic subgroups,
#!   in $S_k$, as pairs <C>[ tau, size ]</C>.
#! @Arguments H
#! @Returns a list of pairs
DeclareGlobalFunction( "SidkiSubgroupPermutationClasses" );

#! @BeginExampleSession
#! gap> Length( SidkiBijectionClasses( ElementaryAbelianGroup( 8 ) ) );
#! 4
#! gap> H := ElementaryAbelianGroup( 9 );;
#! gap> Length( SidkiCyclicSubgroupGenerators( H ) );
#! 4
#! gap> s := SidkiSubgroupPermutingBijection( H, (1,2) );;
#! gap> SidkiInducedPermutation( H, s );
#! (1,2)
#! gap> s := SidkiBasisFixingBijection( H, (1,4,7) );;
#! gap> Size( SidkiChiGroupByBijection( H, s ) ) =
#! >    Size( SidkiChiGroupByBijection( H, (1,4,7) ) );
#! true
#! @EndExampleSession

# Internal data of chi(H, sigma).
DeclareAttribute( "RS_ChiBijData", IsGroup );
