# 2048 Game for Vim9

A complete implementation of the 2048 puzzle game for Vim9, showcasing modern Vim9script features including classes, interfaces, enums, strict type checking, and modular architecture.

## Features

- **Full 2048 Game Mechanics**: Merge tiles, score tracking, win/lose detection
- **Popup Window UI**: Game board displays in a centered, bordered popup
- **Vim9 Classes & Interfaces**: Game logic implemented using OOP principles with interface-based design
- **Strict Type Checking**: Explicit type annotations on all variables and parameters
- **Modular Architecture**: Separated concerns across multiple files for maintainability
- **Dual Input**: Support for both arrow keys and hjkl for movement
- **Vim9 Only**: Requires Vim 9.0+, does not work with Neovim

## Installation

You can install this plugin directly from github using the following steps:

git clone https://github.com/yegappan/game2048 $HOME/.vim/pack/downloads/opt/game2048
vim -u NONE -c "helptags $HOME/.vim/pack/downloads/opt/game2048/doc" -c q

After installing the plugin using the above steps, add the following line to your $HOME/.vimrc file:

packadd game2048

You can also install and manage this plugin using any one of the Vim plugin managers (dein.vim, pathogen, vam, vim-plug, volt, Vundle, etc.).


## Usage

### Starting the Game

Run the command in Vim:

```vim
:Game2048
```

### Game Controls

| Key | Action |
|-----|--------|
| `h` or `←` | Move left |
| `l` or `→` | Move right |
| `k` or `↑` | Move up |
| `j` or `↓` | Move down |
| `r` | Reset game |
| `q` | Quit game |

### Game Rules

- **Objective**: Create a tile with the value 2048
- **Mechanics**: Tiles with the same value merge when they touch
- **Score**: Each merge adds the new tile's value to your score
- **Game Over**: When no more moves are possible
- **Win State**: Continue playing even after reaching 2048

## Plugin Structure

```
game2048/
├── plugin/
│   └── 2048.vim                    # Main entry point, commands
├── autoload/
│   ├── game2048.vim                # Public API (entry point)
│   └── game2048/
│       ├── constants.vim           # Configuration constants
│       ├── types.vim               # Type aliases, enums, and interfaces
│       ├── game_board.vim          # GameBoard class (game logic)
│       ├── ui.vim                  # GameUI class (rendering and input)
│       └── game.vim                # Game class (controller)
└── doc/
    └── game2048.txt                # Vim help documentation
```

## Vim9 Features Demonstrated

### Classes & Interfaces

**IGame Interface** (defines game contract):
- `Reset()`: Reset game state
- `HandleInput()`: Process direction input
- `Close()`: Close the game

**IGameUI Interface** (defines UI contract):
- `Show()`: Display the game board
- `Hide()`: Close the popup
- `Update()`: Redraw the board
- `SetGameInstance()`: Connect to game instance

**GameBoard Class**: 4×4 grid management with move logic and collision detection

**Game Class**: Main controller implementing `IGame`, coordinates board and UI

**GameUI Class**: Popup rendering and input handling implementing `IGameUI`

### Enums

```vim
enum Direction
  LEFT,
  RIGHT,
  UP,
  DOWN,
endenum
```

### Type Aliases

```vim
type Position = list<number>   # [row, col] coordinate pair
```

### Type Checking

All variables have explicit type annotations:
- Function parameters typed
- Return types specified
- Loop variables typed: `for row: number in range(GRID_SIZE)`
- Collections typed: `var grid: list<list<number>>`
- Nullable objects: `var _ui: IGameUI = null_object`

## Module Overview

| Module | Purpose | Dependencies |
|--------|---------|--------------|
| `constants.vim` | Configuration values (GRID_SIZE, TARGET_SCORE, etc.) | None |
| `types.vim` | Type aliases, Direction enum, IGame/IGameUI interfaces | None |
| `game_board.vim` | GameBoard class with 2048 game mechanics | constants, types |
| `ui.vim` | GameUI class for popup rendering and input | constants, types, game_board |
| `game.vim` | Game class orchestrating board and UI | types, game_board, ui |
| `game2048.vim` | Public API and module entry point | types, game |

## Architecture Highlights

### Separation of Concerns

- **Constants**: Centralized configuration
- **Types**: Shared type definitions and contracts (interfaces)
- **Game Logic**: Pure game board mechanics, independent of UI
- **Presentation**: Popup rendering and display logic
- **Controller**: Coordinates game logic and UI

### Type Safety

- Interface-based design breaks circular dependencies (`IGame` and `IGameUI`)
- Explicit type annotations prevent runtime type errors
- Strict enum usage for Direction values
- Nullable object handling with `null_object` and explicit checks

### Modularity

- Each class in its own file for easier maintenance
- Imports use relative paths for sibling modules
- Export keywords make public API explicit
- Clear dependencies between modules

## Key Algorithms

### Tile Movement (Four Directions)

1. **Compress**: Remove empty cells from row/column
2. **Merge**: Combine adjacent cells with equal values
3. **Compress Again**: Remove gaps created by merging

### Game Over Detection

Board is full AND no adjacent tiles have equal values (no merges possible)

### Tile Spawn

After each valid move:
- Random empty cell selected
- 90% chance new tile is 2
- 10% chance new tile is 4

## Performance Notes

- O(n²) per move for standard 4×4 grid
- Real-time popup updates
- Minimal memory footprint
- Efficient grid algorithms

## Requirements

- **Vim**: 9.0 or later
- **Not**: Neovim (Vim9script is Vim-specific)

## Credits

This complete 2048 game implementation for Vim9 was generated by **GitHub Copilot**, an AI-powered code generation tool. The codebase demonstrates best practices in:

- Object-oriented Vim9script using classes and interfaces
- Strict type checking with explicit annotations
- Modular architecture with clear separation of concerns
- Professional-grade plugin structure
- Comprehensive documentation and help files

GitHub Copilot assisted in creating well-organized, type-safe code that serves as an excellent reference for building medium to large-scale Vim9 plugins.

## Enjoy!

Play 2048 in Vim with modern Vim9 features and clean architecture.

