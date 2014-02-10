require(ggplot2)
require(XLConnect)

source("R/suoz_utilities.R")

options(xtable.type = 'html', scipen = 8, digits = 2)

suoz.theme <- theme(plot.title=element_text(face="bold", size=20),
                    axis.title.x=element_text(size=14),
                    axis.title.y=element_text(size=14),
                    axis.text.x=element_text(size=12),
                    axis.text.y=element_text(size=12),
                    legend.text=element_text(size=12),
                    legend.title=element_text(size=12))

# Read in the data
patch.data <- readWorksheetFromFile("suoajot/SUOLAIKKU_ZON45-47.xlsx",
                                    "Taul1")

# Get description on the analysis features
feature.desc <- readWorksheetFromFile("suoajot/analyysipiirteet.xlsx",
                                      "Analyysipiirteet")

# Read in the spp file from variant 45 to get weights used
feature.spp <- read.table("suoajot/45_20ha_abf_extra_w_cond_cmat_birds_inter_plu_hiermask_lsm/45_20ha_abf_extra_w_cond_cmat_birds_inter_plu_hiermask_lsm.spp")
# Get the feature name from feature description
feature.spp <- cbind(feature.desc[,1], feature.spp)
colnames(feature.spp) <- c("feature", "weight", "alpha", "par1", "par2", "z",
                           "rasterpath")

# Read in the groups file and the attach the group information to the spp
# dataframe
groups <- read.table("suoajot/45_20ha_abf_extra_w_cond_cmat_birds_inter_plu_hiermask_lsm/45_groups.txt")
feature.spp$group <- groups[,1]
feature.spp$group <- factor(feature.spp$group)
feature.spp$feature <- factor(feature.spp$feature, feature.spp$feature)

# Append the groups info also to the feature description
feature.desc$group  <- feature.spp$group

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

patch.data$SUOJELU <- factor(patch.data$SUOJELU, levels=c("E", "S"),
                             labels=c("Ei suojeltu", "Suojeltu"))

# Create a new variable defining whether a patch is part of northern (N) or
# southern (S) region
patch.data$region <- NA
patch.data[is.na(patch.data$SGRIDCODE),]$region <- "N"
patch.data[is.na(patch.data$NGRIDCODE),]$region <- "S"
patch.data$region <- factor(patch.data$region)

# Make southern and northern regions separate
patch.data.north <- subset(patch.data, region == "N")
patch.data.south <- subset(patch.data, region == "S")

# Separate columns from different runs [45, 46, 47] into separate dataframes
run.45 <- cbind(patch.data[,1:20], patch.data[, grep("45$", names(patch.data))])
run.46 <- cbind(patch.data[,1:20], patch.data[, grep("46$", names(patch.data))])
run.47 <- cbind(patch.data[,1:20], patch.data[, grep("47$", names(patch.data))])

# Fix the column names (remove the runID from variable names)
colnames(run.45) <- gsub("45", "", colnames(run.45))
colnames(run.46) <- gsub("46", "", colnames(run.46))
colnames(run.47) <- gsub("47", "", colnames(run.47))

# Create a new column indication the run ID [45, 46, 47]
run.45$runID <- 45
run.46$runID <- 46
run.47$runID <- 47

# bind everything back together
runs.all <- do.call("rbind", list("45"=run.45, "46"=run.46, "47"=run.47))

# Common log-breaks for area related axis
logbreaks <- c(2, 4, 6, 8, 10)