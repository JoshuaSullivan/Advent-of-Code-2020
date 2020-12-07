import Foundation

public struct BagRule: StringInitable, Hashable, Equatable, CustomStringConvertible {

    public struct InnerBag: StringInitable, Hashable, Equatable, CustomStringConvertible {
        let count: Int
        let color: String

        public init?(_ string: String) {
            let words = string.split(separator: " ")
            guard
                words.count >= 3,
                let count = Int(words[0])
            else { return nil }
            self.count = count
            self.color = words[1...2].joined(separator: " ")
        }

        public var description: String {
            "\(count) \(color) \(count == 1 ? "bag" : "bags")"
        }
    }

    let outerBagColor: String
    let innerBags: [InnerBag]

    public init?(_ string: String) {
        let words = string.split(separator: " ")
        outerBagColor = words[0...1].joined(separator: " ")
        guard words[3] == "contain" else {
            fatalError("Unexpected format.")
        }
        let innerWords = Array(words.dropFirst(4))
        innerBags = (0..<innerWords.count / 4).compactMap {
            let index = $0 * 4
            return InnerBag(innerWords[index..<index+3].joined(separator: " "))
        }
    }

    public var description: String {
        if innerBags.isEmpty {
            return "\(outerBagColor) bags contain no bags."
        } else {
            return "\(outerBagColor) bags contain \(innerBags.map(\.description).joined(separator: ", "))."
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(outerBagColor)
    }

    public static func == (lhs: BagRule, rhs: BagRule) -> Bool {
        return lhs.outerBagColor == rhs.outerBagColor
    }
}

public struct Solver {
    public static func solveFirst(input: [BagRule], key: String) -> Int {
        let allParents = findAllParents(of: key, in: input)
        return Set<BagRule>(allParents).count
    }

    public static func solveSecond(input: [BagRule], key: String) -> Int {
        let lookup: [String : [BagRule.InnerBag]] = input.reduce(into: [:]) { result, rule in
            result[rule.outerBagColor] = rule.innerBags
        }
        return countAllChildren(of: key, in: lookup)
    }

    private static func findAllParents(of key: String, in rules: [BagRule]) -> [BagRule] {
        let results = rules.filter { $0.innerBags.map(\.color).contains(key) }
        let childResults = results.map { findAllParents(of: $0.outerBagColor, in: rules) }
        return results + childResults.flatMap { $0 }
    }

    private static func countAllChildren(of key: String, in lookup: [String : [BagRule.InnerBag]]) -> Int {
        let bags = lookup[key, default:[]]
        guard !bags.isEmpty else { return 0 }
        return bags.reduce(0) { result, bag in
            let childCount = countAllChildren(of: bag.color, in: lookup)
            return result + bag.count * (childCount + 1)
        }
    }
}
