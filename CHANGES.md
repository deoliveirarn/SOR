# Changes in the RoccoSidki package

## Unreleased
  - `SidkiChiGroup( G )` for finite p-groups in any representation, keeping the
    embeddings (`Embedding( C, 1 )`, `Embedding( C, 2 )`) and `SidkiPsi( C )`.
  - `SidkiChiGroup` also for finite solvable groups (largest solvable quotient).
  - Subgroups `SidkiD`, `SidkiL`, `SidkiW`, `SidkiR`, `SidkiL1`, `SidkiL2` of chi(G)
    and `RoccoTheta`, `RoccoUpsilon1/2/3`, `RoccoDelta` of nu(G), with tests of the
    published identities and of nu(G)/Delta(G) ~ chi(G)/R(G).
  - `RoccoNuGroup( G )` for finite solvable and polycyclic groups, with
    `Embedding( N, 1 )`, `Embedding( N, 2 )` and `RoccoPhi( N )`: Rocco (1994)
    relations on an AG-system for p-groups, `NonAbelianTensorSquarePlus` of
    Polycyclic otherwise.
  - `RoccoTauGroup( G, q )`: tau^q(G) = nu^q(G)/Delta^q(G) by the consistent
    polycyclic presentation of Dias and Rocco (2020), for polycyclic G and q >= 0,
    with `Embedding` and `RoccoExteriorSquareQ` (G ^q G).
  - Manual chapters "How the groups are built" and "The weak commutativity group".

## 0.0.1 (2026-11-21)
  - Package skeleton.
