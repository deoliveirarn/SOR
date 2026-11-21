Read("gest");

modify:=function(list,n)
local i;
if list=[] then
	return list;
elif Size(list) mod 2 = 0 then 
	for i in [1..Size(list)/2] do 
		list[2*i -1] := list[2*i -1] + n;
	od;
	return list;
else 
	return list; 
fi;
end;



tauq:=function(g,q)
local laux, epi, sg, ge, cgs, s_ge, ge_1, cge, iso, sge, ftl, st_ftl, st_g, i, j ;

laux:=gest(g,q);epi:=laux[1];
sg:=Size(GeneratorsOfGroup(g));
ge:=laux[2];
#cgs:=Cgs(ge);
#s_ge:=PcpSeries( ge );
#s_ge:=DerivedSeries( ge );
#s_ge:=EfaSeries( ge );
s_ge:=RefinedDerivedSeriesDown(ge);
ge_1:=PcpGroupBySeries(s_ge);
cge:=Collector(ge_1);
#iso:=GroupHomomorphismByImages(ge, ge_1, cgs, GeneratorsOfGroup(ge_1));
iso:=IsomorphismGroups(ge, ge_1);
cgs:=PreImage(iso, GeneratorsOfGroup(ge_1));
sge:=Size(GeneratorsOfGroup(ge_1));
ftl := FromTheLeftCollector( 2*sg + sge  );

######################
###################### Relações de G
######################


# Ajustando as ordens relativas para os geradores G
for i in [1..sg] do 
	SetRelativeOrder( ftl, i,  RelativeOrders( Collector(g) )[i] );
od;

#Ajustando as potencias  para os geradores G
for i in [1..sg] do 
	if GetPower(Collector(g), i ) <> [] then
		SetPower( ftl, i,  GetPower(Collector(g), i  ) );
	fi;
od;

#Ajustando os conjugados  para os geradores G
for i in [1..sg] do 
	for j in [i+1..sg] do 
		SetConjugate( ftl, j, i,   GetConjugate(Collector(g), j, i)   );
		if RelativeOrders( Collector(g))[i] = 0 then
			SetConjugate( ftl, j, -i,  GetConjugate(Collector(g), j, -i)  );
		fi;
#		if RelativeOrders( Collector(g))[j] = 0 then
#			SetConjugate( ftl, -j, i,  GetConjugate(Collector(g), -j, i)  );
#		fi;
#		if RelativeOrders( Collector(g))[i] = 0 and RelativeOrders( Collector(g))[j] = 0 then
#			SetConjugate( ftl, -j, -i,  GetConjugate(Collector(g), -j, -i)  );
#		fi;
	od;
od;

#Ajustando os comutadores  para os geradores G
#for i in [1..sg] do 
#	for j in [i+1..sg] do 
#		SetCommutator( ftl, j, i,   ShallowCopy(GenExpList( Comm(g.(j),g.(i))  )  )   );
#		SetCommutator( ftl, j, -i,  ShallowCopy(GenExpList( Comm(g.(j),g.(i)^-1) ) )  );
#	od;
#od;



######################
###################### Relações de G^\phi
######################

# Ajustando as ordens relativas para os geradores G^\phi
for i in [1..sg] do 
	SetRelativeOrder( ftl, i+sg,  RelativeOrders( ftl )[i] );
od;

#Ajustando as potencias  para os geradores G^\phi
for i in [1..sg] do 
	if GetPower(ftl, i) <> [] then 
		SetPower( ftl, i+sg,  modify(  GetPower(ftl, i), sg)   );
	fi;
od;

#Ajustando os conjugados  para os geradores G^\phi
for i in [1..sg] do 
	for j in [i+1..sg] do 
		SetConjugate( ftl, j+sg, i+sg,   modify(  GetConjugate(ftl, j, i), sg)   );
		if RelativeOrders( Collector(g))[i] = 0 then 
			SetConjugate( ftl, j+sg, -i-sg,  modify(  GetConjugate(ftl, j, -i), sg)  );
		fi;
#		if RelativeOrders( Collector(g))[j] = 0 then 
#			SetConjugate( ftl, -j-sg, i+sg,  modify(  GetConjugate(ftl, -j, i), sg)  );
#		fi;
#		if RelativeOrders( Collector(g))[i] = 0 and RelativeOrders( Collector(g))[j] = 0 then 
#			SetConjugate( ftl, -j-sg, -i-sg,  modify(  GetConjugate(ftl, -j, -i), sg)  );
#		fi;
	od;
od;

#Ajustando os comutadores  para os geradores G^\phi
#for i in [1..sg] do 
#	for j in [i+1..sg] do 
#		SetCommutator( ftl, j+sg, i+sg,   modify( ShallowCopy(GenExpList( Comm(g.(j),g.(i))  )  ), sg)   );
#		SetCommutator( ftl, j+sg, -i-sg,  modify( ShallowCopy(GenExpList( Comm(g.(j),g.(i)^-1) ) ), sg)  );
#	od;
#od;

######################
###################### Relações de G ^ G
######################

# Ajustando as ordens relativas para os geradores G ^ G
for i in [1..sge] do 
	SetRelativeOrder( ftl, i+2*sg,  RelativeOrders( cge )[i] );
od;

#Ajustando as potencias  para os geradores G ^ G
for i in [1..sge] do 
	if GetPower(cge, i) <> [] then
		SetPower( ftl, i+2*sg,  modify(  GetPower(cge, i), 2*sg)   ); 
	fi;  
od;

