#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
#
# Subgroups and invariants of chi(G) and nu(G): implementations.
#

# The two copies of G inside chi(G).
BindGlobal( "RS_ChiCopies", function( C )
    local d;
    d := RS_ChiData( C );
    return [ Image( d.emb[1] ), Image( d.emb[2] ) ];
end );

InstallMethod( SidkiD, "for chi(G) of RoccoSidki",
    [ IsGroup and HasRS_ChiData ],
    function( C )
    local h;
    h := RS_ChiCopies( C );
    return CommutatorSubgroup( h[1], h[2] );
end );

# L(G) is the kernel of chi(G) -> G, which is the normal closure of
# g^-1 g^psi for g running over the generators of G.
InstallMethod( SidkiL, "for chi(G) of RoccoSidki",
    [ IsGroup and HasRS_ChiData ],
    function( C )
    local d;
    d := RS_ChiData( C );
    return NormalClosure( C, Subgroup( C,
               List( GeneratorsOfGroup( d.group ),
                     g -> Image( d.emb[1], g )^-1 * Image( d.emb[2], g ) ) ) );
end );

InstallMethod( SidkiW, "for chi(G) of RoccoSidki",
    [ IsGroup and HasRS_ChiData ],
    C -> Intersection( SidkiL( C ), SidkiD( C ) ) );

InstallMethod( SidkiR, "for chi(G) of RoccoSidki",
    [ IsGroup and HasRS_ChiData ],
    function( C )
    local h;
    h := RS_ChiCopies( C );
    return CommutatorSubgroup( CommutatorSubgroup( h[1], SidkiL( C ) ), h[2] );
end );
