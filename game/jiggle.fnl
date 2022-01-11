(fn jiggle [vertices] 
  (icollect [i n (ipairs vertices)]
            (if 
              (= (% i 2) 1) 
              (+ n (* (math.random) 4))
              (= (% i 2) 0) 
              (+ n (* (math.random) 2)))))
{: jiggle}
