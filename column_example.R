# Environment set up
  library(dplyr)
  library(ggplot2)
  library(xtable)
  library(scales)
  library(tidyr)
  library(foreign)

  # Mac path
  setwd("~/Dropbox/Work Projects/Programming/Jenna")
  # PC Path
  #setwd("//Client/C$/Users/nrjones/Dropbox/Work Projects/Programming/Jenna")

# Test data
  cou1 <- read.table(header = TRUE, check.names = FALSE, text = "
    id_h pid bp pa dead div pmig pimg pdmg mmg fmg
    100  1   2  2  3    2   34   22   18   7   5
    100  2   3  2  1    4   24   82   12   2   3
    100  3   5  5  3    2   34   25   16   5   5
    101  1   7  7  2    2   36   22   11   7   2
    101  2   8  2  3    5   34   21   13   8   4
    102  1   2  8  4    2   14   22   11   7   5
    103  1   3  2  3    7   47   24   17   9   6
    104  1   2  2  5    2   34   83   11   1   5
    104  2   9  9  7    8   38   22   18   7   8
    105  1   2  2  3    2   26   22   11   3   5
    106  1   1  9  7    1   35   12   19   1   2
    107  1   5  2  1    2   11   21   12   7   5
  ")

# Function definition
country_col <- function(x, y) {
  cou_means <- summarize(x,
    mean(bp), mean(pa), mean(dead),
    mean(div), mean(pmig), mean(pimg),
    mean(pdmg), mean(mmg), mean(fmg))

  # Combine means with t-test results
    # Currently adds t-value with $statistic
    # To include p-value, change $statistic to $p.value
  cou_row <- cbind(cou_means,
    t.test(x$bp,   x$pa,    paired=TRUE)$statistic,
    t.test(x$bp,   x$dead,  paired=TRUE)$statistic,
    t.test(x$bp,   x$div,   paired=TRUE)$statistic,
    t.test(x$bp,   x$pmig,  paired=TRUE)$statistic,
    t.test(x$dead, x$div,   paired=TRUE)$statistic,
    t.test(x$dead, x$pmig,  paired=TRUE)$statistic,
    t.test(x$div,  x$pmig,  paired=TRUE)$statistic,
    t.test(x$pimg, x$pdmg,  paired=TRUE)$statistic,
    t.test(x$mmg,  x$fmg,   paired=TRUE)$statistic
  )

 # Rename output
 colnames(cou_row) <-c("bp", "pa", "dead", "div", "pmig", "pimg", "pdmg", "mmg", "fmg",
                       "t(bp=pa)", "t(bp=dead)", "t(bp=div)", "t(bp=pmig)","t(dead=div)",
                       "t(dead=pmig)","t(div=pmig)","t(pimg=pdmg)","t(mmg=fmg)")
  # Transpose table to create country column
  cou_col <- t(cou_row)

  # Add country name passed to function
  colnames(cou_col) = y

  return(cou_col)
}

# Data prep

  # Read in data
  cou1 <- read.dta("./Data/Country1.dta")
  cou2 <- read.dta("./Data/Country2.dta")

  # Reduce to needed variables
  cou1 <- select(cou1, id_h, pid, bp, pa, dead, div, pmig, pimg, pdmg, mmg, fmg)
  cou2 <- select(cou2, id_h, pid, bp, pa, dead, div, pmig, pimg, pdmg, mmg, fmg)

# Analysis
  # Process data with country_col function
    # Input: Raw country data
    # Output: Columns with bp-fmg means, t-test t-values, row labels, country name column header
  column1 <- country_col(cou1, "France")
  column2 <- country_col(cou2, "Spain")

  # Combine columns with cbind
  final_table <- cbind(column1, column2)




