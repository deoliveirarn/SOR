# Date: 2017-06-12
Read("tauq");
Read("tauq1");
g:=DihedralPcpGroup(6);
q:=2;




pcoll:=function(coll,nome, string)
local ro, sro, i, j, laux;

ro:=RelativeOrders(coll);
sro:=Size(ro);

LogTo();
LogTo(Concatenation(nome,".tex"));
Print( 
"\\documentclass{book}", "\n",
"\\usepackage{amssymb}", "\n",
"\\usepackage{amsmath}", "\n",
"\\usepackage{amsthm}", "\n",
"\\usepackage{graphicx,xcolor}", "\n",
"\\usepackage[normalem]{ulem}", "\n",
"\\begin{document}", "\n\n\n"
);

Print( 
"\\begin{center}\n",
"\\textcolor{red}{\\huge ",
string,
"}",
"\\end{center}\n"
);
for i in [1..sro] do
	Print( "$ g_{", i, "}^{", ro[i], "}= \\;\\;");
	laux:=GetPower(coll, i);
	if laux = [] then 
		Print( 1, "$ \n");
	else
		for j in [1..Size(laux)/2] do 
			if laux[2*j] <> 1 then
				Print( "g_{", laux[2*j -1], "}^{", laux[2*j], "}");
			else
				Print( "g_{", laux[2*j -1], "}");
			fi;
		od;
	fi;
	Print("\\\\ \n");  
od;

for i in [1..sro] do 
	for j in [i+1..sro] do
		laux:=GetConjugate(coll, j,i);
		if laux <> [j,1] then
			Print("$g_{", j, "}^{g_", i, "}=\\;");		
			for j in [1..Size(laux)/2] do 
				if laux[2*j] <> 1 then
					Print( "g_{", laux[2*j -1], "}^{", laux[2*j], "}");
				else 
					Print( "g_{", laux[2*j -1], "}");
				fi;
			od;
			Print("$\\\\ \n");
		fi; 
	od;
od;	

Print("\\end{document}", "\n");
LogTo();

Exec(Concatenation("pdflatex ", nome,".tex"));
Exec(Concatenation("evince ", nome,".pdf &"));
Exec(Concatenation("rm ", nome, ".log ", nome, ".aux ", nome, ".tex"));

end;


coll:=tauq(g,q);
pcoll(coll, "tmp","Construindo a apresenta\\c c\\~ao de $\\tau^q(G)$");
coll1:=tauq1(g,q);
pcoll(coll1, "tmp1","Apresenta\\c c\\~ao de $\\tau^q(G)$ via $\\nu^q(G),\\; |G| < \\infty.$");


