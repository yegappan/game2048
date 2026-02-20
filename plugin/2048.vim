vim9script

if exists('g:loaded_2048')
  finish
endif
g:loaded_2048 = 1

import autoload '../autoload/game2048.vim'

def Start2048Game(): void
  game2048.CloseGame()
  var game = game2048.GetGameInstance()
  game.Start()
enddef

def CloseGame(): void
  game2048.CloseGame()
enddef

command! Game2048 call Start2048Game()
command! Game2048Close call CloseGame()
