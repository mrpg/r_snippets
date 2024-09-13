# r_snippets

The file `preload.R` contains some useful R snippets that [I](https://max.pm) have developed over time. This set of snippets makes serious use of R almost possible. This set of snippets is bound to be enhanced and amended over time. Feel free to just copy that file into your own R project. You can load it like this:

```r
source("preload.R")
```

## Dependencies

### R

If you use all the functions in `preload.R`, you need these R packages:

1. texreg, preferably as found [here](https://github.com/mrpg/texreg_fork)¹
2. lmtest
3. sandwich

¹ You can use `install.packages("remotes"); remotes::install_github("mrpg/texreg_fork")` to install that.

### LaTeX

When using `tt()`, include these LaTeX packages:

```tex
\usepackage{booktabs}
\usepackage{graphicx}
\usepackage{microtype}
\usepackage{siunitx}
\usepackage{threeparttable}
```

## Example

See `example.R`.

## License

Unless otherwise noted, everything in this repository is licensed under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/), or (at your option) any later version. See `LICENSE` for details. Note that there is **absolutely no warranty**.
