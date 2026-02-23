vim9script
# 2048 Game Plugin for Vim9
# Sliding puzzle game - combine tiles to reach 2048 and beyond
# Requires: Vim 9.0+

if exists('g:loaded_2048')
  finish
endif
g:loaded_2048 = 1

import autoload '../autoload/game2048.vim' as Game2048

# Default configuration
if !exists('g:game2048_target_tile')
  g:game2048_target_tile = 2048
endif

# Commands to start the game
command! Game2048 call Game2048.GetGameInstance().Start()
