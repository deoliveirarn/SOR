# The GAP package SOR

SOR stands for **S**idki, de **O**liveira and **R**occo.

Computes Rocco's group ν(G), its variant ν^q(G), Sidki's weak commutativity
group χ(G), its version χₙ(G) with n copies, and the variants χ(G, σ) defined
by bijections. All of them are built as quotients of the free product of copies
of G, so the input group may be given in any representation (permutation, pc,
pcp, matrix or finitely presented), and the embeddings of the copies of G are
kept, together with the related subgroups.

## Background

This package is a compilation of the GAP code that the author has been writing
since his doctoral studies under the supervision of Said N. Sidki (Universidade de
Brasília, 2007), and that he has used in his research on weak commutativity and
on the non-abelian tensor square, rewritten with documentation and tests.

**Status:** in development; not yet released. In preparation: a polycyclic
presentation of nu^q(G) and of the q-tensor square, extending tau^q(G).

## Installation

SOR is written in the GAP language only; it needs GAP 4.13 or later and the
package Polycyclic (included in the GAP distribution). Unpack the archive in the
`pkg` folder of your GAP installation, or in `~/.gap/pkg`, and type

```gap
gap> LoadPackage("SOR");
gap> C := SidkiChiGroup( SmallGroup( 32, 34 ) );;
gap> Size( SidkiR( C ) );
4
```

## Using SOR from SageMath

SageMath contains GAP, through its interface `libgap`, so SOR can be used from
Sage without changes, provided Sage's GAP is version 4.13 or later and has the
package Polycyclic (part of Sage's `gap_packages`). Put the folder `SOR` in a
directory that Sage's GAP searches for packages (for instance `~/.gap/pkg`), or
add the parent of a folder `pkg` containing it:

```python
sage: libgap.ExtendRootDirectories(["/path/to/dir/"])   # dir/pkg/SOR; if needed
sage: libgap.LoadPackage("SOR")
true
sage: G = libgap.SmallGroup(32, 34)
sage: C = libgap.SidkiChiGroup(G)
sage: libgap.SidkiR(C).Size()
4
```

The results are GAP objects (`libgap` elements); every function of the manual is
available as `libgap.FunctionName`. *This section has not yet been tested with a
current SageMath release.*

## Contact

Ricardo Nunes de Oliveira, Universidade Federal de Goiás.
Issues: <https://github.com/deoliveirarn/SOR/issues>

## License

This package is distributed under the terms of the GNU General Public
License v2.0 or later (see `LICENSE`), the license used by GAP itself.
