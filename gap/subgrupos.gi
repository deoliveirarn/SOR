#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups
#
# Subgroups and invariants of chi(G) and nu(G): implementations.
#

# The two copies of G inside chi(G).
BindGlobal( "RS_ChiCopies", function( C )
    local d;
    d := RS_ChiData( C );
    return [ Image( d.emb[1] ), Image( d.emb[2] ) ];
end );

InstallMethod( SidkiD, "for chi(G) of SOR",
    [ IsGroup and HasRS_ChiData ],
    function( C )
    local h;
    h := RS_ChiCopies( C );
    return CommutatorSubgroup( h[1], h[2] );
end );

# L(G) is the kernel of chi(G) -> G, which is the normal closure of
# g^-1 g^psi for g running over the generators of G.
InstallMethod( SidkiL, "for chi(G) of SOR",
    [ IsGroup and HasRS_ChiData ],
    function( C )
    local d;
    d := RS_ChiData( C );
    return NormalClosure( C, Subgroup( C,
               List( GeneratorsOfGroup( d.group ),
                     g -> Image( d.emb[1], g )^-1 * Image( d.emb[2], g ) ) ) );
end );

InstallMethod( SidkiW, "for chi(G) of SOR",
    [ IsGroup and HasRS_ChiData ],
    C -> Intersection( SidkiL( C ), SidkiD( C ) ) );

InstallMethod( SidkiR, "for chi(G) of SOR",
    [ IsGroup and HasRS_ChiData ],
    function( C )
    local h;
    h := RS_ChiCopies( C );
    return CommutatorSubgroup( CommutatorSubgroup( h[1], SidkiL( C ) ), h[2] );
end );

InstallMethod( SidkiL1, "for chi(G) of SOR",
    [ IsGroup and HasRS_ChiData ],
    C -> CommutatorSubgroup( SidkiL( C ), RS_ChiCopies( C )[1] ) );

InstallMethod( SidkiL2, "for chi(G) of SOR",
    [ IsGroup and HasRS_ChiData ],
    C -> CommutatorSubgroup( SidkiL( C ), RS_ChiCopies( C )[2] ) );

# ---------------------------------------------------------------- nu(G)

BindGlobal( "RS_NuCopies", function( N )
    local d;
    d := RS_NuData( N );
    return [ Image( d.emb[1] ), Image( d.emb[2] ) ];
end );

# Theta(G) is the kernel of nu(G) -> G, the normal closure of g^-1 g^phi
# for g running over the generators of G.
InstallMethod( RoccoTheta, "for nu(G) of SOR",
    [ IsGroup and HasRS_NuData ],
    function( N )
    local d;
    d := RS_NuData( N );
    return NormalClosure( N, Subgroup( N,
               List( GeneratorsOfGroup( d.group ),
                     g -> Image( d.emb[1], g )^-1 * Image( d.emb[2], g ) ) ) );
end );

InstallMethod( RoccoUpsilon1, "for nu(G) of SOR",
    [ IsGroup and HasRS_NuData ],
    function( N )
    local h;
    h := RS_NuCopies( N );
    return CommutatorSubgroup( h[1], h[2] );
end );

InstallMethod( RoccoUpsilon2, "for nu(G) of SOR",
    [ IsGroup and HasRS_NuData ],
    N -> CommutatorSubgroup( RoccoTheta( N ), RS_NuCopies( N )[1] ) );

InstallMethod( RoccoUpsilon3, "for nu(G) of SOR",
    [ IsGroup and HasRS_NuData ],
    N -> CommutatorSubgroup( RoccoTheta( N ), RS_NuCopies( N )[2] ) );

InstallMethod( RoccoDelta, "for nu(G) of SOR",
    [ IsGroup and HasRS_NuData ],
    function( N )
    local d;
    d := RS_NuData( N );
    if not IsFinite( d.group ) then
        Error( "RoccoDelta: for now only for finite G" );
    fi;
    return Subgroup( N, List( AsList( d.group ),
               g -> Comm( Image( d.emb[1], g ), Image( d.emb[2], g ) ) ) );
end );
