#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups
#
# nu(G) (Rocco): implementations.
#

# Embeddings G -> N obtained from embeddings P -> N and an isomorphism
# iso : G -> P, through the images of the generators of G.
BindGlobal( "RS_PullBackEmbeddings", function( G, iso, embP, N )
    local gens;
    gens := GeneratorsOfGroup( G );
    return List( embP, e -> GroupHomomorphismByImagesNC( G, N, gens,
               List( gens, g -> Image( e, Image( iso, g ) ) ) ) );
end );

#############################################################################
##
##  RS_NuRocco1994( G ) -- G a finite p-group.
##
##  Rocco, Comm. Algebra 22 (1994): for an AG-system a_1..a_n of a finite
##  solvable group, nu(G) is presented by the relations of G and G^phi and
##  [a_i, b_j]^{a_k} = [a_i^{a_k}, b_j^{a_k}] = [a_i, b_j]^{b_k}, b = a^phi.
##  Here: free product P * P of a pc group P = G, the 2n^3 relations, and
##  the largest p-quotient (nu(G) is a finite p-group).
##
InstallGlobalFunction( RS_NuRocco1994, function( G )
    local iso, P, pcgs, data, r;
    iso := IsomorphismPcGroup( G );
    P := Image( iso );
    pcgs := Pcgs( P );
    data := RS_FreeProductQuotient( P, 2, function( e )
        local a, b, rels, i, j, k, n;
        a := List( pcgs, g -> Image( e[1], g ) );
        b := List( pcgs, g -> Image( e[2], g ) );
        n := Length( pcgs );
        rels := [];
        for i in [ 1 .. n ] do
            for j in [ 1 .. n ] do
                for k in [ 1 .. n ] do
                    Add( rels, Comm( a[i], b[j] )^a[k] /
                               Comm( a[i]^a[k], Image( e[2], pcgs[j]^pcgs[k] ) ) );
                    Add( rels, Comm( a[i], b[j] )^a[k] / Comm( a[i], b[j] )^b[k] );
                od;
            od;
        od;
        return rels;
    end );
    r := RS_PQuotientWithEmbeddings( P, data, PrimePGroup( P ) );
    return rec( group := r.group,
                emb := RS_PullBackEmbeddings( G, iso, r.emb, r.group ) );
end );

#############################################################################
##
##  RS_NuPolycyclic( G ) -- G finite solvable, or a polycyclic pcp group.
##
##  NonAbelianTensorSquarePlus of Polycyclic (Eick-Nickel) returns nu(P) for
##  a pcp group P; its generators Igs(T){[1..n]} and Igs(T){[n+1..2n]} are the
##  images of Igs(P) in the two copies (checked in tst/nu.tst).
##
InstallGlobalFunction( RS_NuPolycyclic, function( G )
    local iso, a, P, n, T, embP;
    if IsPcpGroup( G ) then
        iso := IdentityMapping( G );
    else
        a := IsomorphismPcGroup( G );
        iso := a * IsomorphismPcpGroup( Image( a ) );
    fi;
    P := Image( iso );
    n := Length( Igs( P ) );
    T := NonAbelianTensorSquarePlus( P );
    embP := [ GroupHomomorphismByImagesNC( P, T, Igs( P ), Igs( T ){ [ 1 .. n ] } ),
              GroupHomomorphismByImagesNC( P, T, Igs( P ), Igs( T ){ [ n+1 .. 2*n ] } ) ];
    return rec( group := T, emb := RS_PullBackEmbeddings( G, iso, embP, T ) );
end );

InstallMethod( RoccoNuGroup, "for a finite solvable or polycyclic group",
    [ IsGroup ],
    function( G )
    local r;
    if IsTrivial( G ) then
        Error( "RoccoNuGroup: <G> must be nontrivial" );
    elif IsFinite( G ) and IsPGroup( G ) then
        Info( InfoSOR, 1, "nu(G): p-group, Rocco 1994 + p-quotient" );
        r := RS_NuRocco1994( G );
    elif ( IsFinite( G ) and IsSolvableGroup( G ) ) or IsPcpGroup( G ) then
        Info( InfoSOR, 1, "nu(G): Polycyclic (NonAbelianTensorSquarePlus)" );
        r := RS_NuPolycyclic( G );
    elif IsFinite( G ) then
        Error( "RoccoNuGroup: no method computes nu(G) for this <G> yet;\n",
               "RoccoNuGroup( G, \"fp\" ) gives it as a finitely presented group" );
    else
        Error( "RoccoNuGroup: for now <G> must be finite solvable or a pcp group" );
    fi;
    SetRS_NuData( r.group, rec( group := G, emb := r.emb ) );
    return r.group;
end );

