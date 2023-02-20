## code to prepare `DATASET` goes here
library(devtools)
library(dplyr)
set.seed(123)
m=20
t=5

b0=b1=b2=2
rho=(-0.5)
mu=matrix(0,m,t)
y=matrix(0,m,t)
x1=matrix(0,m,t)
x2=matrix(0,m,t)
u=matrix(0,m,t)
eps=matrix(0,m,t)
vardi=matrix(0,m,t)
A=matrix(0,m,t)
B=matrix(0,m,t)
phi=matrix(0,m,t)
v=c()

for(i in 1:m){
  v[i]=rnorm(1,0,1)
  for(j in 1:t){
    x1[i,j]=runif(1,0,1)#auxiliary variable
    x2[i,j]=runif(1,0,1)
    eps[i,j]=rnorm(1,0,1)
  }
  u[i,1] <- eps[i,1]
  for(j in 2:t){
    u[i,j]=rho*u[i,j-1]+eps[i,j]
  }
  for(j in 1:t){
    phi[i,j]=rgamma(1,1,0.5)
    mu[i,j] <- exp(b0+b1*x1[i,j]+b2*x2[i,j]+v[i]+u[i,j])/(1+exp(b0+b1*x1[i,j]+b2*x2[i,j]+v[i]+u[i,j]))
    A[i,j] <- mu[i,j] * phi[i,j]
    B[i,j] <- (1-mu[i,j]) * phi[i,j]
    y[i,j]= rbeta(1,A[i,j],B[i,j])
    vardi[i,j]=(A[i,j]*B[i,j])/((A[i,j]+B[i,j])^2*(A[i,j]+B[i,j]+1))
    y[i,j] = ifelse(y[i,j]<1, y[i,j], 0.99999999)
    y[i,j] = ifelse(y[i,j]>0, y[i,j], 0.00000001)
  }
}

area <- c()
period <- c()
ydi <- c()
xdi1 <- c()
xdi2 <- c()
vardir <- c()
k = 0

for (i in 1:m) {
  for (j in 1:t) {
    k=k+1
    xdi1[k]<-x1[i,j]
    xdi2[k]<-x2[i,j]
    ydi[k]<-y[i,j]
    area[k] <- i
    period[k] <- j
    vardir[k] <-vardi[i,j]
  }
}

dataBetaAr1 <- data.frame(ydi,area,period,vardir,xdi1,xdi2)
# idx = sample(1:m, 4, replace = F)
# dataBetaAr1Ns = dataBetaAr1
# dataBetaAr1Ns = dataBetaAr1Ns%>%filter(area%in%idx)
dataBetaAr1Ns = dataBetaAr1
dataBetaAr1Ns[dataBetaAr1Ns$area==5, c(1,4)]=NA
dataBetaAr1Ns[dataBetaAr1Ns$area==11, c(1,4)]=NA
dataBetaAr1Ns[dataBetaAr1Ns$area==17, c(1,4)]=NA

set.seed(123)
m=20
t=5

b0=b1=b2=2
rho=0
mu=matrix(0,m,t)
y=matrix(0,m,t)
x1=matrix(0,m,t)
x2=matrix(0,m,t)
u=matrix(0,m,t)
eps=matrix(0,m,t)
vardi=matrix(0,m,t)
A=matrix(0,m,t)
B=matrix(0,m,t)
phi=matrix(0,m,t)
v=c()

for(i in 1:m){
  v[i]=rnorm(1,0,1)
  for(j in 1:t){
    x1[i,j]=runif(1,0,1)
    x2[i,j]=runif(1,0,1)
    eps[i,j]=rnorm(1,0,1)
  }
  u[i,1] <- eps[i,1]
  for(j in 2:t){
    u[i,j]=rho*u[i,j-1]+eps[i,j]
  }
  for(j in 1:t){
    phi[i,j]=rgamma(1,1,0.5)
    mu[i,j] <- exp(b0+b1*x1[i,j]+b2*x2[i,j]+v[i]+u[i,j])/(1+exp(b0+b1*x1[i,j]+b2*x2[i,j]+v[i]+u[i,j]))
    A[i,j] <- mu[i,j] * phi[i,j]
    B[i,j] <- (1-mu[i,j]) * phi[i,j]
    y[i,j]=rbeta(1,A[i,j],B[i,j])
    vardi[i,j]=A[i,j]*B[i,j]/((A[i,j]+B[i,j])^2*(A[i,j]+B[i,j]+1))
    y[i,j] = ifelse(y[i,j]<1, y[i,j], 0.99999999)
    y[i,j] = ifelse(y[i,j]>0, y[i,j], 0.00000001)
  }
}

area <- c()
period <- c()
ydi <- c()
xdi1 <- c()
xdi2 <- c()
vardir <- c()
k = 0

for (i in 1:m) {
  for (j in 1:t) {
    k=k+1
    xdi1[k]<-x1[i,j]
    xdi2[k]<-x2[i,j]
    ydi[k]<-y[i,j]
    area[k] <- i
    period[k] <- j
    vardir[k] <-vardi[i,j]
  }
}



dataPanelbeta <- data.frame(ydi,area,period,vardir,xdi1,xdi2)
dataPanelbetaNs = dataPanelbeta
dataPanelbetaNs[dataPanelbetaNs$area==3, c(1,4)]=NA
dataPanelbetaNs[dataPanelbetaNs$area==9, c(1,4)]=NA
dataPanelbetaNs[dataPanelbetaNs$area==12, c(1,4)]=NA

usethis::use_data(dataBetaAr1,overwrite = TRUE)
usethis::use_data(dataBetaAr1Ns,overwrite = TRUE)
usethis::use_data(dataPanelbeta,overwrite = TRUE)
usethis::use_data(dataPanelbetaNs,overwrite = TRUE)
