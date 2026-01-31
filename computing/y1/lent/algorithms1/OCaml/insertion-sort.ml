let rec insert x = function
    | [] -> [x]
    | y :: ys ->
            if x <= y then x :: y :: ys
            else y :: insert x ys

let rec insertion_sort = function
    | [] -> []
    | x :: xs -> insert x (insertion_sort xs)
