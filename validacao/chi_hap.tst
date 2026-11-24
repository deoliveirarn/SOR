# Validacao a mao (nao roda no CI: o HAP imprime avisos ao carregar).
# Rodar:  gap -q   e depois   Test("validacao/chi_hap.tst");
# Ordem de chi(G) contra o WeakCommutativityGroup do HAP (so o grupo, sem mergulhos).
# Sem o HAP instalado, o teste passa sem comparar.
gap> START_TEST("chi_hap.tst");
gap> LoadPackage("SOR", false);;
gap> temHAP := TestPackageAvailability( "hap" ) <> fail;;
gap> nivel := InfoLevel( InfoWarning );;  SetInfoLevel( InfoWarning, 0 );;
gap> if temHAP then LoadPackage( "hap", false : OnlyNeeded ); fi;
gap> SetInfoLevel( InfoWarning, nivel );;
gap> Compara := id -> Size( SidkiChiGroup( SmallGroup( id ) ) ) =
>      Size( Image( EpimorphismPGroup(
>        ValueGlobal( "WeakCommutativityGroup" )( SmallGroup( id ) ),
>        PrimePGroup( SmallGroup( id ) ) ) ) );;
gap> not temHAP or ForAll( [ [8,3], [8,4], [16,3], [27,3], [32,6] ], Compara );
true
gap> STOP_TEST("chi_hap.tst");
