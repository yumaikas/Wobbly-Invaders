{
 :i (fn [tbl f] (icollect [_ el (ipairs tbl)] (f el)))
 :idx (fn [tbl f] (icollect [idx el (ipairs tbl)] (f idx el)))
 :kv (fn [tbl f] (collect [k val (pairs tbl)] (f k val)))
}
