# Date: 2012
######
###### Criacao do grupo H e do Produto Livre H * \dot{H}.

f:=FreeGroup("a","b");
rel:=[f.1^n, f.2^n, Comm(f.1,f.2)];
h:=f/rel;



pl:=FreeProduct([h,h]);
i1:=Embedding(pl,1);
i2:=Embedding(pl,2);


######
###### O grupo de comutatividade fraca por iso.

rc:=List(h,x->Comm(Image(i1,x),Image(i2,x)));; 
c:= FactorGroupFpGroupByRels(pl, rc);

#####
##### Definicao do grupo de bijecoes de H.

eh:=Difference(Elements(h),[One(h)]);
sym:=SymmetricGroup(Size(eh));


#####
##### Versao permutacional dos automorfismos de H. 

ah:=AutomorphismGroup(h);
gah:=SmallGeneratingSet(ah);
l:=List(gah,x->List(eh,y->eh[Position(eh,y^x)]));
gl:=Group( List(l,x->PermListList(eh,x)));

#####
##### Calculo dos representatntes de classes duplas

#cdrs:=DoubleCosetRepsAndSizes(sym,gl,gl);
#cdr:=List(cdrs,x->x[1]);
#cdr:=List([1..5000],i->Random(sym));
cdr:=ConjugacyClass(sym, (1,2));

#####
##### Familia de grupo \chi( H, \sigma).

rcp:=List( cdr, p-> List(eh, x -> Comm(  Image(i1,x), Image(i2,eh[Position(eh,x)^p]) )  )   );
cp:=List(rcp,x-> FactorGroupFpGroupByRels(pl,x));


