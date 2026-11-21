# O pacote carrega e declara a sua classe Info.
gap> START_TEST("carregar.tst");
gap> LoadPackage("RoccoSidki", false);
true
gap> IsInfoClass(InfoRoccoSidki);
true
gap> STOP_TEST("carregar.tst");
