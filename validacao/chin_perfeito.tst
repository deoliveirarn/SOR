# Validacao a mao (pesada: ~25 s, ~6 GB): chi(3, A5) = T_3(SL(2,5)).
# Rodar:  gap -q   e depois   Test("validacao/chin_perfeito.tst");
gap> START_TEST("chin_perfeito.tst");
gap> LoadPackage("SOR", false);;
gap> H := AlternatingGroup( 5 );;
gap> C := SidkiChiNGroup( H, 3 );;
gap> ForAll( Combinations( [ 1 .. 3 ], 2 ), p -> ForAll( H, h ->
>      IsOne( Comm( h^Embedding( C, p[1] ), h^Embedding( C, p[2] ) ) ) ) );
true
gap> STOP_TEST("chin_perfeito.tst");
