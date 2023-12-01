import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [Substring] {
        data.split(separator: "\n")
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        // Calculate the sum of the first set of input data
        return entities.compactMap {
            guard let first = $0.first(where: { $0.isNumber }) 
            else { return nil }
            let last = $0.last(where: { $0.isNumber })!
            return Int("\(first)\(last)")
        }.reduce(0, +)
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let forwards: Regex<Substring> = #/\d|one|two|three|four|five|six|seven|eight|nine/#
        let backwards: Regex<Substring> = #/\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin/#

        var result: Int = 0
        // Sum the maximum entries in each set of data
        for line in entities {
            guard let first = line.firstMatch(of: forwards) else { continue }
            let last = String(line.reversed()).firstMatch(of: backwards)!
            if let number = Int("\(first.digit)\(last.digit)") {
                result += number
            }
        }
        return result
    }
}

extension Substring {
    fileprivate var digit: Int {
        if let number = self.first?.wholeNumberValue {
            return number
        } else {
            return switch self {
            case "one", "eno": 1
            case "two", "owt": 2
            case "three", "eerht": 3
            case "four", "ruof": 4
            case "five", "evif": 5
            case "six", "xis": 6
            case "seven", "neves": 7
            case "eight", "thgie": 8
            case "nine", "enin": 9
            default: fatalError()
            }
        }
    }
}
