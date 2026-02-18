let rec merge xs ys = match xs, ys with
    | [], ys -> ys
    | xs, [] -> xs
    | x :: xs, y :: ys ->
            if x < y then x :: merge xs (y :: ys)
            else y :: merge (x :: xs) ys

let rec merge_sort = function
    | [] -> []
    | [x] -> [x]
    | xs ->
        let q = List.length xs / 2
        in let l1 = List.take q xs
        in let l2 = List.drop q xs
        in merge (merge_sort l1) (merge_sort l2)
