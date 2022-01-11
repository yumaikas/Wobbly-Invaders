(local fennel (require :fennel))
(local invaders (require :game.invaders))
(local bullets (require :game.bullets))
(local player (require :game.player))
(local timer (require :game.timer))
(fn pp [x] (print (fennel.view x)))

(fn get-window-size [] [(love.graphics.getWidth) (love.graphics.getHeight)])

(fn get-center [] (icollect [_ attr (ipairs (get-window-size))] (/ attr 2)))

(var total-time 0)

(var location [0 0])

(fn love.load [] 
  (print "loading!")
  (invaders.init)
  (player.init)
  (bullets.init)
  (print "loaded!"))

(fn love.draw []
  (invaders.draw)
  (player.draw)
  (bullets.draw)
  (love.graphics.print (love.timer.getFPS) 10 10)
  )

(fn love.update [dt]
  (player.update dt)
  (invaders.update dt)
  (bullets.update dt)
  (timer.update dt)
  )
