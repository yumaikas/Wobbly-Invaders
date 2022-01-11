try {
$paths = ls -Recurse | ? { -not(($_.FullName -ilike "*love-bins*") -or ($_.FullName -ilike "*.ps1") -or ($_.FullName -ilike "*publish*")) }


Remove-Item -Recurse -Force .\publish\wobble\
New-Item .\publish\wobble\ -ItemType Directory
Remove-Item -Recurse -Force .\publish\wobblyInvaders.love
Compress-Archive $paths publish\wobblyInvaders.love -Force
Push-location publish\
"Wobbly Invaders!" | npx love.js wobblyInvaders.love wobble -c
cd wobble
web-dir
}
finally {
    Pop-location
}
# Compress-Archive (ls -Recurse) ..\CasterFightWeba.zip -Force
