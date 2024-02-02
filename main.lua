function love.load()
  tileSize = 10
  tileRows = 100
  tileCols = 100

  board = {}

  for y = 1, tileRows do
    board[y] = {}

    for x = 1, tileCols do
      board[y][x] = math.random() > 0.5
      -- board[y][x] = false
    end
  end

  -- glider
  -- board[3][4] = true
  -- board[4][5] = true
  -- board[5][3] = true
  -- board[5][4] = true
  -- board[5][5] = true

  t = 0

  updateTime = 0.5
  nextUpdate = updateTime
end

function getCell(board, x, y)
  if x < 1 then
    x = tileRows
  end

  if x > tileRows then
    x = 1
  end

  if y < 1 then
    y = tileCols
  end

  if y > tileCols then
    y = 1
  end

  return board[y][x]
end

function isAlive(board, x, y)
  neighbors = {
    getCell(board, x - 1, y - 1),
    getCell(board, x - 0, y - 1),
    getCell(board, x + 1, y - 1),

    getCell(board, x - 1, y - 0),
    getCell(board, x + 1, y - 0),

    getCell(board, x - 1, y + 1),
    getCell(board, x - 0, y + 1),
    getCell(board, x + 1, y + 1)
  }

  numAliveNeighbors = 0

  for _i, cell in pairs(neighbors) do
    if cell then
      numAliveNeighbors = numAliveNeighbors + 1
    end
  end

  if numAliveNeighbors < 2 then
    return false
  elseif numAliveNeighbors == 2 then
    return board[y][x]
  elseif numAliveNeighbors == 3 then
    return true
  elseif numAliveNeighbors > 3 then
    return false
  end
end

function love.update(dt)
  t = t + dt

  nextUpdate = nextUpdate - dt


  if nextUpdate <= 0 then
    newBoard = {}

    for y = 1, tileRows do
      newBoard[y] = {}

      for x = 1, tileCols do
        newBoard[y][x] = isAlive(board, x, y)
      end
    end

    board = newBoard
    nextUpdate = updateTime
  end
end

function love.draw()
  love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

  love.graphics.push()

  -- love.graphics.translate(10 * math.sin(t), 10)

  for y = 1, tileRows do
    for x = 1, tileCols do
      if board[y][x] then
        love.graphics.setColor(0.65, 0.75, 0.8)
      else
        love.graphics.setColor(0, 0, 0)
      end

      love.graphics.rectangle("fill", (x - 1) * tileSize, (y - 1) * tileSize, tileSize, tileSize)
    end
  end

  love.graphics.pop()
end
