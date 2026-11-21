#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
#
# chi_n(G), n copies: implementations.
#

#############################################################################
##
##  RS_ChiNRelations( H, e, withDL ) -- relations in the free product of n
##  copies, e the list of embeddings H -> free product.
##    weak commutativity: [h^psi_i, h^psi_j], h <> 1, i < j;
##    if withDL: [ [x^psi_i, y^psi_j], z^-psi_k z^psi_l ], {i,j} <> {k,l}
##    (for {i,j} = {k,l} they follow from weak commutativity, Sidki 4.1.7).
##  As in R. N. de Oliveira's function chin (2026, original/chi_n).
##
InstallGlobalFunction( RS_ChiNRelations, function( H, e, withDL )
    local n, el, rels, pares, p, r, x, y, z, Dgens, Lgens;
    n := Length( e );
    el := Difference( AsList( H ), [ One( H ) ] );
    pares := Combinations( [ 1 .. n ], 2 );
    rels := [];
    for p in pares do
        Append( rels, List( el, h -> Comm( Image( e[p[1]], h ), Image( e[p[2]], h ) ) ) );
    od;
    if withDL then
        for p in pares do
            Dgens := ListX( el, el, { x, y } -> Comm( Image( e[p[1]], x ), Image( e[p[2]], y ) ) );
            for r in pares do
                if p <> r then
                    Lgens := List( el, z -> Image( e[r[1]], z )^-1 * Image( e[r[2]], z ) );
                    Append( rels, ListX( Dgens, Lgens, Comm ) );
                fi;
            od;
        od;
    fi;
    return rels;
end );

#############################################################################
##
##  RS_TnTilde( H, n ) -- H a finite perfect group.
##
##  T_n(H~) (arXiv:2610.07330, Subsection 2.x; Sidki 1980, 4.4 for n = 2):
##  H~ the Schur cover of H, Z its central kernel, (a)_i the element a in the
##  i-th coordinate of H~^(n+1); H~_i = < (a)_1 (a)_{2+i} >, Z_i likewise with
##  z in Z, i = 0..n-1; T_n = < H~_0, ..., H~_{n-1} > / Z_0 ... Z_{n-1}.
##
InstallGlobalFunction( RS_TnTilde, function( H, n )
    local epi, iso, Ht, toH, Z, P, e, gens, lift, coord, Gt, N, nat, T, emb;
    epi := EpimorphismSchurCover( H );
    iso := IsomorphismPermGroup( Source( epi ) );
    Ht := Image( iso );
    toH := InverseGeneralMapping( iso ) * epi;
    Z := Kernel( toH );
    P := CallFuncList( DirectProduct, ListWithIdenticalEntries( n + 1, Ht ) );
    e := List( [ 1 .. n + 1 ], i -> Embedding( P, i ) );
    coord := function( a, i ) return Image( e[1], a ) * Image( e[2 + i], a ); end;
    gens := GeneratorsOfGroup( H );
    lift := List( gens, h -> PreImagesRepresentative( toH, h ) );
    Gt := Subgroup( P, ListX( [ 0 .. n - 1 ], lift, { i, a } -> coord( a, i ) ) );
    N := Subgroup( P, ListX( [ 0 .. n - 1 ], GeneratorsOfGroup( Z ), { i, z } -> coord( z, i ) ) );
    nat := NaturalHomomorphismByNormalSubgroup( Gt, N );
    T := Image( nat );
    emb := List( [ 0 .. n - 1 ], i -> GroupHomomorphismByImagesNC( H, T, gens,
               List( lift, a -> Image( nat, coord( a, i ) ) ) ) );
    return rec( group := T, emb := emb );
end );