#Ajustando os conjugados  para os geradores G ^ G 
for i in [1..sge] do 
	for j in [i+1..sge] do 
		SetConjugate( ftl, j+2*sg, i+2*sg,   modify(  GetConjugate(cge, j, i), 2*sg)   );
		if RelativeOrders( Collector(ge))[i] = 0 then 
			SetConjugate( ftl, j+2*sg, -i-2*sg,  modify(  GetConjugate(cge, j, -i), 2*sg)  );    
		fi;  
#		if RelativeOrders( Collector(ge))[j] = 0 then 
#			SetConjugate( ftl, -j-2*sg, i+2*sg,  modify(  GetConjugate(cge, -j, i), 2*sg)  );    
#		fi;
#		if RelativeOrders( Collector(ge))[i] = 0 and RelativeOrders( Collector(ge))[j] = 0 then 
#			SetConjugate( ftl, -j-2*sg, -i-2*sg,  modify(  GetConjugate(cge, -j, -i), 2*sg)  );    
#		fi;
		
	od;
od;

#Ajustando os comutadores  para os geradores G ^ G
#for i in [1..sge] do 
#	for j in [i+1..sge] do 
#		SetCommutator( ftl, j+2*sg, i+2*sg,   modify( ShallowCopy(GenExpList( Comm(ge.(j),ge.(i))  )  ), 2*sg)   );
#		SetCommutator( ftl, j+2*sg, -i-2*sg,  modify( ShallowCopy(GenExpList( Comm(ge.(j),ge.(i)^-1) ) ), 2*sg)  ); 
#	od;
#od;

######################
###################### Relações (4) & (5) da def 4.14 (pag 64) da tese Ivonildes
######################

# Definindo relações (4) da def 4.14 (pag 64) da tese Ivonildes
for i in [1..sg] do
	for j in [i+1..sg] do
		SetCommutator(ftl, j+sg, i,  modify( ShallowCopy( 
						      GenExpList( 
						           Image(iso, 
							    Comm( PreImagesRepresentative( epi, g.(j) ) , PreImagesRepresentative( epi, g.(i) )  
                                                                ) )))   , 2*sg)); 
		if RelativeOrders( Collector(g))[i] = 0 then
			SetCommutator(ftl, j+sg, -i,  modify( ShallowCopy( 
						      GenExpList( 
						           Image(iso, 
							    Comm( PreImagesRepresentative( epi, g.(j) ) , PreImagesRepresentative( epi, g.(i)^-1 )  
                                                                ) )))   , 2*sg));  
		fi;
#		if RelativeOrders( Collector(g))[j] = 0 then
#			SetCommutator(ftl, -j-sg, i, modify( ShallowCopy( GenExpList( PreImagesRepresentative(epi, Comm( g.(j)^-1, g.(i) ) )) )  , 2*sg)); 
#		fi;
#		if RelativeOrders( Collector(g))[i] = 0 and RelativeOrders( Collector(g))[j] = 0 then
#			SetCommutator(ftl, -j-sg, -i, modify( ShallowCopy( GenExpList( PreImagesRepresentative(epi, Comm( g.(j)^-1, g.(i)^-1 ) )) )  , 2*sg)); 
#		fi;
	od;
od;

# Definindo relações (5) da def 4.14 (pag 64) da tese Ivonildes


for i in [1..sg] do
	for j in [1..sge] do
		SetConjugate( ftl, j+2*sg, i,  modify( ShallowCopy(      GenExpList(   Image(iso, cgs[j]^PreImagesRepresentative(epi, g.(i) ) )   )        ),  2*sg ) );
		SetConjugate( ftl, j+2*sg, i+sg,  modify( ShallowCopy(   GenExpList(   Image(iso, cgs[j]^PreImagesRepresentative(epi, g.(i) ) )   )        ),  2*sg ) );
		if RelativeOrders( Collector(g))[i] = 0 then 
			SetConjugate( ftl, j+2*sg, -i, modify( ShallowCopy(      GenExpList( Image(iso, cgs[j]^PreImagesRepresentative(epi, g.(i)^-1 )))    ),  2*sg ) );
			SetConjugate( ftl, j+2*sg, -i-sg, modify( ShallowCopy(   GenExpList( Image(iso, cgs[j]^PreImagesRepresentative(epi, g.(i)^-1 )))    ),  2*sg ) );
		fi;
#		if RelativeOrders( cge )[j] = 0 then 
#			SetConjugate( ftl, -j-2*sg, i, modify( ShallowCopy(      GenExpList( Image(iso, (cgs[j]^-1)^PreImagesRepresentative(epi, g.(i) )))    ),  2*sg ) );
#			SetConjugate( ftl, -j-2*sg, i+sg, modify( ShallowCopy(   GenExpList( Image(iso, (cgs[j]^-1)^PreImagesRepresentative(epi, g.(i) )))    ),  2*sg ) );
#		fi;
#		if RelativeOrders( Collector(g))[i] = 0 and RelativeOrders( cge )[j] = 0 then 
#			SetConjugate( ftl, -j-2*sg, -i, modify( ShallowCopy(      GenExpList( Image(iso, (cgs[j]^-1)^PreImagesRepresentative(epi, g.(i)^-1 )))    ),  2*sg ) );
#			SetConjugate( ftl, -j-2*sg, -i-sg, modify( ShallowCopy(   GenExpList( Image(iso, (cgs[j]^-1)^PreImagesRepresentative(epi, g.(i)^-1 )))    ),  2*sg ) );
#		fi;
	od;
od;

UpdatePolycyclicCollector(ftl);
return ftl;

end;

