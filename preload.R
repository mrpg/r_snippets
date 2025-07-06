# https://github.com/mrpg/r_snippets @ 2025-07-06
# CC0 1.0 Universal (no rights reserved)

tt <- function (models, no_resize = F, placement = "", siunitx = T, ...) {
    # call this function just like texreg::texreg, i.e., with a list of models

    library(texreg) # https://github.com/mrpg/texreg_fork @ 6268c7f

    out <- gsub("\\begin{table}", paste0("\\begin{table}", placement), fixed = T,
                gsub("table-text-alignment=right", "table-text-alignment=center", fixed = T,
                     gsub(" (\\d+) ", "{\\1}",
                          texreg(
                                 models,
                                 label = deparse(substitute(models)),
                                 booktabs = T,
                                 threeparttable = T,
                                 siunitx = siunitx,
                                 digits = 3,
                                 use.packages = F,
                                 ...
                          )
                     )
                )
    )

    if (!no_resize) {
        gsub("\\begin{tabular}", "\\resizebox{\\textwidth}{!}{%\n\\begin{tabular}", fixed = T,
             gsub("end{tabular}", "end{tabular}}", fixed = T,
                  out
             )
        )
    }
    else {
        out
    }
}

save_to <- function(extension, ...) {
    # suppose you have a couple of tt() outputs, or just a bunch of character vectors/strings
    # you can do save_to("tex", table1, table2, table3) to get output/table{1,2,3}.tex, where
    # each file contains the argument's content!

    dir.create("output", showWarnings = FALSE)

    args <- list(...)
    arg_names <- sapply(substitute(list(...))[-1], deparse)

    for (i in seq_along(args)) {
        file_name <- paste0("output/", arg_names[i], ".", extension)

        writeLines(args[[i]], file_name)
    }
}

robustly <- function (models, column, type = "HC5") {
    # call this with a list of models
    # column = 2 gives standard errors
    # column = 4 gives p-values
    # this function is useful in conjunction with tt's override.se, override.pvalues arguments

    stopifnot(identical(class(models), "list"))

    library(lmtest)
    library(sandwich)

    out <- list()

    for (i in 1:length(models)) {
        model <- models[[i]]

        out[[i]] <- coeftest(model, vcovHC(model, type = type))[, column]
    }

    out
}

clustered <- function (models, column, ...) {
    # call this with a list of models
    # column = 2 gives standard errors
    # column = 4 gives p-values
    # specify clustering formula in ..., for example: ~ country + year
    # this function is useful in conjunction with tt's override.se, override.pvalues arguments
    # note: type = "HC3" (see below) is computationally expensive

    stopifnot(identical(class(models), "list"))

    library(lmtest)
    library(sandwich)

    out <- list()

    for (i in 1:length(models)) {
        model <- models[[i]]

        out[[i]] <- coeftest(model, vcovCL(model, ..., type = "HC3"))[, column]
    }

    out
}
