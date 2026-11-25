# Changes in the SOR package

## 0.1.0 (2026-11-24)
  - First public version (preliminary).
  - `SidkiDiagonalRepresentation( H, n )`: the diagonal representation of chi_n(H)
    in H^(2^n-1) from the Hamming codes (D. Savchuk, appendix to arXiv:2610.07330).
  - Package renamed from RoccoSidki to SOR (Sidki, de Oliveira, Rocco); the Info
    class is now `InfoSOR`.
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
  - `SidkiChiModRGroup( G )` = chi(G)/R(G) = tau(G) for polycyclic G, and
    `SidkiChiGroup` for infinite 2-generated pcp groups (R(G) = 1,
    Kochloukova-Mendonca 2021, Lemma 9.3).
  - `SidkiChiModWGroup( G )` = T(G) ~ chi(G)/W(G) inside G x G x G (Sidki 1980),
    for any group; `SidkiChiGroup` uses it when G is 2-generated with M(G) = 1
    (W/R ~ M(G), Rocco 1982), also for non-solvable groups (e.g. PSL(2,8)).
  - `SidkiChiNGroup( H, n )` = chi(n,H) for finite p-groups and perfect groups
    (T_n(H~)), and `SidkiChiMotherGroup( H, n )` = chi_n(H) as an fp group, after
    Sidki, Rocco, de Oliveira, arXiv:2610.07330.
  - `SidkiHybridGroup( H )` = Q(H) = chi^2(H)/N_0, the largest common quotient of
    chi^2(H) and chi_4(H) (arXiv:2610.07330), with the four embeddings.
  - `SidkiChiGroup` for finite perfect groups, chi(H) = T(H~) (Sidki 1980, 4.4.1).
  - Second argument to choose the method: `SidkiChiGroup( G, method )` ("auto",
    "fp", "T", "perfect", "tau", "pquotient", "solvable") and
    `RoccoNuGroup( G, method )` ("auto", "fp", "pquotient", "polycyclic"); "fp"
    gives the finitely presented group for any finite G. Each method checks the
    hypothesis of its theorem.
  - `SidkiChiHatProjection( C )` now maps onto the finitely presented chi(G), so
    it exists for every finite G; `SidkiChiHatProjection( C, method )` for the
    other methods.
  - Manual section "Time limits" (`IO_CallWithTimeout` of the IO package).
  - Manual chapters "How the groups are built" and "The weak commutativity group".

## 0.0.1 (2026-11-21)
  - Package skeleton.
