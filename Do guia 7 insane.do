*guia 7 
*No MC
cd"D:\Guia 7"
clear all 
use impuestos 
tsset anio, yearly
*regresion inicial 
reg pibreal iva timbre arancel 
predict errores ,residuals
*deteccion 
scatter iva timbre 
twoway (sc iva timbre) (lfit iva timbre)
scatter iva arancel
scatter timbre arancel 
*correlacion 
corr iva timbre arancel
*factor inflacion de varianza 
reg pibreal iva timbre arancel 
estat vif 
reg iva timbre arancel 
reg timbre arancel iva
reg arancel iva timbre
*solucion 
gen dpibreal=d.pibreal 
gen diva=d.iva
gen darancel=d.arancel 
gen dtimbre=d.timbre
reg dpibreal diva darancel dtimbre
tabstat arancel timbre, s(min max)
gen iaran=(arancel-450556) / (1268391 - 450556) 
* se hace para cada variable 
corr errores  
