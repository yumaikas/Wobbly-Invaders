(local gfx love.graphics)
(local vectar (require :game.vectar))
(local bullets (require :game.bullets))
(local timer (require :game.timer))
(local map (require :game.map))

(local fennel (require :fennel))
(fn pp [x] (print (fennel.view x)))

(var player {})

(fn init [] 
  (set player.location [ (/ (gfx.getWidth) 2) (- (gfx.getHeight) 30) ])
  (set player.lives 3)
  (set player.loaded true)
  (set player.color [1 1 0])
  (local verts [
                [-10 5] 
                [-10 0] 
                [-2 0]
                [-2 -15]
                [2 -15]
                [2 0]
                [10 0]
                [10 5] 
                ])
  (set player.base-points (vectar.flatten verts))
  (set player.drawn-points (vectar.jiggle 2 player.base-points))

  (timer.repeating 0.15
                   (fn [] 
                     (set player.drawn-points (vectar.jiggle 3 player.base-points))
                     ))
  
  )

(fn draw [] 
  (gfx.push)
  (gfx.setColor (unpack player.color))
  (gfx.translate (unpack player.location))
  (gfx.polygon :line player.drawn-points)
  (gfx.pop))

(fn update [dt] 
  (tset player.location 1 (love.mouse.getX))
  (when (and player.loaded (love.mouse.isDown 1))
    (local [bx by] player.location)
    (bullets.spawn [bx by] "player")
    (set player.loaded false)
    (timer.once 0.15 (fn [] (set player.loaded true)))))

{: init
 : draw
 : update}
