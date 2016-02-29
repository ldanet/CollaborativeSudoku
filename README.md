# Collaborative Sudoku

This is a small exercise app.

## Installation

To run this project you need Node.js, and install bower and grunt-cli packages with npm.

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
- Game integrity is never checked.
- Game may not be up to date when connection is lost and found again.
