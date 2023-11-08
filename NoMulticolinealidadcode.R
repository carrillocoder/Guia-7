# Guia 7

# NO MC

setwd("D:/Guia 7")

library(haven)

bdimp=read_dta("impuestos.dta")

attach(bdimp)



# Declaracion ST

pibs=ts(pibreal,start=c(1970))

ivas=ts(iva,start=c(1970))

tims=ts(timbre,start=c(1970))

aras=ts(arancel,start=c(1970))



# Regresion inicial

m1=lm(pibs~ivas+tims+aras)

summary(m1)



# Deteccion MC

plot(iva,timbre)

plot(iva,arancel)

plot(timbre,arancel)



# Deteccion con coeficiente de correlacion

cor(ivas,tims)

bdimp1=subset(bdimp,select=c(iva,timbre,arancel))

cor(bdimp1)

# ==> MC fuerte entre iva y timbre, r>0.7



# Deteccion con VIF (FIV)

library(car)

vif(m1) # Variance inflation factor

# ==> no se identifica MC fuerte

# Regresiones auxiliares
ra1=lm(ivas~tims+aras)
summary(ra1)
ra2=lm(tims~aras+ivas)
summary(ra2)
ra3=lm(aras~ivas+tims)
summary(ra3)


# Solucion MC: diferencias 

dpib=diff(pibs) # yt - yt-1

diva=diff(ivas)

darancel=diff(aras)

dtimbre=diff(timbre)

m3=lm(dpib~diva+darancel+dtimbre)

summary(m3)

cor(diva,dtimbre)



# Cortes transversales

iaran=(arancel-min(arancel))/(max(arancel)-min(arancel))

itimb=(timbre-min(timbre))/(max(timbre)-min(timbre))

inueva=(iaran+itimb)/2 # inueva se coloca como independiente

summary(iaran)

summary(itimb)

