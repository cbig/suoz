## Tuotantoajot

_Tuotantoajot_ ovat variantteja, jotka lopulta ovat valikoituneet lopullisksi ajoiksi. Nämä ajot siis edustavat varsinaisia tuloksia. Variantit on selostettu tarkemmin alempana.

`42_abf_extra_w_cond_cmat_birds_inter_hiermask_lsm`

## Kaikki variantit 

Pilottien 2 ja 3 aikana ajettiin suuri joukko ajoja, jotka on listattu tiedoksi alla. Huomaa, että tässä repositoriossa on ajotiedostoja ainoastaan variantista 42 eteenpäin.

### Pilotti 2

**Habitaattiluokat (n=4)**

1 ABF  
2 ABF + painot  
3 ABF + painot + kunto  
4 ABF + painot + kunto + kytk.matriisi  
5 ABF + painot + kytk.matriisi  
	
**Habitaattiluokat + lisämääreet (n=8)** 

6 ABF  
7 ABF + painot  
8 ABF + painot + kunto  
9 ABF + painot + kunto + kytk.matriisi  
10 ABF + painot + kytk.matriisi  

### Pilotti 3

**Habitaattiluokat + lisämääreet 1 + lisämääreet 2 (n=10-20)**

11 ABF + painot + kunto + kytk.matriisi + vmi (2 piirettä: lehtipuukuutiot + kokonaiskuutiot turvemaalla)  
12 ABF + painot + kunto + kytk.matriisi + vmi + plu (planning units -> valintayksiköt, ts. laikkurajat ID:n perusteella -> laikkukohtainen prioriteetti)  
13 ABF + painot + kunto + kytk.matriisi + vmi + plu + linnut (10 suolintulajia LTKM:n atlas-tiedoista)  
14 ajo 5 + planning units  
15 ajo 10 + planning units  
16 ajo 9 + ADMU  
17 ajo 13 + ADMU  
18 ajo 13 - vmi  
19 ajo 9 + uudet lisäpiirteet (N=6)  
+ avosuot/puuttomat suot
+ lehtimetsä
+ sekametsä
+ havumetsä
+ harvapuustoinen metsä (10-30% latvusp.)
+ harvapuustoinen metsä (<10% latvusp.)

20 ajo 19 + suomatriisin määrä  
+ ojittamattoman ja ojitetun suon määrä 5 km:n säteellä

21 ajo 20 + linnut (N = 12)  
22 ajo 21 + planning units  
23 ajo 21 + interaktiokytk.  
+ tietyt lintulajit (jänkäsirriäinen, jänkäkurppa, kapustarinta, suokukko, mustaviklo, metsähanhi) kytketty vaikeakulkuisiin soihin, alfa lasktettu 2:lla kilometrillä  
+ "vaikeakulkuiset suot"-piirteellä (suo_vaik100.img) itsellääin paino = 0  

24 ajo 23 +  planning units

**Uudet aineistot 20-50ha laikuilla**	

25 ajo 19  
+ Corinen puustolisäpiirteet linkattu kuntokerrokseen
+ muuttunut: painot (piirteet)

26 ajo 25 + planning units  
27 ajo 25 + planning units + hierarkinen maski  
28 ajo 26 + maski ("etelä"-vyöhyke)  
29 ajo 26 + maski ("pohjois"-vyöhyke)  
30 ajo 23  
+ Corinen puustolisäpiirteet linkattu kuntokerrokseen
+ muuttunut: painot (piirteet + linnut)

31 ajo 30 + planning units  
32 ajo 31 + hierarkinen maski  
33 ajo 31 + maski ("etelä"-vyöhyke)  
34 ajo 31 + maski ("pohjois"-vyöhyke)  
35 ajo 33 + plu  

**Uudet ajot uudella PLU-jaolla, LSM-jälkiprosessoinnilla ja Zonation-versiolla 3.1.7**

