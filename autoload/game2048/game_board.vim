vim9script

import './constants.vim'
import './types.vim'

# Main Game Board class - handles grid logic and game mechanics
export class GameBoard
  var _grid: list<list<number>>
  var _score: number
  var _movesMade: number
  var _won: bool
  var _gameOver: bool
  var _tileMovedThisMove: bool

  def new()
    this._grid = []
    this._score = 0
    this._movesMade = 0
    this._won = false
    this._gameOver = false
    this._tileMovedThisMove = false
    this.InitializeGrid()
  enddef

  def InitializeGrid(): void
    for i: number in range(constants.GRID_SIZE)
      this._grid[i] = repeat([constants.EMPTY_CELL], constants.GRID_SIZE)
    endfor
    this.SpawnNewTile()
    this.SpawnNewTile()
  enddef

  def GetGrid(): list<list<number>>
    return this._grid
  enddef

  def GetScore(): number
    return this._score
  enddef

  def GetMovesMade(): number
    return this._movesMade
  enddef

  def IsGameOver(): bool
    return this._gameOver
  enddef

  def IsWon(): bool
    return this._won
  enddef

  def SpawnNewTile(): void
    var empty_cells: list<types.Position> = []
    
    for row: number in range(constants.GRID_SIZE)
      for col: number in range(constants.GRID_SIZE)
        if this._grid[row][col] == constants.EMPTY_CELL
          add(empty_cells, [row, col])
        endif
      endfor
    endfor

    if len(empty_cells) > 0
      var rand_idx: number = rand() % len(empty_cells)
      var [row, col] = empty_cells[rand_idx]
      var new_value: number = rand() % 100 < constants.NEW_TILE_2_CHANCE ? constants.NEW_TILE_VALUE_LOW : constants.NEW_TILE_VALUE_HIGH
      this._grid[row][col] = new_value
    endif
  enddef

  def CompressLine(line: list<number>): list<number>
    var result: list<number> = []
    
    for val: number in line
      if val != constants.EMPTY_CELL
        add(result, val)
      endif
    endfor
    
    while len(result) < constants.GRID_SIZE
      add(result, constants.EMPTY_CELL)
    endwhile
    
    return result
  enddef

  def MergeLine(line: list<number>): list<number>
    var result: list<number> = this.CompressLine(line)
    var merged: bool = false
    
    for i: number in range(constants.GRID_SIZE - 1)
      if result[i] != constants.EMPTY_CELL && result[i] == result[i + 1]
        result[i] = result[i] * 2
        result[i + 1] = constants.EMPTY_CELL
        this._score += result[i]
        merged = true
      endif
    endfor
    
    return this.CompressLine(result)
  enddef

  def Move(direction: types.Direction): bool
    this._tileMovedThisMove = false
    var old_grid: list<list<number>> = deepcopy(this._grid)

    if direction == types.Direction.LEFT
      for row: number in range(constants.GRID_SIZE)
        this._grid[row] = this.MergeLine(this._grid[row])
      endfor
    elseif direction == types.Direction.RIGHT
      for row: number in range(constants.GRID_SIZE)
        this._grid[row] = reverse(this.MergeLine(reverse(copy(this._grid[row]))))
      endfor
    elseif direction == types.Direction.UP
      for col: number in range(constants.GRID_SIZE)
        var column: list<number> = []
        for row: number in range(constants.GRID_SIZE)
          add(column, this._grid[row][col])
        endfor
        var merged_col: list<number> = this.MergeLine(column)
        for row: number in range(constants.GRID_SIZE)
          this._grid[row][col] = merged_col[row]
        endfor
      endfor
    elseif direction == types.Direction.DOWN
      for col: number in range(constants.GRID_SIZE)
        var column: list<number> = []
        for row: number in range(constants.GRID_SIZE)
          add(column, this._grid[row][col])
        endfor
        var merged_col = reverse(this.MergeLine(reverse(copy(column))))
        for row: number in range(constants.GRID_SIZE)
          this._grid[row][col] = merged_col[row]
        endfor
      endfor
    endif

    if this._grid != old_grid
      this._tileMovedThisMove = true
      this._movesMade += 1
    endif

    # Check for 2048 tile
    for row: number in range(constants.GRID_SIZE)
      for col: number in range(constants.GRID_SIZE)
        if this._grid[row][col] == constants.TARGET_SCORE && !this._won
          this._won = true
        endif
      endfor
    endfor

    # Check for game over
    if !this.CanMove()
      this._gameOver = true
    endif

    if this._tileMovedThisMove
      this.SpawnNewTile()
    endif

    return this._tileMovedThisMove
  enddef

  def CanMove(): bool
    # Check for empty cells
    for row: number in range(constants.GRID_SIZE)
      for col: number in range(constants.GRID_SIZE)
        if this._grid[row][col] == constants.EMPTY_CELL
          return true
        endif
      endfor
    endfor

    # Check for possible merges
    for row: number in range(constants.GRID_SIZE)
      for col: number in range(constants.GRID_SIZE)
        var current: number = this._grid[row][col]
        if col < constants.GRID_SIZE - 1 && current == this._grid[row][col + 1]
          return true
        endif
        if row < constants.GRID_SIZE - 1 && current == this._grid[row + 1][col]
          return true
        endif
      endfor
    endfor

    return false
  enddef

  def Reset(): void
    this._grid = []
    for i: number in range(constants.GRID_SIZE)
      this._grid[i] = repeat([constants.EMPTY_CELL], constants.GRID_SIZE)
    endfor
    this._score = 0
    this._movesMade = 0
    this._won = false
    this._gameOver = false
    this._tileMovedThisMove = false
    this.SpawnNewTile()
    this.SpawnNewTile()
  enddef
endclass
