#
# SOR: Rocco's nu(G), Sidki's chi(G) and related groups via free products with embeddings
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "SOR",
Subtitle := "Rocco's nu(G), Sidki's chi(G) and related groups via free products with embeddings",
Version := "0.0.1",
Date := "21/11/2026", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "Ricardo Nunes",
    LastName := "de Oliveira",
    Email := "ricardo@ufg.br",
    IsAuthor := true,
    IsMaintainer := true,
    Place := "Goiânia, Brazil",
    Institution := "Universidade Federal de Goiás",
    GitHubUsername := "deoliveirarn",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/deoliveirarn/SOR",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://deoliveirarn.github.io/SOR/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

AbstractHTML   :=  Concatenation(
  "The <span class=\"pkgname\">SOR</span> package computes Rocco's ",
  "group &nu;(G), its variant &nu;<sup>q</sup>(G), Sidki's weak commutativity ",
  "group &chi;(G), its n-copy version and its variants defined by bijections, ",
  "always as a quotient of a free product of copies of G that keeps the ",
  "embeddings of the copies of G and the related subgroups." ),

PackageDoc := rec(
  BookName  := "SOR",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Rocco's nu(G), Sidki's chi(G) and related groups via free products with embeddings",
),

Dependencies := rec(
  GAP := ">= 4.13",
  NeededOtherPackages := [ [ "polycyclic", ">= 2.16" ] ],
  SuggestedOtherPackages := [ [ "nq", ">= 2.5" ] ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [ "weak commutativity", "non-abelian tensor square",
              "Rocco group", "Sidki group", "free product" ],

));
