#
# RoccoSidki: Rocco's nu(G), Sidki's chi(G) and related groups
#
# chi(H, sigma): weak commutativity defined by a bijection (implementations).
#

InstallGlobalFunction( SidkiNonIdentityElements,
    H -> Filtered( Elements( H ), x -> x <> One( H ) ) );

InstallGlobalFunction( SidkiBijectionAsPermutation, function( H, f )
    local eg, img;
    eg := SidkiNonIdentityElements( H );
    if IsFunction( f ) then
        img := List( eg, f );
    else
        img := f;
    fi;
    img := List( img, y -> Position( eg, y ) );
    if fail in img or Length( Set( img ) ) <> Length( eg ) then
        Error( "SidkiBijectionAsPermutation: <f> is not a bijection of H#" );
    fi;
    return PermList( img );
end );

# chi(H, sigma) is finite for finite H (Sidki 1980, Theorem 3.5 and
# Remark 3.3 (iii)), so the coset enumeration behind IsomorphismPermGroup
# terminates and gives the whole group.
InstallMethod( SidkiChiGroupByBijection, "for a finite group and a permutation",
    [ IsGroup, IsPerm ],
    function( H, s )
    local eg, n, data, iso, P, r, C;
    if not IsFinite( H ) or IsTrivial( H ) then
        Error( "SidkiChiGroupByBijection: <H> must be a nontrivial finite group" );
    fi;
    eg := SidkiNonIdentityElements( H );
    n := Length( eg );
    if LargestMovedPoint( s ) > n then
        Error( "SidkiChiGroupByBijection: <s> must permute [1..", n, "]" );
    fi;
    data := RS_FreeProductQuotient( H, 2, e -> List( [ 1 .. n ],
                i -> Comm( Image( e[1], eg[i] ), Image( e[2], eg[i^s] ) ) ) );
    iso := IsomorphismPermGroup( data.Q );
    P := Image( iso );
    iso := iso * SmallerDegreePermutationRepresentation( P );
    if IsSolvableGroup( Image( iso ) ) then
        iso := iso * IsomorphismPcGroup( Image( iso ) );
    fi;
    r := RS_QuotientWithEmbeddings( H, data, iso );
    C := r.group;
    SetRS_ChiBijData( C, rec( group := H, emb := r.emb, sigma := s, eg := eg ) );
    return C;
end );

InstallMethod( Embedding, "for chi(H,sigma) of RoccoSidki",
    [ IsGroup and HasRS_ChiBijData, IsPosInt ],
    function( C, i )
    if i > 2 then
        Error( "Embedding: there are only 2 copies of H" );
    fi;
    return RS_ChiBijData( C ).emb[ i ];
end );

InstallMethod( SidkiD, "for chi(H,sigma) of RoccoSidki",
    [ IsGroup and HasRS_ChiBijData ],
    C -> CommutatorSubgroup( Image( Embedding( C, 1 ) ), Image( Embedding( C, 2 ) ) ) );


# Double cosets Aut(H) \ Sym(H#) / Aut(H) (Oliveira-Sidki 2009).
BindGlobal( "RS_AutOnNonIdentity", function( H )
    local eg, A;
    eg := SidkiNonIdentityElements( H );
    A := AutomorphismGroup( H );
    return Group( Concatenation( [ () ], List( GeneratorsOfGroup( A ),
               a -> PermList( List( eg, x -> Position( eg, Image( a, x ) ) ) ) ) ) );
end );

InstallGlobalFunction( SidkiBijectionClasses, function( H )
    local A;
    A := RS_AutOnNonIdentity( H );
    return DoubleCosetRepsAndSizes( SymmetricGroup( Size( H ) - 1 ), A, A );
end );

