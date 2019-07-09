### Importing data

# Import external CSV
external_data <- read.csv("https://data.cityofchicago.org/api/views/4aki-r3np/rows.csv?accessType=DOWNLOAD")

# Sample down to 200,000 points with SSL scores
sampled_dataset <- external_data[complete.cases(external_data$SSL.SCORE), ]
# sampled_dataset <- sampled_dataset[sample(nrow(sampled_dataset), 200000), ]

### Processing data

# I wonder whether SSL scores are higher for people who have been arrested for narcotics offenses?

# Separate into 2 groups - criterion = has the person been arrested for a narcotics offense in the last 10 years before recording?
data_narcotics    <- sampled_dataset[!is.na(sampled_dataset$NARCOTICS.ARR.CNT), ]
data_no_narcotics <- sampled_dataset[ is.na(sampled_dataset$NARCOTICS.ARR.CNT), ]

print(summary(sampled_dataset))
print(summary(data_narcotics))
print(summary(data_no_narcotics))

# Sample groups to 100 points each
sample_num <- 100
data_narcotics_samp    <- data_narcotics[sample(nrow(data_narcotics), sample_num), ]
data_no_narcotics_samp <- data_no_narcotics[sample(nrow(data_no_narcotics), sample_num), ]

### Writing data

# Print summaries
print("Narcotics Offenders' SSL Scores:")
print(summary(data_narcotics_samp$SSL.SCORE))
print("Non-Narcotics Offenders' SSL Scores:")
print(summary(data_no_narcotics_samp$SSL.SCORE))

# TODO: Implement informal confidence intervals
#       median +- (1.5 * IQR)(sqrt n)

# Write data
write.table(data_narcotics_samp$SSL.SCORE, file = "narcotics.arr", row.names = FALSE, col.names = FALSE)
write.table(data_no_narcotics_samp$SSL.SCORE, file = "no_narcotics.arr", row.names = FALSE, col.names = FALSE)
print("Done!")
