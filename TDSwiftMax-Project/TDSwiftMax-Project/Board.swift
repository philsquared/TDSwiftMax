enum Portal {
    case Snake(Int)
    case Ladder(Int)
}
enum Action {
    case MoveTo(Int)
    case Win
    case NoMove
}

struct Board {
    let size = 100
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
    func land(on square : Int) -> Action {
        let finalSquare : Int = {
            switch portals[square] {
            case .some(.Snake(let target)): return target
            case .some(.Ladder(let target)): return target
            default: return square
            }
        }()
        switch finalSquare {
        //case size: return .Win
        case let x where x > size: return .NoMove
        default: return .MoveTo(finalSquare)
        }
    }
}
