# Date: 2026-04-16
#############################################################################
# 1. Carregamento de Dependências
#############################################################################
Read("chin");
Read("ching");

#############################################################################
# 2. Construção da Lista de Grupos
#############################################################################
l := [];
for p in [3,5,7,11] do
    for k in [2,3,4,5,6] do
        n := p^k;
        l := Concatenation(l,
            Filtered(
                AllSmallGroups(n, IsAbelian, true, IsElementaryAbelian, false),
                G -> Length(MinimalGeneratingSet(G)) = 2
            )
        );
    od;
od;

#############################################################################
# 3. Função AC Atualizada (Subgrupo, Ordem, Posto, Estrutura e Geradores)
#############################################################################
AC := function(d)
    local r, info;

    info := function(grp)
        return rec(
            Order := Size(grp),
            Rank  := Length(MinimalGeneratingSet(grp)),
            Desc  := StructureDescription(grp),
            Gens  := GeneratorsOfGroup(grp) # Captura os geradores
        );
    end;

    r := rec();

    # Comutadores D com D
    r.CD_D12_D13 := info(CommutatorSubgroup(d.D12, d.D13));
    r.CD_D12_D23 := info(CommutatorSubgroup(d.D12, d.D23));
    r.CD_D13_D23 := info(CommutatorSubgroup(d.D13, d.D23));

    # Comutadores L com L
    r.CL_L12_L13 := info(CommutatorSubgroup(d.L12, d.L13));
    r.CL_L12_L23 := info(CommutatorSubgroup(d.L12, d.L23));
    r.CL_L13_L23 := info(CommutatorSubgroup(d.L13, d.L23));

    # Comutadores D com L (CDL)
    r.CDL_D12_L12 := info(CommutatorSubgroup(d.D12, d.L12));
    r.CDL_D12_L13 := info(CommutatorSubgroup(d.D12, d.L13));
    r.CDL_D12_L23 := info(CommutatorSubgroup(d.D12, d.L23));

    r.CDL_D13_L12 := info(CommutatorSubgroup(d.D13, d.L12));
    r.CDL_D13_L13 := info(CommutatorSubgroup(d.D13, d.L13));
    r.CDL_D13_L23 := info(CommutatorSubgroup(d.D13, d.L23));

    r.CDL_D23_L12 := info(CommutatorSubgroup(d.D23, d.L12));
    r.CDL_D23_L13 := info(CommutatorSubgroup(d.D23, d.L13));
    r.CDL_D23_L23 := info(CommutatorSubgroup(d.D23, d.L23));

    return r;
end;

#############################################################################
# 4. Função de Impressão Formatada (com geradores)
#############################################################################
PrintRecordByLine := function(r)
    local names, n, item;
    names := RecNames(r);
    for n in names do
        item := r.(n);
        Print(n, " := Group( ", item.Gens, " )");
        Print("   -> Ordem: ", item.Order, " | Posto: ", item.Rank, " | Estrutura: ", item.Desc, "\n\n");
    od;
end;

#############################################################################
# 5. Execução e Log
#############################################################################
LogTo("teste_detalhado.txt");

for k in [1..Size(l)] do 
    d := DL(ching(l[k], 3)); 
    
    Print("====================================================================\n");
    Print("GRUPO H: ", StructureDescription(l[k]), " ID: ", IdGroup(l[k]), "\n");
    Print("====================================================================\n");
    
    PrintRecordByLine(AC(d));
    Print("\n");
od;

LogTo();
