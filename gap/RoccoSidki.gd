#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
#
# General declarations.
#
#! @Chapter Introduction
#!
#! The &RoccoSidki; package computes Rocco's group $\nu(G)$, its variant
#! $\nu^q(G)$, Sidki's weak commutativity group $\chi(G)$, its version
#! $\chi_n(G)$ with $n$ copies, and the variants $\chi(G,\sigma)$ defined by
#! bijections. All of them are built as quotients of the free product of
#! copies of $G$, so the input group may be given in any representation
#! (permutation, pc, pcp, matrix or finitely presented) and the embeddings
#! of the copies of $G$ are kept.
#!
#! @Section Info class

#! @Description
#!   Info class of the package.
DeclareInfoClass( "InfoRoccoSidki" );

#! @Chapter How the groups are built
#!
#! @Section Free products with embeddings
#!
#! Every group of this package is a quotient $Q = (G_1 * \cdots * G_n)/N$ of a
#! free product of copies of the input group $G$, where $N$ is the normal
#! closure of the defining relations. The construction starts from
#! <C>FreeProduct</C> of &GAP;, which accepts groups in any representation, and
#! keeps the embeddings $G \to G_i$ given by <C>Embedding</C>. The images of the
#! generators of $G$ are carried through the quotient and through the
#! conversion of $Q$ into a pc group, and the embeddings $G \to Q$ are stored
#! with the result.
#!
#! This is what makes the subgroups of $Q$ cheap to compute. For instance, in
#! $\chi(G)$ the subgroups $L(G)$, $D(G)$, $W(G)$ and $R(G)$ are defined in terms of
#! the two copies $G$ and $G^\psi$ and of the isomorphism $\psi$ between them;
#! with the embeddings at hand they are direct computations inside a pc group.
#! Without them, one has to locate the copies of $G$ inside the computed group,
#! which is a search, or to carry every element of $G$ through a presentation
#! by hand.

#! @Section Strategy by class of groups
#!
#! The finitely presented group $Q$ is turned into a group in which one can
#! compute according to the class of $G$:
#! <List>
#! <Item>finite $p$-groups: $\chi(G)$ is a finite $p$-group (Sidki), so it is
#!   the largest $p$-quotient of $Q$, computed by <C>EpimorphismPGroup</C>
#!   without a bound on the class;</Item>
#! <Item>finite solvable groups: $\chi(G)$ is a finite solvable group whose
#!   order involves only the primes dividing $|G|$ (Sidki), so it is the
#!   largest such solvable quotient of $Q$, computed by
#!   <C>EpimorphismSolvableQuotient</C>;</Item>
#! <Item>for $\nu(G)$, see the chapter on Rocco's group;</Item>
#! <Item>non-solvable groups will be handled in later versions.</Item>
#! </List>

# Internal: the quotient of the free product of copies of G by relations,
# with the embeddings carried through. Documented in the code only.
DeclareGlobalFunction( "RS_FreeProductQuotient" );
DeclareGlobalFunction( "RS_PQuotientWithEmbeddings" );
DeclareGlobalFunction( "RS_SolvableQuotientWithEmbeddings" );
DeclareGlobalFunction( "RS_QuotientWithEmbeddings" );
