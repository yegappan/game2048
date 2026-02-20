vim9script

import './types.vim'
import './game_board.vim'
import './ui.vim'

# Main game controller - coordinates game logic and UI
export class Game implements types.IGame
  var _board: game_board.GameBoard
  var _ui: types.IGameUI = null_object

  def new()
    this._board = game_board.GameBoard.new()
    this._ui = ui.GameUI.new(this._board)
    if this._ui != null_object
      this._ui.SetGameInstance(this)
    endif
  enddef

  def Start(): void
    if this._ui != null_object
      this._ui.Show()
    endif
  enddef

  def Close(): void
    if this._ui != null_object
      this._ui.Hide()
    endif
  enddef

  def HandleInput(direction: types.Direction): void
    this._board.Move(direction)
  enddef

  def Reset(): void
    this._board.Reset()
  enddef

  def IsGameOver(): bool
    return this._board.IsGameOver() || this._board.IsWon()
  enddef
endclass
