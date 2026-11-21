### 20150811 Creates a rewriting system for the group G^*_q, when G is a Pcpgroup.

LoadPackage("kbmag");KB_REW:=KBMAG_REW;
LoadPackage("polycyclic");
Read("Spres");






# Definir g
#g:= HeisenbergPcpGroup(1) ;
g:= DihedralPcpGroup(8) ;
q:=4;



gen_g:=List([1..Size(GeneratorsOfGroup(g))], i -> Concatenation("g_", String(i)) );
rel_mg:=Spres(g);
## creats a list of generators Gqast
gen_t:=[];
for i in [1..Size(rel_mg)] do 
	Add( gen_t, Concatenation("t_", String(i) ) );
od;
gen_Gqast:=Concatenation(gen_g,gen_t); 
Fgast:=FreeGroup(gen_Gqast);
AssignGeneratorVariables(Fgast); 
gen_g:=List(gen_g, EvalString);
gen_t:=List(gen_t, EvalString);
rel_g:= List(rel_mg, i -> [EvalString(i[1]), EvalString(i[2])]);
## relators Gqast

## retators of type r = t (P -> Q, P > Q ==> P > Qt).

rel_Gqast:=[];
for i in [1..Size(rel_g)] do
	Add( rel_Gqast, [rel_g[i][1], rel_g[i][2]*gen_t[i]]);
			
od;
### relators of type [ r, t ]
for i in gen_g do
	for j in gen_t do
		Add( rel_Gqast,[Comm(i,j), One(Fgast)] );
	od;
od;

### relators of type [ t_i, t_j }
for i in [1..Size(gen_t)] do
	for j in [1..Size(gen_t)] do
		if i < j then 
			Add( rel_Gqast, [Comm(gen_t[i],gen_t[j]), One(Fgast)] );
		fi;
	od;
od;

### relators of type t^q
for i in gen_t do
	Add(rel_Gqast, [i^q, One(Fgast)] );
od;

iso:=IsomorphismFpMonoid(Fgast);
mFgast:=Image(iso);
rel_mGqast:=List(rel_Gqast, i -> [Image(iso, i[1]), Image(iso,i[2])]);
mGqast:=mFgast/rel_mGqast;
RmGqast:=KBMAGRewritingSystem(mGqast);
mF:=FreeStructureOfRewritingSystem(RmGqast);


### ordem Wreathprod
lo:=[1..Size(GeneratorsOfMonoid(mF))/2];
lo:=Concatenation
	( 
	Reversed(  
		List(lo, i-> [2*i-1, 2*i] )  
		) 
	);


SetOrderingOfKBMAGRewritingSystem( RmGqast,"wreathprod", lo );


if IsConfluent(RmGqast)=false then 
	MakeConfluent(RmGqast);
fi;

######################### inicio Eliminar rel order = 1
Rw:=RmGqast;
mF:=FreeStructureOfRewritingSystem(Rw); 
gen_mF:=GeneratorsOfMonoid(mF);
gen_Fg:=
	( 
	List( [1..Size(gen_mF)/2], i -> String(gen_mF[2*i-1]) )
	);
Fg:=FreeGroup(gen_Fg);
gen_Fg:=GeneratorsOfGroup(Fg);
AssignGeneratorVariables(Fg);
rel_g:=[];
for i in Rules(Rw) do 
	Add
	( 
	rel_g,
	[ InternalWordToExternalWordOfRewritingSystem(Rw, i[1]), InternalWordToExternalWordOfRewritingSystem(Rw, i[2]) ]
	); 
od;
rel_g:=List(rel_g, i -> [String(i[1]), String(i[2])]);

rel_g:=List
	( rel_g , i -> 
		[
		ReplacedString(i[1], "<identity ...>", "g_1^0" )
		, 
		ReplacedString(i[2], "<identity ...>", "g_1^0" )
		]
	);

rel_g:=List(rel_g, i -> [EvalString(i[1]), EvalString(i[2])]);
rel_g:=Filtered(rel_g, i -> i <> [One(Fg), One(Fg)]);

ro1:=Filtered(rel_g, i -> Length(i[1])=1 and ExponentSyllable(i[1],1) >0);
ro1:=List(ro1, i -> i[1]);

sub_gen:=[[],[]];c:=1;
for i in [1..Size(gen_Fg)] do 
	if not  gen_Fg[i] in ro1 then 
		Add(sub_gen[1], gen_Fg[i]);
		Add(sub_gen[2], gen_Fg[c]);
		c:=c+1;
	fi;
od;

