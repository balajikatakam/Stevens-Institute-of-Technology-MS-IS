*;
*;
* HATCO - Logistic Regression;
*;
    ods graphics on;
*;
options ls=80 ps=50 nodate pageno=1;
*;
ods all close;
ods pdf file = "E:\Multivariate Data Analysis BIA 652E\Assignments\Assignment 10 HATCO_Logistic_Regression.pdf";
*;
* Input HATCO ;
*;
Data HATCO;
Infile 'E:\Multivariate Data Analysis BIA 652E\Codes and Datasets\HATCO_Split60.txt' DLM = '09'X TRUNCOVER;
Input ID Split60 X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14;
*;
Data HATCO;
	Set HATCO (Keep = ID Split60 X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14);
	Label ID = 'ID - Identification Number'
		  Split60 = 'Split60'
		  X1 = 'X1 - Delivery Speed'
	      X2 = 'X2 - Price Level'
          X3 = 'X3 - Price Flexibility'
          X4 = 'X4 - Manufactures Image'
          X5 = 'X5 - Service'
          X6 = 'X6 - Salesforces Image'
          X7 = 'X7 - Product Quality'
		  X8 = 'X8 - Size of firm'
          X9 = 'X9 - Usage level'
		  X10 = 'X10 - Satisfaction level'
          X11 = 'X11 - Specification Buying'
		  X12 = 'X12 - Structure of Procurement'
          X13 = 'X13 - Type of Industry'
		  X14 = 'X14 - Type of buying situation'		 
;
*;
Proc Print Data = HATCO;
run;
*;

*;
* Simple Logistic Regression Model: X11 = X1 – X7;
*;

Proc Logistic Data = HATCO;
Model X11 = X1 X2 X3 X4 X5 X6 X7;
run;
*;
* Split 60-40 Variable: Split60;
*;

Data HATCO60;
	Set HATCO;
	If Split60 = 1;
run;
*;
Data HATCO40;
	Set HATCO;
	If Split60 = 0;
run;
*;
Proc Print Data = HATCO60;
*;
Proc Print Data = HATCO40;
run;
*;

*;
*Stepwise Analysis;
*;
Proc Logistic Data = HATCO60;
	Model X11(event='0') = X1 X2 X3 X4 X5 X6 X7 
						/ Selection=Stepwise SLEntry=0.05 SLStay=0.05 Details 
							LackFit RSquare CTable PProb =(0 to 1 by .10);
run;
*;
* Final Resultant Model and Output Model;
*;
Proc Logistic Data = HATCO60 OutModel=Logistic60;
	Model X11(event='0') = X3 X7
						/ LackFit RSquare CTable PProb =(0.40 to 0.60 by .01);
run;
*;

*;
* Original Split60 Logistic Model Fitted to Split40 validation Data;
*;
Proc Logistic InModel=Logistic60;
	Score Data = HATCO60 (Keep = X3 X7 X11) Out = HATCO60Score;
run;
*;
* Proc Freq Crosstabulations Original and Holdout Validation Datasets;
*;
Proc Print Data = HATCO60Score;
Proc Freq Data = HATCO60Score;
	Table F_X11 * I_X11;
run;
*;

Proc Logistic InModel=Logistic60;
	Score Data = HATCO40 (Keep = X3 X7 X11) Out = HATCO40Score;
run;

Proc Print Data = HATCO40Score;
Proc Freq Data = HATCO40Score;
	Table F_X11 * I_X11;
*;

Run;
ods pdf close;
Quit;
