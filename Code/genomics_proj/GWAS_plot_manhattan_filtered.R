library(dplyr)
library(readr)
library(stringr)
library(ggplot2)

# read in the GWAS results
resultGemma <- read_table("Data/deafness_dogs/AfterQC/output/GWAS_res_filter_acd.lmm.assoc.txt")
head(resultGemma)

# cumulative position of SNPs

data_man <- resultGemma %>%
  # chromosome sizes
  group_by(chr) %>%
  summarise(chr_len = max(ps)) %>%
  # cumulative position of chromosomes
  mutate(tot = cumsum(chr_len) - chr_len) %>%
  select(-chr_len) %>%
  # add to the gemma dataset
  left_join(., resultGemma, by = c("chr" = "chr")) %>%
  arrange(chr, ps) %>%
  mutate(
    PScum = ps + tot,
    neglogP = -log10(p_lrt)
  ) %>%
  select(chr, tot, ps, PScum, p_lrt, neglogP)

# positions where the thick marks of the chromosomes names will go
x_axis_chr <- data_man %>%
  group_by(chr) %>%
  summarise(center = (max(PScum) + min(PScum)) / 2)

labels <- rep("", length(x_axis_chr$chr)) # Initialize labels with empty strings
labels[seq(1, length(x_axis_chr$chr), by = 2)] <- x_axis_chr$chr[seq(1, length(x_axis_chr$chr), by = 2)]

# compute the Bonferroni threshold
bonferroni2 <- -log10(0.2 / nrow(resultGemma))
bonferroni05 <- -log10(0.05 / nrow(resultGemma))
bonferroni01 <- -log10(0.01 / nrow(resultGemma))
tresh <- -log10(5 * 10^(-8))

plot_mann <- data_man %>%
  ggplot(aes(PScum, neglogP)) +
  geom_point(aes(color = as.factor(chr)), size = 2, alpha = .4, show.legend = FALSE) +
  geom_hline(yintercept = bonferroni2, linetype = "dashed", color = "indianred") +
  annotate("text", x = 1920657988, y = bonferroni2 - 0.25, label = bquote(-log[10](0.1 / italic(tests)))) +
  scale_color_manual(values = rep(c("indianred", "steelblue3"), 38)) +
  scale_x_continuous(label = labels, breaks = x_axis_chr$center) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(
    title = "Manhattan plot_subset individuals",
    x = "Chromosome #",
    y = bquote(-log[10](italic(P)))
  ) +
  theme_bw() +
  theme(
    panel.border = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.x = element_blank(),
    aspect.ratio = 0.4
  )

path_manhattan <- "Figures/manhattan_filter_acd.png"

ggsave(path_manhattan, plot = plot_mann, width = 10, dpi = 96)
knitr::plot_crop(path_manhattan)
