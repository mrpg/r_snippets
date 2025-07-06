# r_snippets

The file `preload.R` contains some useful R snippets that [I](https://max.pm) have developed over time. This set of snippets makes serious use of R almost possible. This set of snippets is bound to be enhanced and amended over time. Feel free to just copy that file into your own R project. You can load it like this:

```r
source("preload.R")
```

These snippets default to [HC3 standard errors](https://doi.org/10.1016/0304-4076%2885%2990158-7) if computing “clustered” standard errors, and to [HC5 standard errors](https://doi.org/10.1080/03610920601126589) if not. (Note: Stata defaults to HC1 standard errors, which are [not recommended](https://datacolada.org/99).)

## Dependencies

### R

To use all the functions in `preload.R`, you need these R packages:

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

This file also shows a feature of these snippets that is frequently missed: `save_to` saves your LaTeX regression table to a file. This means that within your paper, you can do

```tex
\input{output/table1.tex}
```

No more copy and pasting! Crucially, the file name is determined automatically from your list of models.

## License

Unless otherwise noted, everything in this repository is licensed under [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/), or (at your option) any later version. See `LICENSE` for details. Note that there is **absolutely no warranty**.