# Elementary abelian groups: coordinates with respect to the pc generators.
BindGlobal( "RS_ElAbData", function( H )
    local p, iso, pcgs, F;
    if not IsElementaryAbelian( H ) or IsTrivial( H ) then
        Error( "<H> must be a nontrivial elementary abelian group" );
    fi;
    p := PrimePGroup( H );
    iso := IsomorphismPcGroup( H );
    pcgs := Pcgs( Image( iso ) );
    F := GF( p );
    return rec( p := p, n := Length( pcgs ), F := F,
        basis := List( pcgs, g -> PreImagesRepresentative( iso, g ) ),
        coords := x -> ExponentsOfPcElement( pcgs, Image( iso, x ) ) * One( F ) );
end );

InstallGlobalFunction( SidkiBasisFixingBijection, function( H, s )
    local d, eg, img, indep, B, c, a, b;
    d := RS_ElAbData( H );
    eg := SidkiNonIdentityElements( H );
    img := x -> eg[ Position( eg, x )^s ];
    indep := L -> RankMat( List( L, d.coords ) ) = d.n;
    # a basis of H whose image under sigma is a basis (Oliveira-Sidki 2009)
    B := fail;
    for c in IteratorOfCombinations( [ 1 .. Length( eg ) ], d.n ) do
        if indep( eg{ c } ) and indep( List( eg{ c }, img ) ) then
            B := eg{ c };
            break;
        fi;
    od;
    a := GroupHomomorphismByImages( H, H, d.basis, B );          # a_i -> b_i
    b := GroupHomomorphismByImages( H, H, List( B, img ), d.basis );  # sigma(b_i) -> a_i
    return PermList( List( eg, x -> Position( eg, Image( b, img( Image( a, x ) ) ) ) ) );
end );

InstallGlobalFunction( SidkiCyclicSubgroupGenerators, function( H )
    local d;
    d := RS_ElAbData( H );
    return Filtered( SidkiNonIdentityElements( H ), x ->
               First( d.coords( x ), v -> not IsZero( v ) ) = One( d.F ) );
end );

# x = u_i^j: returns [ i, j ].
BindGlobal( "RS_LineAndPower", function( d, u, x )
    local c, j;
    c := d.coords( x );
    j := First( c, v -> not IsZero( v ) );
    return [ Position( List( u, d.coords ), c / j ), IntFFE( j ) ];
end );

InstallGlobalFunction( SidkiSubgroupPermutingBijection, function( arg )
    local H, tau, d, u, eg, t, f;
    H := arg[1];  tau := arg[2];
    d := RS_ElAbData( H );
    u := SidkiCyclicSubgroupGenerators( H );
    eg := SidkiNonIdentityElements( H );
    if Length( arg ) > 2 then t := arg[3]; else t := ListWithIdenticalEntries( Length( u ), 1 ); fi;
    f := function( x )
        local ij;
        ij := RS_LineAndPower( d, u, x );
        return u[ ij[1]^tau ]^( ( t[ ij[1] ] * ij[2] ) mod d.p );
    end;
    return SidkiBijectionAsPermutation( H, f );
end );

InstallGlobalFunction( SidkiInducedPermutation, function( H, s )
    local d, u, eg, img, i, lines;
    d := RS_ElAbData( H );
    u := SidkiCyclicSubgroupGenerators( H );
    eg := SidkiNonIdentityElements( H );
    img := [];
    for i in [ 1 .. Length( u ) ] do
        lines := Set( [ 1 .. d.p - 1 ], j -> RS_LineAndPower( d, u,
                     eg[ Position( eg, u[i]^j )^s ] )[1] );
        if Length( lines ) > 1 then return fail; fi;
        img[i] := lines[1];
    od;
    return PermList( img );
end );

InstallGlobalFunction( SidkiSubgroupPermutationClasses, function( H )
    local d, u, A, G;
    d := RS_ElAbData( H );
    u := SidkiCyclicSubgroupGenerators( H );
    A := AutomorphismGroup( H );
    G := Group( Concatenation( [ () ], List( GeneratorsOfGroup( A ), a ->
             PermList( List( u, x -> RS_LineAndPower( d, u, Image( a, x ) )[1] ) ) ) ) );
    return DoubleCosetRepsAndSizes( SymmetricGroup( Length( u ) ), G, G );
end );
