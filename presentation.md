A shiny application for Exploratory Data Analysis
========================================================
author: hidekoji
date: 


========================================================
nycflights13 data

So this shiny application allows you to peform Exploratory Data Analyis against nycflights13 data.
nycflights13 contains Airline on-time data for all flights departing NYC in 2013. 


```r
library("nycflights13")
head(flights)
```

```
  year month day dep_time dep_delay arr_time arr_delay carrier tailnum
1 2013     1   1      517         2      830        11      UA  N14228
2 2013     1   1      533         4      850        20      UA  N24211
3 2013     1   1      542         2      923        33      AA  N619AA
4 2013     1   1      544        -1     1004       -18      B6  N804JB
5 2013     1   1      554        -6      812       -25      DL  N668DN
6 2013     1   1      554        -4      740        12      UA  N39463
  flight origin dest air_time distance hour minute
1   1545    EWR  IAH      227     1400    5     17
2   1714    LGA  IAH      227     1416    5     33
3   1141    JFK  MIA      160     1089    5     42
4    725    JFK  BQN      183     1576    5     44
5    461    LGA  ATL      116      762    5     54
6   1696    EWR  ORD      150      719    5     54
```

Arrival Delay vs Departure Delay
========================================================
By grancing the data, I'm just curious how the relationship between Arrival Delay and Departure Delay looks like, so I want to show the scatter plot like this in my shiny app



![plot of chunk unnamed-chunk-2](presentation-figure/unnamed-chunk-2-1.png) 

Make the scatter plot dynamic
========================================================
Since the data contains

