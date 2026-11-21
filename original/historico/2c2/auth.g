# Date: 2012
#Reread("csetgrp.gi");

f:=FreeGroup("a","b");

rh:=[f.1^2, f.2^2,Comm(f.1,f.2)];

h:=f/rh;
s3:=SymmetricGroup([2..4]);

eh :=Elements(h);

ah:=AutomorphismGroup(h);
gah:=SmallGeneratingSet(ah);
#gah:=GeneratorsOfGroup(ah);
l:=List(gah,x->List(eh,y->eh[Position(eh,y^x)]));
gl:=Group( List(l,x->PermListList(eh,x)));

cdrs:=DoubleCosetRepsAndSizes(gl,s3,gl);
cdr:=List(cdrs,x->x[1]);
