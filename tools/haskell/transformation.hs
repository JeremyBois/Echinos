{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedRecordDot #-}

import Data.Foldable (traverse_)
import GHC.Generics (Generic)

{-
  Types
-}
type Vec2D = (Float, Float)

data Spacing = Spacing {x :: !Float, y :: !Float}

data Line = Line
  { rotation :: !Float
  , spread :: !Float
  , offset :: !Float
  , spacing :: !Float
  }
  deriving stock (Eq, Show, Generic)

data Arc = Arc
  { offset :: !Float
  , spacing :: !Float
  , rotation :: !Float
  , refRotation :: !Float
  , refOffset :: !Vec2D
  }
  deriving stock (Eq, Show, Generic)

data KeyGroup
  = InArc !Arc !String !Int
  | InLine !Line !String !Int
  deriving stock (Eq, Show, Generic)

{-
  Data
-}
chocSpacing :: Spacing
chocSpacing = Spacing 18.5 17.5

mxSpacing :: Spacing
mxSpacing = Spacing 19.0 19.0

usedSpacing :: Spacing
usedSpacing = mxSpacing

groups :: [KeyGroup]
groups =
  [ InLine
      Line
        { rotation = 3.0
        , spread = -3.05 * usedSpacing.x
        , offset = 0.2 * usedSpacing.y
        , spacing = usedSpacing.y
        }
      "Outer"
      0
  , InLine
      Line
        { rotation = 3.0
        , spread = -2.05 * usedSpacing.x
        , offset = -0.8 * usedSpacing.y
        , spacing = usedSpacing.y
        }
      "Pinky"
      3
  , InLine
      Line
        { rotation = 3.0
        , spread = -1.05 * usedSpacing.x
        , offset = -0.2 * usedSpacing.y
        , spacing = usedSpacing.y
        }
      "Ring"
      3
  , InLine
      Line
        { rotation = 0.0
        , spread = 0.0
        , offset = 0.0
        , spacing = usedSpacing.y
        }
      "Middle"
      3
  , InLine
      Line
        { rotation = -3.0
        , spread = 1.05 * usedSpacing.x
        , offset = -0.2 * usedSpacing.y
        , spacing = usedSpacing.y
        }
      "Index"
      3
  , InLine
      Line
        { rotation = -3.0
        , spread = 2.05 * usedSpacing.x
        , offset = -0.3 * usedSpacing.y
        , spacing = usedSpacing.y
        }
      "Inner"
      3
  , InArc
      Arc
        { offset = 0
        , spacing = 1.33 * usedSpacing.y
        , rotation = 16
        , refRotation = 85
        , refOffset = (-0.45 * usedSpacing.x, -0.45 * usedSpacing.y)
        }
      "Thumb"
      3
  ]

main :: IO ()
main = traverse_ go groups
  where
    prettyPrint n c rot =
      putStrLn $
        concat
          [ "\n"
          , n
          , " {count = "
          , show c
          , ", Reference rotation = "
          , show rot
          , "}"
          ]
    -- Use last column as reference to place thumbs in arc
    (refIndex, inner) = (-1, groups !! 5)
    go (InArc arc name count) = case inner of
      (InLine refLine _ _) -> do
        let positions = onArcFrom (fromKeyOnLine refIndex refLine) arc count
        prettyPrint name count $ arc.refRotation + refLine.rotation
        print arc
        -- Negates the Y element to match Kicad axis orientation
        traverse_ (\(x, y) -> traverse_ putStr ["  --> ", show x, ", ", show $ -y, "\n"]) positions
      InArc{} -> do
        let positions = onArc arc count
        prettyPrint name count $ arc.refRotation
        print arc
        -- Negates the Y element to match Kicad axis orientation
        traverse_ (\(x, y) -> traverse_ putStr ["  --> ", show x, ", ", show $ -y, "\n"]) positions
    go (InLine line name count) = do
      let positions = onLine line count
      prettyPrint name count $ line.rotation
      print line
      -- Negates the Y element to match Kicad axis orientation
      traverse_ (\(x, y) -> traverse_ putStr ["  --> ", show x, ", ", show $ -y, "\n"]) positions

{-
  Helpers
-}

-- | Convert from degrees to radians.
radians :: Float -> Float
radians d = pi * d / 180.0

-- Translate a vector using another one
translate :: Vec2D -> Vec2D -> Vec2D
translate (x, y) (tx, ty) = (x + tx, y + ty)

-- Rotate a vector
rotate :: Vec2D -> Float -> Vec2D
rotate (x, y) angle =
  let (c, s) = (cos $ radians angle, sin $ radians angle)
   in (x * c - y * s, x * s + y * c)

{-
  Transformations
-}

-- -- Get position of each key in line
-- onLine :: Line -> Int -> [Vec2D]
-- onLine line count = unfoldr posAt 0
--   where
--     keyOnLine :: Int -> Line -> Vec2D
--     keyOnLine i l = fromKeyOnLine i l (0, 0)
--     posAt index
--       | index == count = Nothing
--       | otherwise = Just (keyOnLine index line, index + 1)

-- Get position of each key in line
onLine :: Line -> Int -> [Vec2D]
onLine line count = doKeyPosition 0
  where
    keyOnLine :: Int -> Line -> Vec2D
    keyOnLine i l = fromKeyOnLine i l (0, 0)
    doKeyPosition index
      | index == count = []
      | otherwise = keyOnLine index line : doKeyPosition (index + 1)

-- Shift a position
fromKeyOnLine :: Int -> Line -> Vec2D -> Vec2D
fromKeyOnLine index line origin =
  let yShift = line.offset + fromIntegral index * line.spacing
   in rotate (translate origin (line.spread, yShift)) line.rotation

-- Get position of each key in line using a specific key in line as origin
onArcFrom :: (Vec2D -> Vec2D) -> Arc -> Int -> [Vec2D]
onArcFrom shifter arc count = shifter <$> onArc arc count

-- Get position of each key in arc
onArc :: Arc -> Int -> [Vec2D]
onArc arc count = posAt 0
  where
    keyOnArc :: Int -> Arc -> Vec2D
    keyOnArc i a = fromKeyOnArc i a (0, 0)

    posAt index
      | index == count = []
      | otherwise =
          translate (rotate (keyOnArc index arc) arc.refRotation) arc.refOffset
            : posAt (index + 1)

fromKeyOnArc :: Int -> Arc -> Vec2D -> Vec2D
fromKeyOnArc index arc origin =
  let
    -- Compute circle radius to enforce required spacing
    r = arc.spacing / (2.0 * sin (radians $ arc.rotation / 2.0))
    angle = -radians (fromIntegral index * arc.rotation + arc.offset)
    c = cos angle
    s = sin angle
   in
    translate origin (-r + r * c, r * s)