InstallMethod( SidkiChiNGroup, "for a finite p-group or a finite perfect group",
    [ IsGroup, IsPosInt ],
    function( H, n )
    local r, data;
    if n < 2 then
        Error( "SidkiChiNGroup: <n> must be at least 2" );
    fi;
    if IsTrivial( H ) or not IsFinite( H ) then
        Error( "SidkiChiNGroup: <H> must be a nontrivial finite group" );
    elif IsPerfectGroup( H ) then
        Info( InfoRoccoSidki, 1, "chi(n,H): H perfect, T_n(H~)" );
        r := RS_TnTilde( H, n );
    elif IsPGroup( H ) then
        data := RS_FreeProductQuotient( H, n, e -> RS_ChiNRelations( H, e, true ) );
        # chi(n,H) is a finite p-group: finite and nilpotent (arXiv:2610.07330)
        # with order dividing a power of p (Theorem A).
        r := RS_PQuotientWithEmbeddings( H, data, PrimePGroup( H ) );
    else
        Error( "SidkiChiNGroup: for now <H> must be a finite p-group or perfect" );
    fi;
    SetRS_ChiData( r.group, rec( group := H, n := n, emb := r.emb ) );
    return r.group;
end );

InstallMethod( SidkiChiMotherGroup, "for a group, by the free product",
    [ IsGroup, IsPosInt ],
    function( H, n )
    local data, emb;
    if n < 2 then
        Error( "SidkiChiMotherGroup: <n> must be at least 2" );
    fi;
    if not IsFinite( H ) then
        Error( "SidkiChiMotherGroup: for now <H> must be finite" );
    fi;
    data := RS_FreeProductQuotient( H, n, e -> RS_ChiNRelations( H, e, false ) );
    emb := List( data.emb, e -> e * data.nat );
    SetRS_ChiData( data.Q, rec( group := H, n := n, emb := emb ) );
    return data.Q;
end );

# chi(H) for a finite perfect group: Sidki 1980, Theorem 4.4.1, chi(H) = T(H~).
InstallMethod( SidkiChiGroup, "for a finite perfect group, as T(H~)",
    [ IsGroup ], 5,
    function( H )
    local r;
    if IsTrivial( H ) or IsFpGroup( H ) or not IsFinite( H ) or not IsPerfectGroup( H ) then
        TryNextMethod();
    fi;
    Info( InfoRoccoSidki, 1, "chi(H): H perfect, T(H~) (Sidki 4.4.1)" );
    r := RS_TnTilde( H, 2 );
    SetRS_ChiData( r.group, rec( group := H, emb := r.emb ) );
    return r.group;
end );

# Q(H) = chi^2(H) / N_0 (arXiv:2610.07330, Definition 7.x).
InstallMethod( SidkiHybridGroup, "for a group, from chi(chi(H))",
    [ IsGroup ],
    function( H )
    local K, C, gH, copias, el, N0, nat, Q, emb;
    K := SidkiChiGroup( H );                 # chi(H) = < H, H^psi >
    C := SidkiChiGroup( K );                 # chi^2(H) = < K, K^psi' >
    gH := GeneratorsOfGroup( H );
    # H, H^psi, H^psi', H^{psi psi'} inside chi^2(H)
    copias := List( [ [1,1], [2,1], [1,2], [2,2] ], c ->
                 Embedding( K, c[1] ) * Embedding( C, c[2] ) );
    el := AsList( H );
    N0 := NormalClosure( C, Subgroup( C, Concatenation(
              List( el, h -> Comm( Image( copias[1], h ), Image( copias[4], h ) ) ),
              List( el, h -> Comm( Image( copias[2], h ), Image( copias[3], h ) ) ) ) ) );
    nat := NaturalHomomorphismByNormalSubgroup( C, N0 );
    Q := Image( nat );
    emb := List( copias, e -> GroupHomomorphismByImagesNC( H, Q, gH,
               List( gH, g -> Image( nat, Image( e, g ) ) ) ) );
    SetRS_ChiData( Q, rec( group := H, n := 4, hybrid := true, emb := emb ) );
    return Q;
end );
