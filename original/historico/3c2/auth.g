Reread("./csetgrp.gi");

f:=FreeGroup("a","b","c");

rh:=[f.1^2, f.2^2, f.3^2, Comm(f.1,f.2), Comm(f.1,f.3), Comm(f.2,f.3)];

h:=f/rh;
s7:=SymmetricGroup([2..8]);

eh :=Elements(h);

ah:=AutomorphismGroup(h);
gah:=SmallGeneratingSet(ah);
#gah:=GeneratorsOfGroup(ah);
l:=List(gah,x->List(eh,y->eh[Position(eh,y^x)]));
gl:=Group( List(l,x->PermListList(eh,x)));

cdrs:=DoubleCosetRepsAndSizes(s7,gl,gl);
cdr:=List(cdrs,x->x[1]);
