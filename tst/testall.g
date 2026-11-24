#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups via free products with embeddings
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "SOR" );

TestDirectory(DirectoriesPackageLibrary( "SOR", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