l:=rel_g;
for gen in ro1 do
	l:=Filtered(l, i -> PositionWord( i[1], gen, 1 ) = fail);
	l:=Filtered(l, i -> PositionWord( i[1], gen^-1, 1 ) = fail);
	l:=Filtered(l, i -> PositionWord( i[2], gen, 1 ) = fail);
	l:=Filtered(l, i -> PositionWord( i[2], gen^-1, 1 ) = fail);
od;
ls:=List(l, i -> [ MappedWord(i[1], sub_gen[1], sub_gen[2]), MappedWord(i[2], sub_gen[1], sub_gen[2]) ]);
ls:=List(ls, i -> [String(i[1]), String(i[2])]);

gen_Gqast:=List(sub_gen[2], String);
Fgast:=FreeGroup(gen_Gqast);
AssignGeneratorVariables(Fgast);
rel_Gqast:=List(ls, i -> [String(i[1]), String(i[2])]); 
rel_Gqast:=List
	( rel_Gqast , i -> 
		[
		ReplacedString(i[1], "<identity ...>", "g_1^0" )
		, 
		ReplacedString(i[2], "<identity ...>", "g_1^0" )
		]
	);
rel_Gqast:=List(rel_Gqast, i -> [EvalString(i[1]), EvalString(i[2])]);



iso:=IsomorphismFpMonoid(Fgast);
mFgast:=Image(iso);
rel_mGqast:=List(rel_Gqast, i -> [Image(iso, i[1]), Image(iso,i[2])]);
mGqast:=mFgast/rel_mGqast;
RmGqast:=KBMAGRewritingSystem(mGqast);
mF:=FreeStructureOfRewritingSystem(RmGqast);


### ordem Wreathprod
lo:=[1..Size(GeneratorsOfMonoid(mF))/2];
lo:=Concatenation
	( 
	Reversed(  
		List(lo, i-> [2*i-1, 2*i] )  
		) 
	);


SetOrderingOfKBMAGRewritingSystem( RmGqast,"wreathprod", lo );


if IsConfluent(RmGqast)=false then 
	MakeConfluent(RmGqast);
fi;
######################### fim Eliminar rel order = 1






#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################
AppendTo( 
	"always_delete_me.tex",
	"\\documentclass{book}", "\n",
	"\\usepackage{amssymb}", "\n",
	"\\usepackage{amsmath}", "\n",
	"\\usepackage{amsthm}", "\n",
	"\\usepackage{graphicx,xcolor}", "\n",
	"\\usepackage[normalem]{ulem}", "\n",
	"\\begin{document}", "\n"
	);
#AppendTo("always_delete_me.tex", "$${\\Large G}$$\\\\ \n", "Generators: $", GeneratorsOfMonoid( FreeStructureOfRewritingSystem(Rmg) ), " $, \\\\ \n"); 
#AppendTo("always_delete_me.tex", "Relators: \\\\  ");
#for i in rel_mg do 
#	AppendTo( "always_delete_me.tex", 
#	"$",
#	InternalWordToExternalWordOfRewritingSystem(Rmg, i[1])," = ",InternalWordToExternalWordOfRewritingSystem(Rmg, i[2])
#	,"$, \\\\ \n"	
#	);
#od;
#Print("\\vspace{1.5cm}");
PrintPcpPresentation(g);

AppendTo("always_delete_me.tex", "$${\\Huge G^{\\ast}_",q,"}$$\\\\ \n", "Generators: $", GeneratorsOfMonoid( FreeStructureOfRewritingSystem(RmGqast) ), " $, \\\\ \n"); 
AppendTo("always_delete_me.tex", "Relators:  \\\\");
for i in Rules(RmGqast) do 
	AppendTo( "always_delete_me.tex", 
	"$",
	InternalWordToExternalWordOfRewritingSystem(RmGqast, i[1])," = ",InternalWordToExternalWordOfRewritingSystem(RmGqast, i[2])
	,"$, \\\\ \n"	
	);
od;



AppendTo("always_delete_me.tex","\\end{document}", "\n");

Exec("sed  's/\\_\\([0-9]\\+\\)/\\_{\\1}/g;s/\\^\\([0-9-]\\+\\)/\\^{\\1}/g;s/<identity ...>/1/g;s/*//g'   always_delete_me.tex > rel.tex");
Exec("pdflatex rel.tex okular rel.pdf");
Exec("evince rel.pdf &");
Exec("rm always_delete_me.tex rel.tex *.aux *.log");
#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################
Read("Rw2Pcp");
cgast:=Rw2Pcp(RmGqast);
gqast:=PcpGroupByCollector(cgast);

Print("\n\n\nChange the group \"g\" and the integer \"q\" on the begining of the file \"RwGqast\".\n\"cgast\" is the  collector for the Pcpgroup  \"gqast\". \n");


