#############################################################################
##
##  RS_NuFp( G ) -- G finite: nu(G) as a finitely presented group.
##
##  The defining relations [x, y^phi]^z = [x^z, (y^z)^phi] = [x, y^phi]^(z^phi)
##  with x, y running over G \ {1} (all of them: restricting x, y is not
##  allowed) and z over a generating set of G, a small one (for a pc group,
##  GeneratorsOfGroup is the whole pcgs).  This suffices: the relations for
##  z1 and z2 (and all x, y) give those for z1 z2, and in a finite group
##  every element is a positive word in any generating set.
##
BindGlobal( "RS_NuFp", function( G )
    local gens, data;
    gens := SmallGeneratingSet( G );
    data := RS_FreeProductQuotient( G, 2, function( e )
        local els, a, b, az, bz, pos, rels, i, j, k, c, d;
        els := Difference( AsList( G ), [ One( G ) ] );
        a := List( els, x -> Image( e[1], x ) );
        b := List( els, x -> Image( e[2], x ) );
        az := List( gens, z -> Image( e[1], z ) );
        bz := List( gens, z -> Image( e[2], z ) );
        pos := List( els, x -> List( gens, z -> Position( els, x^z ) ) );
        rels := [];
        for i in [ 1 .. Length( els ) ] do
            for j in [ 1 .. Length( els ) ] do
                c := Comm( a[i], b[j] );
                for k in [ 1 .. Length( gens ) ] do
                    d := Comm( a[ pos[i][k] ], b[ pos[j][k] ] );
                    Add( rels, c^az[k] / d );
                    Add( rels, c^bz[k] / d );
                od;
            od;
        od;
        return rels;
    end );
    return RS_QuotientWithEmbeddings( G, data, IdentityMapping( data.Q ) );
end );

#############################################################################
##
##  RoccoNuGroup( G, method ) -- the method chosen by the user; the result is
##  not stored in G.  Each method checks its hypothesis.
##
BindGlobal( "RS_NuMethods", [ "auto", "fp", "pquotient", "polycyclic" ] );

InstallMethod( RoccoNuGroup, "for a group and a method chosen by the user",
    [ IsGroup, IsString ],
    function( G, method )
    local r;
    if not method in RS_NuMethods then
        Error( "RoccoNuGroup: <method> must be one of\n",
               "\"auto\", \"fp\", \"pquotient\", \"polycyclic\"" );
    # IsFinite first: see SidkiChiGroup( G, method ) in chi.gi
    elif IsFinite( G ) and IsTrivial( G ) then
        Error( "RoccoNuGroup: <G> must be nontrivial" );
    fi;
    if method = "auto" then
        return RoccoNuGroup( G );
    elif method = "fp" then
        if not IsFinite( G ) then
            Error( "RoccoNuGroup: \"fp\" needs <G> finite (relations for all pairs)" );
        fi;
        r := RS_NuFp( G );
    elif method = "pquotient" then
        if not ( IsFinite( G ) and IsPGroup( G ) ) then
            Error( "RoccoNuGroup: \"pquotient\" needs <G> a finite p-group" );
        fi;
        r := RS_NuRocco1994( G );
    else
        if not ( IsPcpGroup( G ) or ( IsFinite( G ) and IsSolvableGroup( G ) ) ) then
            Error( "RoccoNuGroup: \"polycyclic\" needs <G> finite solvable or a pcp group" );
        fi;
        r := RS_NuPolycyclic( G );
    fi;
    SetRS_NuData( r.group, rec( group := G, emb := r.emb ) );
    return r.group;
end );

InstallMethod( Embedding, "for nu(G) of SOR",
    [ IsGroup and HasRS_NuData, IsPosInt ],
    function( N, i )
    if i > 2 then
        Error( "Embedding: nu(G) has only two copies of G" );
    fi;
    return RS_NuData( N ).emb[ i ];
end );

InstallMethod( RoccoPhi, "for nu(G) of SOR",
    [ IsGroup and HasRS_NuData ],
    function( N )
    local d, gens;
    d := RS_NuData( N );
    gens := GeneratorsOfGroup( d.group );
    return GroupHomomorphismByImagesNC( Image( d.emb[1] ), Image( d.emb[2] ),
               List( gens, g -> Image( d.emb[1], g ) ),
               List( gens, g -> Image( d.emb[2], g ) ) );
end );
