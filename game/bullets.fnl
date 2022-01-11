(local invaders (require :game.invaders))
(local filter (require :game.filter))
(local timer (require :game.timer))
(local vectar (require :game.vectar))
(local gfx love.graphics)

(local fennel (require :fennel))
(fn pp [x] (print (fennel.view x)) x)

(var player-bullets [])
(var enemy-bullets [])

(fn init [] )

(local player-bullet-template
  [
   -4 -12
   -4 12
   4 12
   4 -12
   ])
(local player-bullet-color [1 0 1])


(fn make-player-bullet [location]
  (var b {
          : location
          :jiggle (vectar.jiggle 3 player-bullet-template)
          :can-hit true })
    (fn bujig []
        (vectar.jiggle! b.jiggle 3 player-bullet-template)
        (when b.can-hit
          (timer.once 0.15 bujig)))
    (timer.once 0.15 bujig)
        
  (table.insert player-bullets b))

(fn make-enemy-bullet [location]
  (table.insert enemy-bullets 
                {
                 : location
                 :can-hit true }))

(fn spawn [pt kind] 
  (if
    (= kind :player) (make-player-bullet pt)
    (= kind :enemy) (make-enemy-bullet pt)
    true (error :wat!!!)))

(fn update [dt] 

  ; Advance bullets
  (each [_ b (ipairs player-bullets)] 
    (set b.location (vectar.add b.location [0 (* dt -300)])))
  ; Collide bullets
  (each [_ b (ipairs player-bullets)]
    (invaders.collide-with b))
  ; Filter out bullets that have hit
  (filter.i! player-bullets 
            (fn [b] 
              (and b.can-hit (> (. b.location 2) -10)))))

(fn draw [] 
  (each [_ b (ipairs player-bullets)]
    (gfx.push)
    (gfx.setColor (unpack player-bullet-color)) 
    (gfx.translate (unpack b.location))
    (gfx.polygon :line b.jiggle)
    (gfx.pop)
    )
  )


{: init
 : draw
 : spawn
 : update}
