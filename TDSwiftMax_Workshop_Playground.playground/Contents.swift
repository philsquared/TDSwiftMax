enum Portal {
    case Snake(Int)
    case Ladder(Int)
}

let portals : [Int : Portal] =
    [
        2 : .Ladder(38),
        4 : .Ladder(14),
        8 : .Ladder(31),
        21 : .Ladder(42),
        28 : .Ladder(84),
        36 : .Ladder(44),
        47 : .Snake(26),
        49 : .Snake(11),
        51 : .Ladder(67),
        56 : .Snake(53),
        62 : .Snake(18),
        64 : .Snake(60),
        71 : .Ladder(91),
        80 : .Ladder(100),
        87 : .Snake(24),
        93 : .Snake(73),
        95 : .Snake(75),
        98 : .Snake(78)
    ]

