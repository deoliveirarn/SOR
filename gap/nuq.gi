#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups
#
# nu^q(G): implementations.
#
# Dias and Rocco, J. Group Theory 23 (2020), Definition 6.1 and Theorem 6.2.
# Rewritten from R. N. de Oliveira's functions tauq and gest (2017); the
# relations (4) are imposed for ALL pairs i, j (the 2017 version only had
# j > i), and the pcp of the q-exterior square is read directly from the
# induced pcp of E_q' E_q^q.
#

#############################################################################
##
##  RS_QCentralExtension( H, q ) -- H a pcp group given by its own collector.
##
##  E_q(H) = F/R^q[R,F] (Dias-Rocco, Lemma 3.2), as the quotient of the
##  Schur extension F/[R,F] of Polycyclic by the q-th powers of its central
##  kernel R/[R,F]; epi : E_q -> H; W = E_q' E_q^q ~ H ^q H.
##
InstallGlobalFunction( RS_QCentralExtension, function( H, q )
    local epi0, S, K, nat, Eq, epi, gens, W;
    epi0 := SchurExtensionEpimorphism( H );
    S := Source( epi0 );
    K := Kernel( epi0 );
    nat := NaturalHomomorphismByNormalSubgroup( S,
               Subgroup( S, List( GeneratorsOfGroup( K ), k -> k^q ) ) );
    Eq := Image( nat );
    epi := GroupHomomorphismByImagesNC( Eq, H,
               List( GeneratorsOfGroup( S ), s -> Image( nat, s ) ),
               List( GeneratorsOfGroup( S ), s -> Image( epi0, s ) ) );
    gens := GeneratorsOfGroup( Eq );
    # normal closure of [x,y] and x^q over generators = E_q' E_q^q
    W := NormalClosure( Eq, Subgroup( Eq, Concatenation(
             List( Combinations( gens, 2 ), c -> Comm( c[1], c[2] ) ),
             List( gens, g -> g^q ) ) ) );
    return rec( Eq := Eq, epi := epi, W := W );
end );

#############################################################################
##
##  RS_TauQCollector( H, q ) -- the collector of Definition 6.1.
##
##  Generators: g_1..g_n (G), g_1^phi..g_n^phi (G^phi), w_1..w_r (G ^q G).
##
InstallGlobalFunction( RS_TauQCollector, function( H, q )
    local cH, n, e, lift, pcpW, w, r, roW, ftl, ro, shift, ewd, i, j, k;
    cH := Collector( H );
    n := NumberOfGenerators( cH );
    e := RS_QCentralExtension( H, q );
    lift := List( GeneratorsOfGroup( H ), g -> PreImagesRepresentative( e.epi, g ) );
    pcpW := Pcp( e.W );
    w := GeneratorsOfPcp( pcpW );
    r := Length( w );
    roW := RelativeOrdersOfPcp( pcpW );
    ftl := FromTheLeftCollector( 2*n + r );
    ro := RelativeOrders( cH );

    shift := function( l, s )
        local m, a;
        m := ShallowCopy( l );
        for a in [ 1, 3 .. Length( m ) - 1 ] do m[a] := m[a] + s; od;
        return m;
    end;
    # exponent list, in the generators w_a = 2n+a, of an element of W
    ewd := function( x )
        local ex, l, a;
        ex := ExponentsByPcp( pcpW, x );
        l := [];
        for a in [ 1 .. r ] do
            if ex[a] <> 0 then Append( l, [ 2*n + a, ex[a] ] ); fi;
        od;
        return l;
    end;

    # (1), (2): the presentations of G and of G^phi
    for i in [ 1 .. n ] do
        for k in [ 0, n ] do
            SetRelativeOrder( ftl, i + k, ro[i] );
            if ro[i] <> 0 and GetPower( cH, i ) <> [] then
                SetPower( ftl, i + k, shift( GetPower( cH, i ), k ) );
            fi;
            for j in [ i+1 .. n ] do
                SetConjugate( ftl, j + k, i + k, shift( GetConjugate( cH, j, i ), k ) );
                if ro[i] = 0 then
                    SetConjugate( ftl, j + k, -(i + k), shift( GetConjugate( cH, j, -i ), k ) );
                fi;
            od;
        od;
    od;
    # (3): the presentation of G ^q G
    for i in [ 1 .. r ] do
        SetRelativeOrder( ftl, 2*n + i, roW[i] );
        if roW[i] <> 0 then SetPower( ftl, 2*n + i, ewd( w[i]^roW[i] ) ); fi;
        for j in [ i+1 .. r ] do
            SetConjugate( ftl, 2*n + j, 2*n + i, ewd( w[j]^w[i] ) );
            if roW[i] = 0 then
                SetConjugate( ftl, 2*n + j, -(2*n + i), ewd( w[j]^(w[i]^-1) ) );
            fi;
        od;
    od;
    # (4): g_i^-1 g_j^phi g_i = g_j^phi (g_i ^ g_j)^-1, g_i ^ g_j -> [g_i~, g_j~],
    #      for all i, j
    for i in [ 1 .. n ] do
        for j in [ 1 .. n ] do
            SetConjugate( ftl, n + j, i,
                Concatenation( [ n + j, 1 ], ewd( Comm( lift[i], lift[j] )^-1 ) ) );
            if ro[i] = 0 then
                SetConjugate( ftl, n + j, -i,
                    Concatenation( [ n + j, 1 ], ewd( Comm( lift[i]^-1, lift[j] )^-1 ) ) );
            fi;
        od;
    od;
    # (5): G and G^phi act on W as G acts on G ^q G
    for i in [ 1 .. r ] do
        for j in [ 1 .. n ] do
            for k in [ 0, n ] do
                SetConjugate( ftl, 2*n + i, j + k, ewd( w[i]^lift[j] ) );
                if ro[j] = 0 then
                    SetConjugate( ftl, 2*n + i, -(j + k), ewd( w[i]^(lift[j]^-1) ) );
                fi;
            od;
        od;
    od;
    UpdatePolycyclicCollector( ftl );
    return rec( collector := ftl, n := n, r := r );
end );

