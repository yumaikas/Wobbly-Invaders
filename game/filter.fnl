; Remove entries from the table that don't satisfy the predicate
(fn i! [tbl pred] 
  (for [idx (length tbl) 1 -1]
    (when (not (pred (. tbl idx)))
      (table.remove tbl idx)
    )))

{ 
 :i (fn [tbl pred] (icollect [_ el (ipairs tbl)] (when (pred el) el)))
 :idx (fn [tbl pred] (icollect [idx el (ipairs tbl)] (when (pred idx el) el)))
 :kv (fn [tbl pred] (collect [key val (pairs tbl)] (when (pred key val) (values key val))))
 : i!
 }
