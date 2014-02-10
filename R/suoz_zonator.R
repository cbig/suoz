library(zonator)

root.path <- "C:/Data/suoajot36_47/suoajot"

project.suoz <- create_zproject(root=root.path)

names(project.suoz)

variant.42 <- get_variant(project.suoz, 1)
variant.43 <- get_variant(project.suoz, 2)
variant.44 <- get_variant(project.suoz, 3)
variant.45 <- get_variant(project.suoz, 4)
variant.46 <- get_variant(project.suoz, 5)
variant.47 <- get_variant(project.suoz, 6)

results.45 <- results(variant.45)
grp.labels <- c("Peruspiirteet kytk", "Peruspiirteet", "Lisäpiirteet", "Corine",
                            "Linnut", "Vaikea suo")
names(grp.labels) <- 1:6
groupnames(variant.45) <- grp.labels
breaks.lost <- c(0.25, 0.50, 0.75)
performance(results.45, breaks.lost, groups=TRUE)

curves.45 <- curves(results.45)