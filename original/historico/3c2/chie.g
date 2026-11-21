f:=FreeGroup("a","b","c","x","y","z");


###########################################################################################
#O grupo H = C2 x C2 x C2.
###########################################################################################
## relações para H
rh:= [f.1^2,f.2^2,f.3^2, Comm(f.1,f.2), Comm(f.1,f.3), Comm(f.2,f.3),
      f.4, f.5, f.6];

## o grupo h.
h:=SimplifiedFpGroup(f/rh);
eh:=Difference(Elements(h),[One(h)]);

## epimorfismo de f para H: Obter um trasversal para H nos geradores a, b, c 
p1:=GroupHomomorphismByImages(f,h,GeneratorsOfGroup(f),[h.1,h.2,h.3,One(h),One(h),One(h)]);

## epimorfismo de f para H: Obter um trasversal para H nos geradores x, y, w
p2:=GroupHomomorphismByImages(f,h,GeneratorsOfGroup(f),[One(h),One(h),One(h),h.1,h.2,h.3]);

pir:=function(u,v);
return PreImagesRepresentative(u,v);
end;

##########################################################################################
#Relações para o produto livre H*H^psi.
##########################################################################################
rpl:=[f.1^2,f.2^2,f.3^2, Comm(f.1,f.2), Comm(f.1,f.3), Comm(f.2,f.3),
      f.4^2,f.5^2,f.6^2, Comm(f.4,f.5), Comm(f.4,f.6), Comm(f.5,f.6) ];

##########################################################################################
#O grupo c(H)
##########################################################################################

## relações do tipo [h,h^psi]=1
rc:=List(eh, x-> Comm(pir(p1,x),pir(p2,x)));

## o grupo c(h)
c:=f/Concatenation(rpl,rc);

##########################################################################################
#O grupo ce(h)
##########################################################################################

gen:=GeneratorsOfGroup(h);
l:=Cartesian(gen,gen);
g2:=[];
for x in l do g2:=Union(g2,[Product(x)]);od;

## relações do tipo [gen,gen^psi]
rce1:=List(gen, x->Comm(pir(p1,x),pir(p2,x)));

## relações do tipo [ gen1*gen2, (gen1*gen2)^psi) ]
rce2:=List(g2, x->Comm(pir(p1,x),pir(p2,x)));

## o grupo ce(H)
ce:=f/Concatenation(rpl,rce1,rce2);

#########################################################################################
#Epimorphismo natural phi: ce(H) ---->> c(H). 
#########################################################################################
phi:=GroupHomomorphismByImages(ce,c,GeneratorsOfGroup(ce),GeneratorsOfGroup(c));
k:=Kernel(phi);
x:=Comm(ce.1*ce.2*ce.3,ce.4*ce.5*ce.6);
n:=Group([x,x^ce.1,x^ce.2,x^ce.3]);
y:=(Iterated([ce.1,ce.6,ce.2],Comm)^-1)*Iterated([ce.1,ce.6,ce.5],Comm);
m:=Group([y,y^ce.1,y^(ce.1*ce.2),y^(ce.1*ce.3)]);

y1:=(Iterated([ce.1,ce.6,ce.5],Comm)^-1)*(Iterated([ce.1,ce.6,ce.2],Comm)^-1);



