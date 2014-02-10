library(ggplot2)

data.folder <- "/var/run/media/jlehtoma/OSDisk/Data/suoajot36_47/suoajot/45_20ha_abf_extra_w_cond_cmat_birds_inter_plu_hiermask_lsm/output"

# Koko maa

lsm.1 <- read.csv(file.path(data.folder,
                            "result_45_20ha_abf_extra_w_cond_cmat_birds_inter_plu_hiermask_lsmnwout1.csv"),
                  sep=";")

lsm.1$display <- lsm.1$Spp_distribution_sum / (1.01 - lsm.1$Mean_rank)
lsm.1.sorted <- lsm.1[with(lsm.1, order(-display)), ]


plot(lsm.1$Mean_rank~lsm.1$Spp_distribution_sum)
lm.lsm.1 <- lm(lsm.1$Mean_rank ~ lsm.1$Spp_distribution_sum)
abline(lm.lsm.1)
cor(lsm.1$Mean_rank,lsm.1$Spp_distribution_sum)

require(rCharts)

r1 <- rPlot(Mean_rank ~ Spp_distribution_sum, data = lsm.1, type = "point", 
            color = "gear")
r1$print("chart1")



p <- ggplot(lsm.1, aes(log(Spp_distribution_sum), Mean_rank,
                       label=Unit, size=Area))
p + geom_point() + scale_x_continuous(limits = c(-2, 1)) + 
  geom_text(hjust=-0.3, vjust=0) + scale_size_area()

# Etelä
data.folder <-  "/var/run/media/jlehtoma/OSDisk/Data/suoajot36_47/suoajot/46_20ha_abf_extra_w_cond_cmat_birds_inter_plu_mkv_etela_hiermask_lsm/output"
lsm.1.etela <- read.csv(file.path(data.folder,
                                  "result_46_20ha_abf_extra_w_cond_cmat_birds_inter_plu_mkv_etela_hiermask_lsmnwout1.csv"),
                        sep=";")
p1 <- ggplot(lsm.1.etela, aes(log(Spp_distribution_sum), Mean_rank,
                              label=Unit, size=Area))
p1 + geom_point() + scale_x_continuous(limits = c(-2, 1)) + 
  geom_text(hjust=-0.3, vjust=0) + scale_size_area()