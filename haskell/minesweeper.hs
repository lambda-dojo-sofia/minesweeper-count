import Control.Monad

data Cell = Bomb | Empty deriving Show
type Row = [Cell]
type Field = [Row]

sample :: String
sample = "4 4\n*...\n....\n.*..\n...."

sampleFile :: String
sampleFile = sample ++ "\n" ++ sample

readField :: [String] -> Field
readField str = map readRow str

readMinefieldFile :: String -> [Field]
readMinefieldFile str = readFileLines $ lines str

readFileLines :: [String] -> [Field]
readFileLines [] = []
readFileLines (headerStr:rest) = let (x, _) = readHeader headerStr
                                     linesToParse = take x rest
                                     rest' = drop x rest
                                     field = readField linesToParse
                                 in (field:readFileLines rest')

readRow :: String -> Row
readRow str = map readCell str

readCell :: Char -> Cell
readCell '.' = Empty
readCell '*' = Bomb
readCell char = error $ "Invalid cell: " ++ show ( char )

readHeader :: String -> (Int, Int)
readHeader str = case words str of
               (str1:str2:[]) -> (read str1, read str2)
               _ -> error $ "invalid input: " ++ str

solve :: Field -> String
solve field = do
  x <- [0..rowCount-1]
  y <- [0..colCount-1]
  return $ solveCell x y field
  where
    rowCount = length field
    colCount = length (field !! 0)

solveCell :: Int -> Int -> Field -> Char
solveCell x y field = case ((field !! x) !! y) of
                        Bomb -> '*'
                        Empty -> (show $ length $ filter isBomb $ neighbours x y field) !! 0

isBomb :: Cell -> Bool
isBomb Bomb = True
isBomb _ = False

neighbours :: Int -> Int -> Field -> [Cell]
neighbours x y field = do
  x' <- fmap (+ x) [-1, 0 , 1]
  y' <- fmap (+ y) [-1, 0 , 1]
  guard (x' >= 0)
  guard (x' < maxX)
  guard (y' >= 0)
  guard (y' < maxY)
  guard (x' /= x || y' /= y)
  return $ (field !! x') !! y'
      where maxX = length field
            maxY = length (field !! 0)

