library(dplyr)
library(readr)
library(stringr)
library(ggplot2)
library(ggrepel)
library(plotly)

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
tresh <- quantile(data_man$neglogP, .9999)

plot_mann <- data_man %>%
  ggplot(aes(PScum, neglogP)) +
  geom_point(aes(color = as.factor(chr)), size = 2, alpha = .4, show.legend = FALSE) +
  geom_hline(yintercept = tresh, linetype = "dashed", color = "indianred") +
  # annotate("text", x = 1920657988, y = bonferroni2 - 0.25, label = bquote(-log[10](0.1 / italic(tests)))) +
  scale_color_manual(values = rep(c("grey60", "steelblue3"), 38)) +
  scale_x_continuous(label = labels, breaks = x_axis_chr$center) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(
    title = "Manhattan plot_subset individuals ACD breed",
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

ggsave(path_manhattan, plot = plot_mann, width = 10, dpi = 120)
knitr::plot_crop(path_manhattan)

##### Select the most significant SNPs'

# Highest associated SNPS
plot_tops_filtered <- resultGemma %>%
  mutate(negLogP = -log10(p_lrt)) %>%
  select(chr, rs, p_lrt, negLogP) %>%
  filter(negLogP > 4.5) %>%
  # Plot
  ggplot(aes(x = factor(chr), y = negLogP, color = factor(rs))) +
  geom_jitter(size = 4, alpha = .8, width = .1) +
  # facet_wrap(~rs) +
  labs(
    title = "top scoring SNPs - ACD breed filtered",
    x = "Chromosome",
    y = bquote(-log[10](italic(P)))
  ) +
  scale_color_discrete(name = "SNPs") +
  theme_bw() +
  theme(
    panel.border = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    # axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    aspect.ratio = 1
  )

path_tops <- "Figures/top_SNPs_filtered.png"

ggsave(path_tops, plot = plot_tops_filtered, width = 8, dpi = 120)
knitr::plot_crop(path_tops)

#### select just the third chromosome

third_chrom_data <-
  resultGemma %>%
  filter(chr == 3) %>%
  mutate(
    ps_mb = (ps - min(ps)) / 1e6,
    neg_log_p = -log10(p_lrt)
  ) %>%
  filter(neg_log_p >= 4.5)

ifelse(third_chrom_data$neg_log_p < 4.5, NA, third_chrom_data$neg_log_p)

plot <- third_chrom_data %>%
  select(rs, ps_mb, neg_log_p) %>%
  rename(LOD = neg_log_p) %>%
  ggplot(aes(x = ps_mb, y = LOD, text = rs, color = LOD)) +
  geom_point(size = 2) +
  geom_hline(yintercept = tresh, linetype = "dashed", color = "indianred") +
  geom_text_repel(aes(label = rs), size = 3, max.overlaps = 8) +
  scale_color_gradient(low = "dodgerblue", high = "firebrick") +
  labs(
    x = "Rel. position on chr. 3 (Mb)",
    y = bquote(-log[10](italic(P)))
  ) +
  theme_bw() +
  theme(
    panel.border = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    aspect.ratio = 1
  )

# plotly_chr3 <- plotly::ggplotly(plot, tooltip = c("ps_mb", "rs", "LOD"))
# htmlwidgets::saveWidget(as_widget(plotly_chr3), "tooltip.html")

path_tops <- "Figures/SNP_chr3_top.png"

ggsave(path_tops, plot = plot, width = 5, dpi = 120)
knitr::plot_crop(path_tops)
