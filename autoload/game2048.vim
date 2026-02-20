vim9script

# Main entry point for the 2048 game plugin
# This file imports and re-exports the public API

import autoload './game2048/types.vim'
import autoload './game2048/game.vim'

# Module-level function to get or create the game instance
var game_instance: types.IGame = null_object

export def GetGameInstance(): types.IGame
  if game_instance == null_object
    game_instance = game.Game.new()
  endif
  return game_instance
enddef

export def CloseGame(): void
  if game_instance != null_object
    game_instance.Close()
    game_instance = null_object
  endif
enddef
