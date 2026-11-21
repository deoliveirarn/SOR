# The GAP package RoccoSidki

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
on the non-abelian tensor square. The original functions are kept, unchanged, in
the folder `original/`; the package rewrites them with documentation and tests.

**Status:** in development; not yet released. In preparation: a polycyclic
presentation of nu^q(G) and of the q-tensor square, extending tau^q(G).

## Contact

Ricardo Nunes de Oliveira, Universidade Federal de Goiás.
Issues: <https://github.com/deoliveirarn/RoccoSidki/issues>

## License

This package is distributed under the terms of the GNU General Public
License v2.0 or later (see `LICENSE`), the license used by GAP itself.
