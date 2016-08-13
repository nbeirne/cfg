#!/usr/bin/awk
function join(array, start, end, sep,    result, i)
{
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
} 

{
  #sep = ""
  sep = "…"
  max_len = 30

  p = split($0, arr, / /)
  p = join(arr, 2, p)
  max_len = arr[1]

  n = split(p, arr, /\//)
  i = 2
  while (length(p) > max_len && n > 2 && i < n) {
    s = substr(arr[i], 0, 2)
    p = join(arr,1, i-1, "/") "/" s sep "/" join(arr, i+1, n, "/")
    n = split(p, arr, /\//)
    i = i + 1
  }

  # if only 
  if (length(p) > max_len) {
    n = split(p, arr, /\//)
    p = arr[n]
  }
  print p
}
