(local filter (require :game.filter))
(var timers {})
(fn update [dt] 
  (each [_ t (ipairs timers)]
    (set t.elapsed (+ t.elapsed dt))
    (when (> t.elapsed t.timeout)
      (t.f)
      (when (= t.type "repeat")
        (set t.elapsed 0))))
  (filter.i! timers #(< $.elapsed $.timeout)))

(fn remove [timer] 
  (set timers (filter.i #(not= timer $))))

(fn repeating [timeout f] 
  (let [t { : timeout : f :elapsed 0.0 :type "repeat" }]
    (table.insert timers t)
    t))

(fn once [timeout f] 
  (let [t { : timeout : f :elapsed 0.0 :type "once" }]
    (table.insert timers t)
    t))

{: once
 : repeating
 : remove 
 : update }
