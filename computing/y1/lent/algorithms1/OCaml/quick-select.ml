let rec quick_select i xs =
    let piv = List.hd xs
    in let l = List.filter ((>) piv) xs
    in let r = List.filter ((<) piv) xs
    in let piv_i = List.length l
    in if i = piv_i then piv
       else if i < piv_i then quick_select i l
       else quick_select (i - piv_i - 1) r
