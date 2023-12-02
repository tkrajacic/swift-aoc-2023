import Algorithms

struct Day02: AdventDay {
    var data: String
    
    var entities: [(Int, [Substring])] {
        data.split(separator: "\n").compactMap {
            let row = $0.split(separator: ":")
            assert(row.count == 2)
            guard let gameID = Int(row[0].dropFirst(5)) else { return nil }
            let tuples = row[1].split(separator: ";").flatMap { $0.split(separator: ",") }
            return (gameID, tuples)
        }
    }
    
    func part1() -> Any {
        return entities.compactMap { (gameID, turns) in
            for tuple in turns {
                let components = tuple.split(separator: " ")
                assert(components.count == 2)
                guard let value = Int(components[0]) else { return nil }
                switch components[1] {
                case "red": if value > 12 { return nil }
                case "green": if value > 13 { return nil }
                case "blue": if value > 14 { return nil }
                default: fatalError()
                }
            }
            return gameID
        }.reduce(0, +)
    }
    
    func part2() -> Any {
        return entities.compactMap { (gameID, turns) in
            var (redMax, greenMax, blueMax) = (0, 0, 0)
            for tuple in turns {
                let components = tuple.split(separator: " ")
                assert(components.count == 2)
                guard let value = Int(components[0]) else { return nil }
                switch components[1] {
                case "red": redMax = max(value, redMax)
                case "green": greenMax = max(value, greenMax)
                case "blue": blueMax = max(value, blueMax)
                default: fatalError()
                }
            }
            return redMax * greenMax * blueMax
        }.reduce(0, +)
    }
}