InstallMethod( RoccoTauGroup, "for a polycyclic group and an integer, Dias-Rocco",
    [ IsGroup, IsInt ],
    function( G, q )
    local iso, a, P, H, toH, c, T, gT, n, gens, emb;
    if q < 0 then
        Error( "RoccoTauGroup: <q> must be non-negative" );
    fi;
    if IsTrivial( G ) then
        Error( "RoccoTauGroup: <G> must be nontrivial" );
    fi;
    if IsPcpGroup( G ) then
        iso := IdentityMapping( G );
    elif IsFinite( G ) and IsSolvableGroup( G ) then
        a := IsomorphismPcGroup( G );
        iso := a * IsomorphismPcpGroup( Image( a ) );
    else
        Error( "RoccoTauGroup: <G> must be finite solvable or a pcp group" );
    fi;
    P := Image( iso );
    # a group whose collector is given by the pcp of P
    H := PcpGroupByPcp( Pcp( P ) );
    toH := GroupHomomorphismByImagesNC( P, H, GeneratorsOfPcp( Pcp( P ) ),
               GeneratorsOfGroup( H ) );
    c := RS_TauQCollector( H, q );
    if not IsConfluent( c.collector ) then
        Error( "RoccoTauGroup: inconsistent presentation (please report)" );
    fi;
    T := PcpGroupByCollector( c.collector );
    gT := GeneratorsOfPcp( Pcp( T ) );
    n := c.n;
    gens := GeneratorsOfGroup( G );
    emb := List( [ 0, n ], k -> GroupHomomorphismByImagesNC( G, T, gens,
               List( gens, g -> MappedVector(
                   ExponentsByPcp( Pcp( H ), Image( toH, Image( iso, g ) ) ),
                   gT{ [ k+1 .. k+n ] } ) ) ) );
    SetRS_TauData( T, rec( group := G, q := q, emb := emb,
        W := Subgroup( T, gT{ [ 2*n+1 .. 2*n + c.r ] } ) ) );
    return T;
end );

InstallMethod( Embedding, "for tau^q(G) of SOR",
    [ IsGroup and HasRS_TauData, IsPosInt ],
    function( T, i )
    if i > 2 then
        Error( "Embedding: tau^q(G) has only two copies of G" );
    fi;
    return RS_TauData( T ).emb[ i ];
end );

InstallMethod( RoccoExteriorSquareQ, "for tau^q(G) of SOR",
    [ IsGroup and HasRS_TauData ],
    T -> RS_TauData( T ).W );
