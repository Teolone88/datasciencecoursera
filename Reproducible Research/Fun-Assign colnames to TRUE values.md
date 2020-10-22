### Having many variables with exclusive long boolean lists, assign the variable name to the TRUE observations and eventually reduce in order to have a singolar vector with preserved indexes of named TRUE observations

```{r}
for (i in 1:length(x)) {
    x[[i]] <- str_replace(tmp0[[i]], "TRUE", colnames(x)[i])
}
```

#### Example:

V1 | V2 | v3 | V4 | V5 |
---|----|----|----|----|
T  | F  |  F |  F |  F |
F  | T  |  F |  F |  F |
F  | F  |  T |  F |  T |
F  | F  |  F |  T |  F |

#### Into

V1 | V2 | v3 | V4 | V5 |
---|----|----|----|----|
V1 | F  |  F |  F |  F |
F  | V2 |  F |  F |  F |
F  | F  | V3 |  F | V5 |
F  | F  |  F | V4 |  F |
