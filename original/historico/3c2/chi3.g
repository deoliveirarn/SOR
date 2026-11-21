g:=AllSmallGroups(Size,2^3,IsElementaryAbelian,true);
g:=Image(IsomorphismFpGroup(g[1]));
pl:=FreeProduct([g,g,g]);
i1:=Embedding(pl,1);
i2:=Embedding(pl,2);
i3:=Embedding(pl,3);
gen:=GeneratorsOfGroup(g);sgen:=Size(gen);


######################
######################
######################
######################  Relacoes do tipo [h^x, h^x*psi] 

c12:=List(g,x-> Comm(Image(i1,x),Image(i2,x))  );
c13:=List(g,x-> Comm(Image(i1,x),Image(i3,x))  );
c23:=List(g,x-> Comm(Image(i2,x),Image(i3,x))  );

rel:=Concatenation([RelatorsOfFpGroup(pl),c12,c13,c23]);



c3:=FactorGroupFpGroupByRels(pl ,rel ); 
c:=FactorGroupFpGroupByRels(c3 ,[c3.7,c3.8,c3.9] );
c:=SimplifiedFpGroup(c);

######################
######################
######################
######################  Relacoes do tipo R1 = [x, y^psi2, x^psi]=[x^psi,y^psi2, x] 

r1:=[];
for x in g do
    for y in g do 
        Add(r1,Iterated([Image(i1,x),Image(i3,y),Image(i2,x)],Comm) /Iterated([Image(i2,x),Image(i3,y),Image(i1,x)],Comm)   );
        Add(r1,Iterated([Image(i2,x),Image(i1,y),Image(i3,x)],Comm) /Iterated([Image(i3,x),Image(i1,y),Image(i2,x)],Comm)   );
        Add(r1,Iterated([Image(i3,x),Image(i2,y),Image(i1,x)],Comm) /Iterated([Image(i1,x),Image(i2,y),Image(i3,x)],Comm)   );
    od;
od;

c3r1:=FactorGroupFpGroupByRels(pl ,Concatenation(rel,r1) );

#####################
######################
######################
######################  Relacoes do tipo R2 = [x, y^psi2, z^psi]=[x^psi,y^psi2, z] 

r2:=[];
for x in g do
    for y in g do 
        for z in g do
          Add(r2,Iterated([Image(i1,x),Image(i3,y),Image(i2,z)],Comm)/Iterated([Image(i2,x),Image(i3,y),Image(i1,z)],Comm)   );
          Add(r2,Iterated([Image(i2,x),Image(i1,y),Image(i3,z)],Comm)/Iterated([Image(i3,x),Image(i1,y),Image(i2,z)],Comm)   );
          Add(r2,Iterated([Image(i3,x),Image(i2,y),Image(i1,z)],Comm)/Iterated([Image(i1,x),Image(i2,y),Image(i3,z)],Comm)   );
        od;
    od;
od;

c3r2:=FactorGroupFpGroupByRels(pl ,Concatenation(rel,r2) );


######################
######################
######################
######################  Relacoes do tipo [D,L] 

d:=[];
for i in [1..sgen] do 
    for j in [i..sgen] do
        if i < j then
            Add(d, Comm(Image(i1,gen[i]),Image(i2,gen[j])));
            Add(d, Comm(Image(i1,gen[i]),Image(i3,gen[j])));
            Add(d, Comm(Image(i2,gen[i]),Image(i3,gen[j])));
        fi;
    od;
od;


l:=[];
for x in gen do 
    Add(l, Image(i1,x)^-1*Image(i2,x));
    Add(l, Image(i1,x)^-1*Image(i3,x));
    Add(l, Image(i2,x)^-1*Image(i3,x));
od;

rdl:=[];
for x in d do
    for y in l do 
        Add(rdl,Comm(x,y));
    od;
od;

c3dl:=FactorGroupFpGroupByRels(pl ,Concatenation(rel,rdl) );










              


