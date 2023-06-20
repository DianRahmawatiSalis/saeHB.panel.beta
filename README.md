
<!-- README.md is generated from README.Rmd. Please edit that file -->

# saeHB.panel.beta

Several functions are provided for small area estimation at the area
level using the hierarchical bayesian (HB) method with panel data under
beta distribution for variable interest. This package also provides a
dataset produced by data generation. The ‘rjags’ package is employed to
obtain parameter estimates. Model-based estimators involve the HB
estimators, which include the mean and the variation of the mean. For
the reference, see Rao and Molina (2015, <ISBN:978-1-118-73578-7>).

## Author

Dian Rahmawati Salis, Azka Ubaidillah

## Maintaner

Dian Rahmawati Salis <dianrahmawatisalis03@gmail.com>

## Function

- `RaoYuAr1.beta()` This function gives estimation of y using
  Hierarchical Bayesian Rao Yu Model under Beta distribution
- `Panel.beya()` This function gives estimation of y using Hierarchical
  Bayesian Rao Yu Model under Beta distribution when rho = 0

## Installation

You can install the development version of saeHB.panel.beta from GitHub
with:

``` r
# install.packages("devtools")
devtools::install_github("DianRahmawatiSalis/saeHB.panel.beta")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(saeHB.panel.beta)
data("dataPanelbeta")
dataPanelbeta <- dataPanelbeta[1:25,] #for the example only use part of the dataset
formula <- ydi~xdi1+xdi2 
area <- max(dataPanelbeta[,2])
period <- max(dataPanelbeta[,3])
result<-Panel.beta(formula,area=area, period=period ,iter.mcmc = 10000,thin=5,burn.in = 1000,data=dataPanelbeta)
```

Extract area mean estimation

``` r
result$Est
```

Extract coefficient estimation

``` r
result$coefficient
```

Extract area random effect variance

``` r
result$refVar
```

Extract MSE

``` r
MSE_HB<-result$Est$SD^2
summary(MSE_HB)
```

Extract RSE

``` r
RSE_HB<-sqrt(MSE_HB)/result$Est$MEAN*100
summary(RSE_HB)
```

## References

- Rao, J.N.K & Molina. (2015). Small Area Estimation 2nd Edition. New
  York: John Wiley and Sons, Inc.
- Torabi, M., & Shokoohi, F. (2012). Likelihood inference in small area
  estimation by combining time-series and cross-sectional data. Journal
  of Multivariate Analysis, 111, 213–221.
  <https://doi.org/10.1016/j.jmva.2012.05.016>
