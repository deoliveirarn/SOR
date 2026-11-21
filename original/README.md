# Original code

The GAP code from which this package was written: functions that the author,
Ricardo Nunes de Oliveira, has been writing since his doctoral studies under the
supervision of Said N. Sidki (Universidade de Brasília, 2007), and that he used in
his research papers. They are kept here as written, for reference and as a record;
**they are not loaded by the package**, and the package does not depend on them.

| Folder | What it is | Years |
|---|---|---|
| `historico/` | chi(H), chi_3(H) and chi(H, sigma) written by hand from a presentation of H (doctoral thesis); the method before the embeddings into the free product | 2007-2012 |
| `chi_bijecao/` | chi(G, sigma) for bijections sigma of G \ {1}, double cosets Aut(G)\Sym/Aut(G), cyclic case; chi with D(G) by the free product | 2012-2021 |
| `nu/` | nu(G) by the free product G * G with the two embeddings | 2019 |
| `nu_q/` | nu^q(G); `tauq_2017/`: a polycyclic presentation of tau^q(G) following Dias and Rocco | 2015-2017 |
| `chi_n/` | chi_n(G) with n copies; `ching` for p-groups | 2026 |

File names were given the extension `.g`; the contents are unchanged (except for
Windows line endings, normalized by git), apart from a first line `# Date: ...` added
in 2026. That date is the one written in the file by the author, when there is one;
otherwise it is the date of the author's copy of the file (the code in `historico/`
is from 2012). Comments are in Portuguese.
