vim9script

# Type aliases
export type Position = list<number>

# Enum for movement directions
export enum Direction
  LEFT,
  RIGHT,
  UP,
  DOWN,
endenum

# Interface for Game controller
export interface IGame
  def Reset(): void
  def HandleInput(direction: Direction): void
  def Close(): void
endinterface

# Interface for Game UI
export interface IGameUI
  def Show(): void
  def Hide(): void
  def SetGameInstance(game: IGame): void
  def Update(): void
endinterface
