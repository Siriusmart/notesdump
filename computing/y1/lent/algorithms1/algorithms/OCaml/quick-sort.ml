exception Empty

let rec partition = function
    | [] -> raise Empty
    | x :: xs ->
            (List.filter ((>=) x) xs, x, List.filter ((<) x) xs)

let rec quick_sort = function
    | [] -> []
    | xs ->
            let (l1, x, l2) = partition xs
            in (quick_sort l1) @ x :: (quick_sort l2)
