library("ggpubr")

p <- read.csv("scores_all_violin.csv")
p$Category <- factor(p$Category, levels = c("SystemX", "SystemAT"))
p <- ggviolin(p, x = "Category", y = "Rating", orientation = "horiz")
p <- add_summary(p, fun = "median_q1q3", size = 0.3)
p <- facet(p +
             theme_pubclean() +
             geom_hline(yintercept = 2, linetype = "dotted", size = 0.5, alpha = 0.4) +
             geom_hline(yintercept = 4, linetype = "dotted", size = 0.5, alpha = 0.8) +
             geom_hline(yintercept = 6, linetype = "dotted", size = 0.5, alpha = 0.4) +
             scale_y_discrete(limits = c("1", "2", "3", "4", "5", "6", "7")),
           scales = "free",
           panel.labs = list(Aspect = c("Remuneration", "PayPreparedness", "Transformative", "Speed", "Convenience", "Ethics", "Legal", "TechSupport", "Rethink"), Part = c("CPI")),
           facet.by = c("Part", "Aspect"))
p
ggarrange(p) %>%
  ggexport(width = 4800, height = 800, res = 400, filename = "ratings.png")