#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups
#
# nu(G) (Rocco): declarations.
#
#! @Chapter Rocco's group nu(G)
#!
#! @Section Construction
#!
#! Let $G^\varphi$ be an isomorphic copy of $G$. Rocco's group is
#! $$\nu(G) = \langle G, G^\varphi \mid [x, y^\varphi]^z = [x^z, (y^z)^\varphi]
#!   = [x, y^\varphi]^{z^\varphi} \ \forall x, y, z \in G \rangle,$$
#! and the subgroup $[G, G^\varphi]$ of $\nu(G)$ is isomorphic to the
#! non-abelian tensor square $G \otimes G$ (Rocco 1991).
#!
#! Two methods are used, both keeping the embeddings of $G$ and $G^\varphi$:
#! <List>
#! <Item>finite $p$-groups: the quotient of the free product $G * G$ by the
#!   relations of Rocco (1994) for an AG-system $a_1, \ldots, a_n$ of $G$,
#!   $[a_i, a_j^\varphi]^{a_k} = [a_i^{a_k}, (a_j^{a_k})^\varphi]
#!   = [a_i, a_j^\varphi]^{a_k^\varphi}$, followed by its largest
#!   $p$-quotient;</Item>
#! <Item>other finite solvable groups and polycyclic groups: the function
#!   <C>NonAbelianTensorSquarePlus</C> of the <Package>Polycyclic</Package> package
#!   (Eick and Nickel 2008), whose first $2n$ generators are the images of
#!   the $n$ generators of $G$ and of $G^\varphi$.</Item>
#! </List>

#! @Description
#!   Returns $\nu(G)$ for a finite solvable group or a polycyclic group
#!   <A>G</A>. A finite <A>G</A> may be given in any representation; an
#!   infinite polycyclic one must be a pcp group. <C>Embedding(</C><A>N</A>
#!   <C>, 1)</C> and <C>Embedding(</C><A>N</A><C>, 2)</C> are the embeddings
#!   of $G$ and of $G^\varphi$ into the result, and
#!   <Ref Attr="RoccoPhi" Label="for IsGroup"/> is $\varphi$.
#! @Arguments G
#! @Returns a pc group (finite $p$-groups) or a pcp group
DeclareAttribute( "RoccoNuGroup", IsGroup );

#! @Description
#!   For a group <A>N</A> returned by
#!   <Ref Attr="RoccoNuGroup" Label="for IsGroup"/>, the isomorphism
#!   $\varphi$ from the first copy of $G$ in <A>N</A> to the second.
#! @Arguments N
#! @Returns an isomorphism of groups
DeclareAttribute( "RoccoPhi", IsGroup );

#! @BeginExampleSession
#! gap> D := DihedralGroup( 8 );;  N := RoccoNuGroup( D );;  phi := RoccoPhi( N );;
#! gap> ForAll( GeneratorsOfGroup( D ), g ->
#! >      Image( phi, Image( Embedding( N, 1 ), g ) ) = Image( Embedding( N, 2 ), g ) );
#! true
#! @EndExampleSession

#! @BeginExampleSession
#! gap> G := SymmetricGroup( 3 );;
#! gap> N := RoccoNuGroup( G );;
#! gap> Size( N );
#! 216
#! gap> T := CommutatorSubgroup( Image( Embedding( N, 1 ) ),
#! >                             Image( Embedding( N, 2 ) ) );;
#! gap> Size( T );   # the order of the tensor square of S_3
#! 6
#! gap> Size( RoccoNuGroup( SmallGroup( 32, 49 ) ) ) = 2^26;
#! true
#! @EndExampleSession

# Internal: the two methods, each returning rec( group, emb ) with the
# embeddings starting from G.  Used by RoccoNuGroup and by the tests.
DeclareGlobalFunction( "RS_NuRocco1994" );
DeclareGlobalFunction( "RS_NuPolycyclic" );
DeclareAttribute( "RS_NuData", IsGroup );
