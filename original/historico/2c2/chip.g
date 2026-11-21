# Date: 2012
Read("auth.txt");


f:=FreeGroup("a1","a2","b1","b2");;


########################################################################################################
#####                           O grupo H = C2 x C2 ;
########################################################################################################

####Rela�es de grupo H;
rh:=[f.1^2, f.2^2,Comm(f.1,f.2), f.3,f.4];;
####O grupo H
h:=SimplifiedFpGroup(f/rh);;eh:=Elements(h);
####Homomorfismos de f->>H
p1:=GroupHomomorphismByImages(f,h,GeneratorsOfGroup(f),[h.1,h.2,One(h),One(h)]);;
p2:=GroupHomomorphismByImages(f,h,GeneratorsOfGroup(f),[One(h),One(h),h.1,h.2]);;

########################################################################################################
####                              Rela�es do produto livre H*H^psi
########################################################################################################

rpl:=[f.1^2, f.2^2, Comm(f.1,f.2),
      f.3^2, f.4^2, Comm(f.3,f.4)];;

#########################################################################################################
####                                O grupo chi(H)
#########################################################################################################
pir:=function(a,b)
return PreImagesRepresentative(a,b);
end;

#### Rela�es do grupo chi(H)

rc:=List([2..Size(eh)],i->Comm(pir(p1,eh[i]),pir(p2,eh[i])));; 
        
#### Grupo chi(H);
c:=f/Concatenation(rpl,rc);;

######################################################################################################### 
#### Grupos chip[i] c/ rela�es [h_i, h_(i^sigma[i])]; onde: h \in H, sigma[i] \in S_15, i \in [1..a] 
#########################################################################################################


rcp:=List(cdr,x->List([2..Size(eh)],i->Comm( pir(p1,eh[i]),pir(p2,eh[Position(eh,eh[i])^x]) )));

cp:=List(rcp,x->f/Concatenation(rpl,x));
sz:=List(cp,Size);

