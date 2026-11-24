#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups
#
# General implementations.
#

#############################################################################
##
##  RS_FreeProductQuotient( G, n, relfun )
##
##  F := G * ... * G (n copies), e[i] := Embedding(F, i), and
##  Q := F / relfun(e).  Returns rec( F, emb := e, Q, nat ), where nat : F -> Q
##  is the natural map.  relfun receives the list of embeddings G -> F and
##  returns a list of elements of F.
##
InstallGlobalFunction( RS_FreeProductQuotient, function( G, n, relfun )
    local F, e, rels, Q, nat;
    F := CallFuncList( FreeProduct, ListWithIdenticalEntries( n, G ) );
    e := List( [ 1 .. n ], i -> Embedding( F, i ) );
    rels := relfun( e );
    Info( InfoSOR, 2, Length( rels ), " relations" );
    Q := F / rels;
    nat := GroupHomomorphismByImagesNC( F, Q,
               GeneratorsOfGroup( F ), GeneratorsOfGroup( Q ) );
    return rec( F := F, emb := e, Q := Q, nat := nat );
end );

#############################################################################
##
##  RS_PQuotientWithEmbeddings( G, data, p )
##
##  Largest p-quotient C of data.Q (EpimorphismPGroup without class bound;
##  it terminates only when that quotient is finite) and the embeddings
##  G -> C.  The embeddings are built from the images of the generators of G,
##  not by composing G -> F -> Q -> C: the composition makes GAP go back to
##  the finitely presented group (coset enumeration) for questions such as
##  IsInjective.
##
InstallGlobalFunction( RS_PQuotientWithEmbeddings, function( G, data, p )
    return RS_QuotientWithEmbeddings( G, data, EpimorphismPGroup( data.Q, p ) );
end );

#############################################################################
##
##  RS_SolvableQuotientWithEmbeddings( G, data, primes )
##
##  Largest solvable quotient of data.Q whose order involves only <primes>
##  (EpimorphismSolvableQuotient), with the embeddings G -> quotient.  It
##  terminates only when that quotient is finite.
##
InstallGlobalFunction( RS_SolvableQuotientWithEmbeddings, function( G, data, primes )
    return RS_QuotientWithEmbeddings( G, data,
               EpimorphismSolvableQuotient( data.Q, primes ) );
end );

#############################################################################
##
##  RS_QuotientWithEmbeddings( G, data, epi ) -- epi : data.Q -> C
##
InstallGlobalFunction( RS_QuotientWithEmbeddings, function( G, data, epi )
    local C, gens, emb;
    C := Image( epi );
    gens := GeneratorsOfGroup( G );
    emb := List( data.emb, e -> GroupHomomorphismByImagesNC( G, C, gens,
               List( gens, g -> Image( epi, Image( data.nat, Image( e, g ) ) ) ) ) );
    return rec( group := C, emb := emb );
end );
