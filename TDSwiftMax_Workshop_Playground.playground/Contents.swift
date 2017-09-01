enum Portal {
    case snake(UInt)
    case ladder(UInt)
}

let portals : [UInt : Portal] =
    [
        2 : .ladder(38),
        4 : .ladder(14),
        8 : .ladder(31),
        21 : .ladder(42),
        28 : .ladder(84),
        36 : .ladder(44),
        47 : .snake(26),
        49 : .snake(11),
        51 : .ladder(67),
        56 : .snake(53),
        62 : .snake(18),
        64 : .snake(60),
        71 : .ladder(91),
        80 : .ladder(100),
        87 : .snake(24),
        93 : .snake(73),
        95 : .snake(75),
        98 : .snake(78)
    ]

