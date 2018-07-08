*;
*;
* HBAT - Examining Your Data PROC Univariate;
*;
    ods graphics on;
*;
options ls=80 ps=50 nodate pageno=1;
*;
* Input HBAT ;
*;
Data HBAT;
Infile 'C:\Users\mdg22\OneDrive\Schule-Cours\Degree Programmes Attended\5. Stevens Institute of Technology\BIA-652 Multivariate Data Analytics\Assignments\Files for Assignments\HBAT_tabs.txt' DLM = '09'X TRUNCOVER;
Input ID X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22 X23;
*;


Data HBAT;
	Set HBAT (Keep = X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22);
	Label X1 = 'X1 - Customer Type'
	      X2 = 'X2 - Industry Type'
          X3 = 'X3 - Firm Size'
          X4 = 'X4 - Region'
          X5 = 'X5 - Distribution System'
		  X6 = 'X6 - Product Quality'
	      X7 = 'X7 - E-Commerce'
          X8 = 'X8 - Technical Support'
          X9 = 'X9 - Complaint Resolution'
          X10 = 'X10 - Advertizing'
          X11 = 'X11 - Product Line'
          X12 = 'X12 - Salesforce Image'
          X13 = 'X13 - Competitive Pricing'
          X14 = 'X14 - Warranty & Claims'
          X15 = 'X15 - New Products'
          X16 = 'X16 - Order & Billing'
          X17 = 'X17 - Price Flexibility'
          X18 = 'X18 - Delivery Speed'
		  X19 = 'X19 - Customer Satisfaction'
          X20 = 'X20 - Likelihood of Recommending HBAT'
          X21 = 'X21 - Likelihood of Future Purchases from HBAT'
          X22 = 'X22 - Percentage of Purchases from HBAT';
*;
Proc Print Data = HBAT;
run;
*;
* Proc Univariate - All Metric Variables X6 - X22;
/*Now perform a similar exploratory data analysis using X1-Customer Type as the */
/*Class Independent predictor variable and X8- Technical Support and X9- Complaint Resolution as the Dependent response variables,*/
*;
Proc Univariate Data = HBAT Normal Plot;
*    Var X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 X21 X22;
     Var X8 X9;
run;
*;
*;
* Proc Univariate - By Nonmetric Variables X1-X5 for All Metric Variables X6 - X22;
*;
*   Only Var X6 By X1 Illustrated ;
*;
Proc Sort Data = HBAT;
    By X1;
	run;
*;
Proc Univariate Data = HBAT Normal Plot;
    Var X8;
	By X1;
	ID X1;
	run;
*;
*   Only Var X7 By X1 Illustrated ;
*;
Proc Sort Data = HBAT;
    By X1;
	run;
*;
Proc Univariate Data = HBAT Normal Plot;
    Var X9;
	By X1;
	ID X1;
run;
*;
*;
*;
* GLM ANOVA Analysis ;
*;
*   Only Var X6 By X1 Illustrated ;
*;
Proc GLM Data = HBAT;
    Class X1;
	Model X8 = X1;
	Means X1;
	Means X1 / hovtest = levene hovtest = bf hovtest = bartlett;
run;
*;
*;
*   Only Var X7 By X1 Illustrated ;
*;
Proc GLM Data = HBAT;
    Class X1;
	Model X9 = X1;
	Means X1;
	Means X1 / hovtest = levene hovtest = bf hovtest = bartlett;
run;
*;
*;
*;
*	ods graphics off;
*;
*;
Run;
Quit;

