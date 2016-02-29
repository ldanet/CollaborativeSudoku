# Collaborative Sudoku

This is a small exercise app.

## Installation

To run this project you need Node.js v5.6.0, along bower and grunt-cli packages.

Install project dependencies with the following commands:
```
npm install
bower install
```
Run the project with
```
grunt serve
```

## Known issues

- Server is storing games in memory and they never get deleted.
  - Possible solution: keeping track of connected players for each game and deleting the game when there are no one left playing it. (Maybe after a timeout to give the player a chance to reconnect after a network problem.)
- Game integrity is never checked.
  - Solution: adding index checks when making changes to make sure they are within grid bounds.
- Game may not be up to date when connection is lost and found again.
  - Possible solution: get the current game state from the server on socket reconnection.