36 30  
37 36 + maski ("etelä"-vyöhyke)  
38 36 + maski ("pohjoinen"-vyöhyke)  
39 31  
40 33  
41 34  
42 36 + hierarkkinen maski  
43 37 + hierarkkinen maski  
44 38 + hierarkkinen maski  
45 32  
46 33 + hierarkkinen maski  
47 34 + hierarkkinen maski  

### Nimikoodien merkitykset

`ABF/CAZ` = Zonationin käyttämä analyysimetodi. Additive Benefit Function suosii alueita, joilla on runsaasti piirteitä, Core Area Zonation puolestaan alueita, joissa on harvinaisia piirteitä

`painot` 	= analyysiversiossa on painot mukana kaikille piirteille (löytyy tiedostosta variantit.xlsx)

`kytk.matriisi` = kytkeytyvyysmatriisi mukana. Kaikkien (paikkatieto)piirteiden (n=18) välille on laskettu kytkeytyvyysvasteet (1.0 = täysin kytkeytynyt, 0.0 = ei ollenkaan kytkeytynyt). Esimerkiksi jos KA_KRARAJ ja KA_KRAR välinen kytkeyvyys on 1.0 (oikeasti 0.9), on kyseessä kytkeytyvyyden näkökulmasta sama habitaatti. 0.0 taas tarkoittaisi, että kyseisessä habitaatissa elävä lajisto ei esiinny lainkaan toisessa habitaatissa. (löytyy tiedostosta suolaikku_kytkeytyneisyysmatriisi_20110613.xlsx)

`hallinnolliset yksiköt` = priorisoinnista huomioidaan globaalin (koko tarkastelualueen) tasapainon sekä paikkatietopiirteiden painojen lisäksi paikallisia (keidas- ja aapasuovyöhykkeet) vastaavia arvoja.

`reunakorjaus` = kytketyvyyden kannalta habitaatit voidaan jakaa haitallisiin (estää lajiston liikkumista) sekä haitattomaan habitaattiin (ei haittaa mutta ei edistäkään). Tässä analyysivariantissa vesistöt sekä tarkastelualueen ulkopuolinen alue on laskettu kytkeytyvyydelle haitattomaksi habitaatiksi. Näin ollen vesistöjen rannat sekä lähellä tarkastelualueen reunaa olevat alueet eivät saa sakkoa ainakaan kytkeytyvyyden takia. (ei käytössä toistaiseksi)

`suojelualueiden läheisyys` = interaktio (vuorovaikutus) suojelualueilla sekä niiden ulkopuolella olevan habitaatin välillä. Toisin sanoen kytkeytyvyys suojelualueilta ulos päin. Vaikutuksen voimakkuus riippuu siitä, millaista habitaattia suojelualueella on, eli pelkkä suojelualue sellaisenaan ei riitä voimakkaan vaikutuksen aiheuttajaksi. Vaikutuksen voimakkuuden määrittelyssä on käytetty lajiston keskimääräistä 5 km:n dispersaalikykyä. (ei käytössä toistaiseksi)

`suojelualueet maskattu sisään` = Zonation on pakotettu käsittelemään ensin kaikki muut alueet ja vasta viimeiseksi suojelualueet. Ts. huippuprioriteetit osuvat varmasti suojelualueille. Analyysivariantin merkitys on tarkastella suojelualueiden laatua suhteessa muuhun maisemaan, mutta myös mikä olisi optimaalinen tapaa laajentaa suojelualueita. (ei käytössä toistaiseksi)

#### Esimerkkitiedosto 

`9_abf_w_cond_cmat_admu_ec_cres_mask_spp.dat`  

`9` = ID-numero  
`abf` = käytetty Z-metodi, voi olla caz (core area zonation) tai abf (additive benefit function)  
`w` = painotukset käytössä  
`cond` = "condition", kuntopiirre käytössä (ojitus)  
`cmat` = "connectivity matrix", kytkeytyvyys metsätyyppien välillä  
`admu` = "administrative units", hallinnolliset yksiköt  
`ec` = "edge correction" reunakorjaus     
`cres` = "connectivity reserves", kytkeytyvyys suojelualueisiin  
`mask` = maski käytössä  
`spp` = lajitietoja mukana  
