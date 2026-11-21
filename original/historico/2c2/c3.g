# Date: 2012
f:=FreeGroup("a1","a2","b1","b2","c1","c2");

################################################################################################################################
### o grupo H
##############################################################################################################################
rh:=[f.1^2,f.2^2, Comm(f.1,f.2),f.3,f.4,f.5,f.6];

h:=SimplifiedFpGroup(f/rh);

##############################################################################################################################
### relações do produto livre H*H^psi*H^(psi^2)
##############################################################################################################################
rpl:=[f.1^2,f.2^2,Comm(f.1,f.2),
      f.3^2,f.4^2,Comm(f.3,f.4),
      f.5^2,f.6^2,Comm(f.5,f.6)];;
          
##############################################################################################################################
### o grupo chi(H)
##############################################################################################################################
pir:=function(a,b)
return PreImagesRepresentative(a,b);
end;
p1:=GroupHomomorphismByImagesNC(f,h,GeneratorsOfGroup(f),[h.1,h.2,One(h),One(h),One(h),One(h)]);
p2:=GroupHomomorphismByImagesNC(f,h,GeneratorsOfGroup(f),[One(h),One(h),h.1,h.2,One(h),One(h)]);
p3:=GroupHomomorphismByImagesNC(f,h,GeneratorsOfGroup(f),[One(h),One(h),One(h),One(h),h.1,h.2]);

eh:=Difference(Elements(h),[One(h)]);
rc:= List(eh, x-> Comm(pir(p1,x),pir(p2,x)));
c:=SimplifiedFpGroup(f/Concatenation(rpl,rc,[f.5,f.6]));

##############################################################################################################################
### o grupo c3(H)
##############################################################################################################################
rc3:=List(eh, x->Comm(pir(p1,x),pir(p2,x)));
rc3:=Concatenation(rc3, List(eh, x->Comm(pir(p1,x),pir(p3,x))));
rc3:=Concatenation(rc3, List(eh, x->Comm(pir(p2,x),pir(p3,x))));
c3:=f/Concatenation(rpl,rc3);



##############################################################################################################################
### o grupo ce3(H)
##############################################################################################################################
gh:=GeneratorsOfGroup(h);
gh2:=Cartesian(gh,gh);gh2:=Intersection(List(gh2,x->Product(x)),List(gh2,x->Product(x)));

rce31:=List(gh, x->Comm(pir(p1,x),pir(p2,x)));
rce31:=Concatenation(rce31, List(gh, x->Comm(pir(p1,x),pir(p3,x))));
rce31:=Concatenation(rce31, List(gh, x->Comm(pir(p2,x),pir(p3,x))));

rce32:=List(gh2, x->Comm(pir(p1,x),pir(p2,x)));
rce32:=Concatenation(rce32, List(gh2, x->Comm(pir(p1,x),pir(p3,x))));
rce32:=Concatenation(rce32, List(gh2, x->Comm(pir(p2,x),pir(p3,x))));

ce3:=f/Concatenation(rpl,rce31,rce32);

phi:=GroupHomomorphismByImages(ce3,c3,GeneratorsOfGroup(ce3),GeneratorsOfGroup(c3));










