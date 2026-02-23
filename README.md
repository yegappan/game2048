# 2048 Game in Vim9script

A complete implementation of the 2048 puzzle game for Vim. Merge tiles to reach 2048 and achieve the highest score. Written in Vim9script to showcase classes, interfaces, enums, and strict type checking.

## Features

- **Full 2048 Game Mechanics**: Merge tiles and track your score
- **Popup Window UI**: Game board displays in a centered, bordered popup
- **Object-Oriented Design**: Game logic implemented with classes and interfaces
- **Strict Type Checking**: Explicit type annotations on all variables and parameters
- **Modular Architecture**: Separated concerns across multiple files
- **Dual Input Modes**: Support for both arrow keys and hjkl for movement
- **Modern Vim9script**: Demonstrates best practices in Vim9 development

## Requirements

- Vim 9.0 or later with Vim9script support
- **NOT compatible with Neovim** (requires Vim9-specific features)

## Installation

### Using Git

**Unix/Linux/macOS:**
```bash
git clone https://github.com/yegappan/game2048.git ~/.vim/pack/downloads/opt/game2048
```

**Windows (cmd.exe):**
```cmd
git clone https://github.com/yegappan/game2048.git %USERPROFILE%\vimfiles\pack\downloads\opt\game2048
```

### Using a ZIP file

**Unix/Linux/macOS:**
```bash
mkdir -p ~/.vim/pack/downloads/opt/
```
Download the ZIP file from GitHub and extract it into the directory above. Rename the extracted folder (usually game2048-main) to `game2048` so the final path matches:

```plaintext
~/.vim/pack/downloads/opt/game2048/
├── plugin/
├── autoload/
└── doc/
```

**Windows (cmd.exe):**
```cmd
if not exist "%USERPROFILE%\vimfiles\pack\downloads\opt" mkdir "%USERPROFILE%\vimfiles\pack\downloads\opt"
```
Download the ZIP file from GitHub and extract it into the directory above. Rename the extracted folder (usually game2048-main) to `game2048` so the final path matches:

```plaintext
%USERPROFILE%\vimfiles\pack\downloads\opt\game2048\
├── plugin/
├── autoload/
└── doc/
```

### Finalizing Setup

Since the plugin is in the `opt` directory, add this to your `.vimrc` (Unix) or `_vimrc` (Windows):
```viml
packadd game2048
```

Then restart Vim and run:
```viml
:helptags ALL
```

### Plugin Manager Installation

If using vim-plug, add to your config:
```viml
Plug 'path/to/game2048'
```
Then run `:PlugInstall` and `:helptags ALL`.

For other plugin managers, follow their standard procedure for local plugins.

## Usage

### Starting the Game

```vim
:Game2048
```

### Controls

| Key | Action |
|-----|--------|
| `h` or `←` | Move left |
| `l` or `→` | Move right |
| `k` or `↑` | Move up |
| `j` or `↓` | Move down |
| `r` | Reset game |
| `q` | Quit game |

### Game Rules

- **Objective**: Reach 2048 (can continue playing after)
- **Mechanics**: Tiles with the same number merge into one when moved together
- **Scoring**: Each merge adds the new tile's value to your score
- **Game Over**: When no moves are possible (board full, no adjacent matching tiles)
- **Winning**: Reach 2048 to win, or keep playing for higher scores

### Strategy Tips

- **Keep edges clear**: Try to keep one edge or corner empty to maintain flexibility
- **Build efficiently**: Avoid trapping tiles that won't merge
- **High values together**: Keep your highest value tiles in one corner or edge
- **Plan ahead**: Think about how movements cascade across the board
- **New tiles appear randomly**: After any move, a new tile (2 or 4) appears in a random empty cell
- **Careful rotations**: Early moves determine future options, so be strategic

## Vim9 Language Features Demonstrated

- **Classes**: `Piece`, `Board`, `Game`, `UIManager` with methods and constructors
- **Interfaces**: Type-safe contracts for game logic (`IGame`, `IGameUI`)
- **Enums**: `Direction` enum for type-safe movement
- **Type Aliases**: `Position` type for semantic typing
- **Type Checking**: Full type annotations on all parameters and returns
- **Modular Architecture**: Clean separation with import/export
- **Object-Oriented Design**: Composition-based architecture with proper encapsulation

## License

This plugin is licensed under the MIT License. See the LICENSE file in the repository for details.
