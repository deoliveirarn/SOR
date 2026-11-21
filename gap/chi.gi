#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
#
# chi(G) (Sidki): implementations.
#

InstallMethod( SidkiChiGroup, "for a finite p-group, by the free product",
    [ IsGroup ],
    function( G )
    local p, data, r, C;
    if not IsFinite( G ) or IsTrivial( G ) or not IsPGroup( G ) then
        Error( "SidkiChiGroup: for now <G> must be a nontrivial finite p-group" );
    fi;
    p := PrimePGroup( G );
    data := RS_FreeProductQuotient( G, 2,
              e -> List( Difference( AsList( G ), [ One( G ) ] ),
                         g -> Comm( Image( e[1], g ), Image( e[2], g ) ) ) );
    # chi(G) is a finite p-group (Sidki), hence its largest p-quotient.
    r := RS_PQuotientWithEmbeddings( G, data, p );
    C := r.group;
    SetRS_ChiData( C, rec( group := G, emb := r.emb ) );
    return C;
end );

InstallMethod( Embedding, "for chi(G) of RoccoSidki",
    [ IsGroup and HasRS_ChiData, IsPosInt ],
    function( C, i )
    if i > 2 then
        Error( "Embedding: chi(G) has only two copies of G" );
    fi;
    return RS_ChiData( C ).emb[ i ];
end );

InstallMethod( SidkiPsi, "for chi(G) of RoccoSidki",
    [ IsGroup and HasRS_ChiData ],
    function( C )
    local d, gens;
    d := RS_ChiData( C );
    gens := GeneratorsOfGroup( d.group );
    return GroupHomomorphismByImagesNC( Image( d.emb[1] ), Image( d.emb[2] ),
               List( gens, g -> Image( d.emb[1], g ) ),
               List( gens, g -> Image( d.emb[2], g ) ) );
end );
