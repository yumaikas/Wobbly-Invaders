(fn add [v1 v2]
  (let [[x y] v1
        [x1 y1] v2]
     [(+ x x1) (+ y y1)]))

(fn dist [v1 v2]
  (let [[x1 y1] v1
        [x2 y2] v2]
  (math.sqrt 
    (+
     (math.pow (- x2 x1) 2)
     (math.pow (- y2 y1) 2)))))

(fn jiggle [amt vertices] 
  (icollect [i n (ipairs vertices)]
            (if 
              (= (% i 2) 1) 
              (+ n (* (math.random) amt))
              (= (% i 2) 0) 
              (+ n (* (math.random) (/ amt 2))))))

(fn jiggle! [into amt vertices]
  (for [i 1 (length vertices)]
    (local n (. vertices i))
    (if 
      (= (% i 2) 1)
      (tset into i (+ n (* (math.random) amt)))
      (= (% i 2) 0)
      (tset into i (+ n (* (math.random) (/ amt 2)))))))

(fn flatten [pts] 
  (accumulate [nums {}
               _ d (ipairs pts)]
              (let [[x y] d]
                (table.insert nums x)
                (table.insert nums y)
                nums)))

{: jiggle
 : jiggle!
 : flatten 
 : add
 : dist
 }
