require(ggplot2)
require(nnet)
require(plyr)
require(XLConnect)

# Input -------------------------------------------------------------------

# From Seppo (26.9.2013)

# Muokkasin eilen suozonationin uudet 45 - 47 ajotulosteet käyttööni.  En saanut 
# muokkausta loppuun vaan linkitys suolaikkutietokantaan jäi tekemättä.  Se ensi 
# viikolla.

# Ohessa on nyt kuitenkin liitetiedostona excel-taulu jossa koottuna ajojen 
# 45 - 47 tulokset sekä kohteisiin liittyvät oleelliset suolaikkutiedot mm. 
# metsäkasvillisuusvyöhyke, elyt, suokasvillisuusvyöhyke sekä Hannan ja Pekan 
# tila-arviot.   Taulukko on nyt sellainen, että sen avulla pystyy tekemään 
# piirteiden tilastotarkasteluja.

# Huomaa, että taulukossa nyt zonatioinin kohteet riveinä,  Kohde voi jakautua 
# kahteen suolaikkuun suojelustatuksen mukaan.  Sarakkeissa muuttujanimen 
# lopussa  on ajoa merkitsevä lukuarvo.

# Minusta tarpeelliset tiedot on
#  * muuttujien perustilastotiedot
#  * Muuttujien frekvenssijakaumat
#  * Muuttujien jakaumat eri luokkamuuttujilla
#    * H-tila
#    * Ekologinen arvo
#    * MKVyöhyke
#    * SKVyöhyke
#    * ELY

# graafi voisi olla Box-plot. Voisi olla hyvä saada tietoa myös ekologisesta 
# arvosta ja H-tilasta MKvyöhykkeittäin ja SKVyöhykkeittäin. Muuttujien 
# esiintymiskartta olisi myös hyvä. Monimutkaisempiakin testejä voisi tehdä 
# mutta en oikein osaa esittää niitä.  Pitäisi vähän paremmin pohtia asiaa.


# Read in the data
patch.data <- readWorksheetFromFile("suoajot/SUOLAIKKU_ZON45-47.xlsx",
                                    "Taul1")

# Pre-processing ----------------------------------------------------------

# Protected and unprotected parts og a given patch are treated as separate 
# planning units in the prioritization. In order to compare Z results to other
# attributes of the patch database, PLU-specific Z results must be combined
# on per-patch basis. 

# For mean rank, use the higher rank (Q2)

# Create a new variable for sorting purposes
patch.data$rank_sum <- patch.data$SDSumm45 / (1.01 - patch.data$MeanRank45)

# Make factors out of integers
patch.data$EkologinenArvo <- factor(patch.data$EkologinenArvo)
patch.data$MKV_ALUE <- factor(patch.data$MKV_ALUE)
patch.data$SKV_ALUE <- factor(patch.data$SKV_ALUE)
patch.data$H_TILA <- factor(patch.data$H_TILA)
patch.data$YELY <- factor(patch.data$YELY)

# Analysis ----------------------------------------------------------------

# EkologinenArvo has levels 0, 1, 2, 3
table(patch.data$EkologinenArvo)

ddply(patch.data, .(EkologinenArvo), summarise,
                                     M=mean(rank_sum),
                                     SD=sd(rank_sum))

ddply(patch.data, .(EkologinenArvo), summarise,
                                     M=mean(MeanRank45),
                                     SD=sd(MeanRank45))

# Reorder the levels of EkologinenArvo to set the reference to 3 ??
patch.data$EkologinenArvo2 <- relevel(patch.data$EkologinenArvo, 
                                      ref = "3")

test <- multinom(EkologinenArvo2 ~ rank_sum, data = patch.data)
summary(test)

z <- summary(test)$coefficients/summary(test)$standard.errors
p <- (1 - pnorm(abs(z), 0, 1))/2

# Plotting ----------------------------------------------------------------

## AREA

# Make a facet histogram grid of the size distributions in different 
# vegetation zones (mkv)

h <- ggplot(patch.data, aes(AREA_PIX)) 
h + geom_histogram(binwidth=0.1) + facet_grid(MKV_ALUE ~ ., scales="free") + 
    ggtitle("Pinta-ala per alue")

# Same with boxplot, by forest vegetation zone
b <- ggplot(patch.data, aes(MKV_ALUE, log(AREA_PIX))) 
b + geom_boxplot() + ggtitle("Pinta-ala per MKV alue")

# Same with boxplot, by vegetation zone
b <- ggplot(patch.data, aes(SKV_ALUE, log(AREA_PIX))) 
b + geom_boxplot() + ggtitle("Pinta-ala per SKV alue")

# Boxplot by ecological value
b <- ggplot(patch.data, aes(EkologinenArvo, log(AREA_PIX))) 
b + geom_boxplot() + ggtitle("Pinta-ala per ekologinen arvo")

## EKOLOGINEN ARVO

h <- ggplot(patch.data, aes(EkologinenArvo)) 
h + geom_histogram(binwidth=0.1) + facet_grid(. ~ MKV_ALUE, scales="free") + 
  ggtitle("EkologinenArvo per MKV alue")

h <- ggplot(patch.data, aes(EkologinenArvo)) 
h + geom_histogram(binwidth=0.1) + facet_grid(. ~ SKV_ALUE, scales="free") + 
  ggtitle("EkologinenArvo per SKV alue")

## H_TILA (Hannan tila, kuntokerroksen rakentaminen)

h <- ggplot(patch.data, aes(H_TILA)) 
h + geom_histogram(binwidth=0.1) + facet_grid(. ~ MKV_ALUE, scales="free") + 
  ggtitle("H_TILA per MKV alue")

h <- ggplot(patch.data, aes(H_TILA)) 
h + geom_histogram(binwidth=0.1) + facet_grid(. ~ SKV_ALUE, scales="free") + 
  ggtitle("H_TILA per SKV alue")

## RANK SUM

# Boxplot by rank_sum
b <- ggplot(patch.data, aes(EkologinenArvo, log(rank_sum))) 
b + geom_boxplot() + ggtitle("Rank_sum per ekologinen arvo")

## MEAN RANK

# Boxplot by mean rank (larger of the two if protected/unprotected)
b <- ggplot(patch.data, aes(EkologinenArvo, MeanRank45)) 
b + geom_boxplot() + ggtitle("Mean rank per ekologinen arvo")

# Boxplot by mean rank (larger of the two if protected/unprotected)
b <- ggplot(patch.data, aes(H_TILA, MeanRank45)) 
b + geom_boxplot() + ggtitle("Mean rank per H_TILA")

# Plot mean rank ~ distribution sum and adjust the size of the point by
# patch area.

p <- ggplot(patch.data, aes(log(SDSumm45), MeanRank45,
                       label=NIMI, size=AREA_PIX))
p + geom_point() + scale_x_continuous(limits = c(-3, 1)) + 
  scale_y_continuous(limits = c(0.8, 1)) +
  geom_text(hjust=-0.1, vjust=0, size=3.2, colour="#606060") + scale_size_area()
