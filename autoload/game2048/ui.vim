vim9script

import './constants.vim'
import './types.vim'
import './game_board.vim'

# Game UI handler - manages popup rendering and input
export class GameUI implements types.IGameUI
  var _board: game_board.GameBoard
  var _popup_id: number = -1
  var _game: types.IGame = null_object

  def new(board: game_board.GameBoard)
    this._board = board
    this._popup_id = -1
  enddef

  def SetGameInstance(game: types.IGame): void
    this._game = game
  enddef

  def Show(): void
    this.CreatePopup()
    this.DrawBoard()
  enddef

  def Hide(): void
    if this._popup_id > 0
      popup_close(this._popup_id)
      this._popup_id = -1
    endif
  enddef

  def Update(): void
    if this._popup_id > 0
      this.DrawBoard()
    endif
  enddef

  def FilterKey(popup_id: number, key: string): bool
    if key == 'q'
      this.Hide()
      return true
    elseif key == 'r'
      if this._game != null_object
        this._game.Reset()
        this.Update()
      endif
      return true
    elseif key == 'h' || key == "\<Left>"
      this.HandleMove(types.Direction.LEFT)
      return true
    elseif key == 'l' || key == "\<Right>"
      this.HandleMove(types.Direction.RIGHT)
      return true
    elseif key == 'k' || key == "\<Up>"
      this.HandleMove(types.Direction.UP)
      return true
    elseif key == 'j' || key == "\<Down>"
      this.HandleMove(types.Direction.DOWN)
      return true
    endif
    return false
  enddef

  def HandleMove(direction: types.Direction): void
    if this._game != null_object
      this._game.HandleInput(direction)
      this.Update()
    endif
  enddef

  def CreatePopup(): void
    # Validate screen size
    if !this.ValidateScreenSize()
      return
    endif

    # Calculate popup position (centered)
    # Account for border (1 char each side) and padding (1 char left/right)
    var columns: number = &columns
    var lines: number = &lines
    var row: number = (lines - (constants.POPUP_HEIGHT + 2)) / 2 + 1
    var col: number = (columns - (constants.POPUP_WIDTH + 4)) / 2 + 1

    var opts: dict<any> = {
      line: row,
      col: col,
      minwidth: constants.POPUP_WIDTH,
      height: constants.POPUP_HEIGHT,
      border: [1, 1, 1, 1],
      borderchars: ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
      padding: [0, 1, 0, 1],
      highlight: 'Normal',
      close: 'button',
      filter: (popup_id, key) => this.FilterKey(popup_id, key)
    }

    var popup_lines: list<string> = this.GenerateDisplay()
    this._popup_id = popup_create(popup_lines, opts)
  enddef

  def ValidateScreenSize(): bool
    var min_columns: number = constants.POPUP_WIDTH + 2
    var min_lines: number = constants.POPUP_HEIGHT + 2
    
    if &columns < min_columns || &lines < min_lines
      var msg: string = printf(
        'Screen too small! Requires at least %dx%d, currently %dx%d',
        min_columns,
        min_lines,
        &columns,
        &lines
      )
      echohl ErrorMsg
      echomsg msg
      echohl None
      return false
    endif
    return true
  enddef

  def DrawBoard(): void
    if this._popup_id <= 0
      return
    endif

    var popup_lines = this.GenerateDisplay()
    call popup_settext(this._popup_id, popup_lines)
  enddef

  def GenerateDisplay(): list<string>
    var lines: list<string> = []
    var grid: list<list<number>> = this._board.GetGrid()
    
    # Title
    add(lines, '           2048 GAME')
    add(lines, '')
    
    # Score info
    add(lines, printf('Score: %5d  Moves: %d', this._board.GetScore(), this._board.GetMovesMade()))
    add(lines, '')

    # Draw grid
    add(lines, '  ┌─────┬─────┬─────┬─────┐')
    for row_idx: number in range(constants.GRID_SIZE)
      var row_str: string = '  │'
      for col_idx: number in range(constants.GRID_SIZE)
        var val: number = grid[row_idx][col_idx]
        if val == constants.EMPTY_CELL
          row_str ..= '     │'
        else
          var val_str: string = string(val)
          var padding: number = (5 - strdisplaywidth(val_str)) / 2
          row_str ..= repeat(' ', padding) .. val_str .. repeat(' ', 5 - padding - strdisplaywidth(val_str)) .. '│'
        endif
      endfor
      add(lines, row_str)
      
      if row_idx < constants.GRID_SIZE - 1
        add(lines, '  ├─────┼─────┼─────┼─────┤')
      endif
    endfor
    add(lines, '  └─────┴─────┴─────┴─────┘')
    add(lines, '')

    # Game status
    if this._board.IsGameOver()
      add(lines, '        GAME OVER!')
      add(lines, '')
      add(lines, 'Press r to restart or q to quit')
    elseif this._board.IsWon()
      add(lines, '         YOU WON!')
      add(lines, '')
      add(lines, 'Press r to continue or q to quit')
    else
      add(lines, 'Use arrow keys or hjkl to move')
      add(lines, 'Press r to reset, q to quit')
    endif

    return lines
  enddef
endclass
