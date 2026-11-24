# O pacote carrega e declara a sua classe Info.
gap> START_TEST("carregar.tst");
gap> LoadPackage("SOR", false);
true
gap> IsInfoClass(InfoSOR);
true
gap> STOP_TEST("carregar.tst");
