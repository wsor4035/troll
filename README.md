# Minetest troll mod

##instalation guide
download mod, rename folder to troll  

##list of commands and what they do
* /change_hp: removes specified hp from the specified player
* /grow_player: makes specified player 5x bigger than default values
* /shrink_player: makes a specified player 1/2 default size
* /reset_player: reset a specified player to default size

* /t-smoke: Spawns much of smoke arround the player
* /t-ban: Let the player think that he is banned
* /t-error: Send an Error message to the player
* /t-black: The player see 20 seconds only black
* /t-freeze: the player is freezed
* /t-unfreeze: unfreeze a player or stop t-nogravity
* /t-nogravity: the player has low gravity
* /t-teleport: the player got a random teleport
* /t-jail: A jail is building at the players position
* /t-lava: the player is ina lava block
* /t-hole: the player go down 5 blocks in a hole
* /t-msg: Send a MSG from another player args: from to msg
* /t-mob: Spawns a given amount of mobs at the players position args: player mob amount
* /t-chat name message: You can send messages as an another player!
* /t-diamond name: Spawns much of diamonds arround the player
* /t-shit Spawns much of shit arround the player
* /t-eyes player: Spawns much of eyes arround the player
* /t-blackparticles player: Spawns much of black particles arround the player
* /t-grant granter player priv: The player thinks, he got privs
* /t-chat sender message: Send something in the chat with another name!
* /t-msg fromstring toplayer msgstring: Send an msg from another player

##todo

###fix/modify
* "the field of view doesn't change, which means I only have the impression of being higher and not taller" - look into fov on /grow_player
* "collision box doesn't seem tall enough when giant (like 3 blocks instead of 6)" - was set smaller, will be fixed
* "jumping doesn't scale when growing (but does when shrinked)" - will look into it
* "when going in F7 mode, the camera distance doesn't scale" - known issue, have to do some research

###planned
* spawn a mob under a player, tie them to the mob, and vanish them.
* possible screw with inventory
