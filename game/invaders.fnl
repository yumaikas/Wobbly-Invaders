(local fennel (require :fennel))
(local vectar (require :game.vectar))
(local filter (require :game.filter))
(local timer (require :game.timer))
(local gfx love.graphics)

(var invaders {})

(fn pp [x] (print (fennel.view x)) x)

(lambda range [start end ?step] 
  (local results [])
  (for [i start end (or ?step 1)]
    (tset results i i))
  (ipairs results))

(var color-idx 1)
(local colors 
  [
   [1 0 0]
   [0 1 0]
   [0 0 1] ])

(fn color [] 
  (set color-idx (+ (% color-idx (length colors)) 1))
  (. colors color-idx))

(fn init-row [y]
  (each [idx x (range 1 26)]
    (let [
          coord [(+ 30 (* 35 x)) y]
          drawn-points [ 
                [0 0]
                [0 0]
                [0 0]
                [0 0]
                [0 0]
                   ]
          dirs [
                [-10 -20]
                [0 -15]
                [10 -20]
                [8 0]
                [15 15]
                [0 12]
                [-15 15]
                [-8 0]
                [-10 -15]
              ]
             base-corners dirs
          ]
      (table.insert invaders
            {
             :location coord
             :base-corners (vectar.flatten base-corners)
             :color (color)
             :alive true
             :corners (vectar.jiggle 4 (vectar.flatten base-corners))
                       }))))


(fn init [] 
  (local h (gfx.getHeight))
  (each [_ r (range 1 20) :until (> (* 40 r) (- (* h 0.7) 40))]
    (init-row (* 40 r)))
  (timer.repeating 
    0.15
    (fn []
      (each [_ v (ipairs invaders)] 
        (vectar.jiggle! v.corners 4 v.base-corners)))))

(fn draw [] 
  (each [_ v (ipairs invaders)]
    (gfx.push)
    (gfx.translate (unpack v.location))
    (gfx.setColor (unpack v.color))
    (gfx.polygon "line" (unpack v.corners))
    (gfx.pop))
  (set color-idx 1))

(fn collide-with [bullet]
  (fn is-hit [invader bullet] 
    (and bullet.can-hit
         (> 24 (vectar.dist invader.location bullet.location))))

  (var stop false)
  (each [_ i (ipairs invaders) :until stop]
    (when (is-hit i bullet)
      (set i.alive false)
      (set bullet.can-hit false)
      (set stop true)
      )))

(fn update [dt]
  (set invaders (filter.i invaders #(. $ :alive))))

{: init
 : draw 
 : update
 : collide-with
 }
