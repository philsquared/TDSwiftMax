import Foundation

enum Portal {
    case Snake(Int)
    case Ladder(Int)
}

enum Action {
    case MoveTo(Int)
    case Win
    case NoMove
}
extension Action: Equatable {
    static func ==(lhs: Action, rhs: Action) -> Bool {
        switch (lhs,rhs) {
        case (.NoMove, .NoMove): return true
        case (.NoMove, _): return false
        case (.Win, .Win): return true
        case (.Win, _): return false
        case (.MoveTo(let lhs), .MoveTo(let rhs)): return lhs == rhs
        case (.MoveTo, _): return false
        }
    }
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
    func land(on square:Int)-> Action {
        let finalSquare : Int = {
            switch portals[square] {
            case .some(.Snake(let target)): return target
            case .some(.Ladder(let target)): return target
            default: return square
            }
        }()
        switch finalSquare {
        case size: return .Win
        case let x where x > size: return .NoMove
        default: return .MoveTo(finalSquare)
        }
    }
}

let board = Board()

require() | board.land(on:1) == .MoveTo(1)
require() | board.land(on:2) == .MoveTo(38)
require() | board.land(on:47) == .MoveTo(26)
require() | board.land(on:100) == .Win
require() | board.land(on:80) == .Win
require() | board.land(on:101) == .NoMove

enum PlayerColour {
    case Red
    case Green
    case Blue
    case Yellow
}

class Player {
    let colour : PlayerColour
    var square = 0
    
    init( _ colour : PlayerColour ) {
        self.colour = colour
    }
}

func throwDie() -> Int {
    return Int(arc4random_uniform(6))+1
}

struct Turn {
    let player : Player
    let action : Action
}

class Game {
    let players : [Player]
    var currentPlayer = 0
    let board = Board()
    let die : () -> Int
    init( _ players : [Player], die : @escaping () -> Int = throwDie) {
        self.players = players
        self.die = die
        // Make sure players all start on the first square
        for p in self.players {
            p.square = 1
        }
    }
    
    func takeTurn() -> Turn {
        let player = players[currentPlayer]
        currentPlayer = currentPlayer + 1
        if currentPlayer == players.count {
            currentPlayer = 0
        }
        
        let moveBy = die()
        let action = board.land(on: player.square+moveBy)

        return Turn( player: player, action: action)
    }
}

// Example game loop
let game = Game([Player(.Red), Player(.Green), Player(.Blue)])
var stillPlaying = false // Set this to true to kick things off
while stillPlaying {
    let turn = game.takeTurn()
    print( "\(turn.player.colour) goes:")
    switch turn.action {
    case .Win: print( " - and wins the game!"); stillPlaying = false
    case .NoMove: print( " ... and does not move")
    case .MoveTo(let target): print (" - and moves to \(target)")
    }
}
