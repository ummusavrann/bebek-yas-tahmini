############################################################
# EBEBEK YAŞ TAHMİNİ PROJESİ - TEMİZLENMİŞ VERSİYON
############################################################

# ==========================================================
# 1. VERİ ÖNİŞLEME
# ==========================================================

library(tidyverse)
library(readr)
library(readxl)
library(ggridges)

# ----------------------------------------------------------
# Veri Yükleme
# ----------------------------------------------------------

data_yas <- read_delim("data/data_yas.csv",
                       delim = ";",
                       escape_double = FALSE,
                       trim_ws = TRUE)

# ----------------------------------------------------------
# Miktar değişkeni ölçekleme
# ----------------------------------------------------------

data_yas <- data_yas %>%
  mutate(MIKTAR = MIKTAR / 1000)

# ----------------------------------------------------------
# Aylık filtreleme (-6 ile 48 ay arası)
# ----------------------------------------------------------

data_yas <- data_yas %>%
  filter(aylik >= -6, aylik <= 48)

# ----------------------------------------------------------
# Cinsiyet düzenleme
# ----------------------------------------------------------

data_yas <- data_yas %>%
  mutate(
    TEKSTIL_CINSIYET = recode(
      TEKSTIL_CINSIYET,
      "1044" = "Erkek",
      "1045" = "Kız",
      "1046" = "Unisex",
      "1047" = "Erkek Bebek",
      "1048" = "Kız Bebek",
      "1049" = "Anne",
      "NULL" = "Cinsiyetsiz"
    )
  )

# ----------------------------------------------------------
# Eksik veri kontrolü
# ----------------------------------------------------------

colSums(is.na(data_yas))

# ==========================================================
# 2. BEDEN DÖNÜŞÜMÜ
# ==========================================================

# NULL olacak değerler
null_values <- c(
  "XS-S","Standart Bdn","XL-XXL","30x30","34","80","85",
  "120x120","42","XS","95","55x110","90","29-30",
  "115x35","60x110","46","90x135","70x135","6 Yaş","24"
)

# (-3)-0 grubuna atanacaklar
minus3_0 <- c(
  "M-L","L-XL","75x75","0 Beden","100","100x100",
  "2XL","36","80B","80C","80x80","85B","85C",
  "90B","90C","90x100","90x110","90x90","95B","95C",
  "Prematüre","XL","Yenidoğan"
)

# 1-3 grubuna atanacaklar
one_three <- c(
  "1 Beden","100x150","3 Ay","80x100","80x90",
  "L","40","0 Ay+","2 Beden","85x85",
  "100x120","110x110","6 Ay","M"
)

# 4-6 grubuna atanacaklar
four_six <- c(
  "70x110","6 Ay+","85x95","1","2 Ay+","3 Beden",
  "35x45","38","60x60","65X95","70x120","95x145",
  "S","0-6 Ay","3 Ay+","9 Ay","17-18","60x90","70x140"
)

# 7-9 grubuna atanacaklar
seven_nine <- c(
  "1 Ay+","18-19","4 Ay+","35x210","2",
  "6-12 Ay","Standart","1 Yaş","19","4 Beden"
)

# 10-12 grubuna atanacaklar
ten_twelve <- c(
  "19-20","4+ Beden","6-18 Ay","1,5 Yaş"
)

# 13-15 grubuna atanacaklar
thirteen_fifteen <- c(
  "20-21","21-22","22","2 Yaş","23","4"
)

# 16-18 grubuna atanacaklar
sixteen_eighteen <- c(
  "12 Ay+","5 Beden","20","22-23","23-24"
)

# 19-21 grubuna atanacaklar
nineteen_twentyone <- c(
  "24-25","25-26","6 Beden","18 Ay+","26-27","3 Yaş"
)

# 25-27 grubuna atanacaklar
twentyfive_twentyseven <- c(
  "7 Beden","27-28","4 Yaş"
)

# 28-30 grubuna atanacaklar
twentyeight_thirty <- c("5 Yaş")

# Mapping işlemi
data_yas <- data_yas %>%
  mutate(
    BEDEN = case_when(
      BEDEN %in% null_values ~ NA_character_,
      BEDEN %in% minus3_0 ~ "(-3)-0",
      BEDEN %in% one_three ~ "1-3",
      BEDEN %in% four_six ~ "4-6",
      BEDEN %in% seven_nine ~ "7-9",
      BEDEN %in% ten_twelve ~ "10-12",
      BEDEN %in% thirteen_fifteen ~ "13-15",
      BEDEN %in% sixteen_eighteen ~ "16-18",
      BEDEN %in% nineteen_twentyone ~ "19-21",
      BEDEN %in% twentyfive_twentyseven ~ "25-27",
      BEDEN %in% twentyeight_thirty ~ "28-30",
      TRUE ~ BEDEN
    )
  )

# ==========================================================
# 3. GENEL DAĞILIM GRAFİKLERİ
# ==========================================================

# Aylık dağılım
ggplot(data_yas, aes(x = aylik)) +
  geom_histogram(fill = "steelblue", color = "black", bins = 30) +
  labs(title = "Aylık Yaş Dağılımı",
       x = "Yaş (Ay)",
       y = "Frekans") +
  theme_minimal()

# BEDEN dağılımı
ggplot(data_yas, aes(x = BEDEN)) +
  geom_bar(fill = "darkorange", color = "black") +
  labs(title = "Beden Kategorik Dağılımı",
       x = "Beden",
       y = "Gözlem Sayısı") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Cinsiyete göre yoğunluk
ggplot(data_yas,
       aes(x = aylik,
           fill = TEKSTIL_CINSIYET)) +
  geom_density(alpha = 0.4) +
  labs(title = "Cinsiyete Göre Yaş Dağılımı",
       x = "Yaş (Ay)",
       y = "Yoğunluk") +
  theme_minimal()

# Birinci kategori boxplot
ggplot(data_yas,
       aes(y = WEB_BIRINCI_KATEGORI_TANIMI,
           x = aylik)) +
  geom_boxplot(fill = "dodgerblue") +
  theme_minimal()

# İkinci kategori ridge plot
ggplot(data_yas,
       aes(y = WEB_IKINCI_KATEGORI_TANIMI,
           x = aylik)) +
  geom_density_ridges(fill = "skyblue", alpha = 0.7) +
  theme_minimal()

############################################################
# XGBoost Model Sonuçlarının Görselleştirilmesi
############################################################

sepet_sonucc_NET_XGB <- read_excel("data/sepet_sonucc__NET_XGB.xlsx")

sepet_sonucc_NET_XGB <- sepet_sonucc_NET_XGB %>%
  filter(aylik >= -6, aylik <= 48)

ggplot(sepet_sonucc_NET_XGB,
       aes(x = factor(aylik),
           y = aylik_hata)) +
  geom_boxplot(fill = "lightblue", color = "blue") +
  geom_hline(yintercept = 0,
             linetype = "dashed",
             color = "red") +
  labs(
    title = "Aylık Değerlere Göre Model Tahmin Başarısı",
    x = "Ay",
    y = "Tahmin Hatası"
  ) +
  theme_minimal() +
  theme(axis.text = element_text(size = 6))

############################################################
