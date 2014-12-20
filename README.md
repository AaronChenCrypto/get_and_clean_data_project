get_and_clean_data_project
==========================

## The repo includes

  1. Source R code named run_analysis.R
  2. A code book to describe the feature name

## How does run_analysis.R 

  1.read features.txt to understand the names of features
  2.read train/test data, which contains "X" (features), "y" (label) and subject(the ID of the people)
  3.combine train and test data and assign their column names with features name
  4.Use regular expression to find names which contains "mean" or "std"
  **Note: match "mean(" to exclude some names like "fBodyBodyGyroJerkMag-meanFreq()"
  5.Extract "mean" and "std" like variable
  6.read activity label-pair and replace the activity numberwith descriptive activity label name 
  7.group by "subjec"t and "labe"l, then calculate variable mean in each group
  8.write the group by result into file nameed aver_variable.txt
 
