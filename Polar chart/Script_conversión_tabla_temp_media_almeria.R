library(dplyr)
library(lubridate)
library(tidyr)
library(readr)

df <- read.csv("export.csv")
df$date <- as.Date(df$date)

df_monthly <- df %>%
  mutate(year = year(date),
         month = month(date, label = TRUE, abbr = TRUE)) %>%
  group_by(year, month) %>%
  summarise(tavg = mean(tavg, na.rm = TRUE)) %>%
  pivot_wider(names_from = month, values_from = tavg)

# 4️⃣ Guardamos el archivo CSV con separador de punto y coma (;)
write.csv2(df_monthly, "almeria_tavg_mensual.csv", row.names = FALSE, fileEncoding = "UTF-8")
