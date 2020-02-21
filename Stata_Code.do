clear *
use "C:\Users\HXB180009\Desktop\Project\guns.dta"
describe
 
gen lnvio = ln(vio)
gen lnincarc_rate = ln(incarc_rate)
gen lndensity = ln(density) 

  
*Hypothesis Testing:

*1.  Avg Income across shall law state and non-shall law state:

anova lnavginc shall

*2.  Avg % of blacks across shall law state and non-shall law state:

anova lnpb1064 shall

*3.  Avg Density Vs Shall law states

anova lnden shall

*4.  Avg Violent rate across shall law state and non-shall law state

anova lnvio shall



***************Pooled OLS ********************
 *Model 1:
 * All the results will be inefficient. It does not consider serial correlation and hetersskedasticity. It does not 
 * take into account the unobserved heterogenity. The OLS are inefficient. They will still be unbiased and consistent.
 *Impact : incorrect standard errors.
 
 *dropped year,stateid, mur , rob, pw1064
 
 *1.1 Pooled OLs
reg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall
  *  shall = -.2794279  ,  .0274716 
predict ehat1, res
graph twoway scatter ehat1 lnvio, yline(0)

estat imtest, white
  
 *1.2 Pooled OLS with clusteres Robust standard errors
reg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall, vce(cluster stateid)
  *  shall = -.2794279  , .0789335 
  
  *** We can see the standard errors have increased in clustered robust model  which means..
  
 ********** Fixed Effects *********************
 
 
xtset stateid year
xtreg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall, fe
xtreg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall, fe cluster(stateid)

*** Entity and time fixed effect*******

xtreg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall i.year, fe
xtreg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall i.year, fe cluster(stateid)

testparm i.year


******* Random Effects **************
xtreg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall
xtreg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall, cluster(stateid)

 
 ********* Hausmann Test -- FE and RE ************
 
xtreg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall, fe
estimates store fixed

xtreg lnvio lnincarc_rate pb1064 pm1029 pop avginc lndensity  shall
estimates store random

hausman fixed random
***** difference = 0 --> no endogenity. Null is rejected. we should go with Fixed Effect. 
** In fixed effect Time & entity fixed is best as the testparam clearly ***





