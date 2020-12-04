import Foundation

public struct Year {
    let value: Int
    let validRange: ClosedRange<Int>

    var isValid: Bool { validRange.contains(value) }
}
public struct Height {
    let value: Int
    let unit: String

    var isValid: Bool {
        switch unit {
        case "cm": return (150...193).contains(value)
        case "in": return (59...76).contains(value)
        default: return false
        }
    }
}

public struct HairColor {

    static let hexCharacters = CharacterSet(charactersIn: "1234567890abcdefABCDEF")

    let rawValue: String

    var isValid: Bool {
        guard
            rawValue.first == "#",
            rawValue.dropFirst().count == 6,
            String(rawValue.dropFirst()).rangeOfCharacter(from: HairColor.hexCharacters.inverted) == nil
        else { return false }
        return true
    }
}

public enum EyeColor: String {
    case amb, blu, brn, gry, grn, hzl, oth
}

public struct Passport: StringInitable {

    enum Field: StringInitable {
        case byr(Year)
        case iyr(Year)
        case eyr(Year)
        case hgt(Height)
        case hcl(HairColor)
        case ecl(EyeColor)
        case pid(String)

        var identifier: String {
            switch self {
            case .byr: return "byr"
            case .iyr: return "iyr"
            case .eyr: return "eyr"
            case .hgt: return "hgt"
            case .hcl: return "hcl"
            case .ecl: return "ecl"
            case .pid: return "pid"
            }
        }

        init?(_ string: String) {
            let parts = string.split(separator: ":")
            let rawValue = String(parts[1])
            switch parts[0] {
                case "byr":
                    guard let value = Int(rawValue) else { return nil }
                    self = Field.byr(Year(value: value, validRange: 1920...2002))
            case "iyr":
                guard let value = Int(rawValue) else { return nil }
                self = Field.byr(Year(value: value, validRange: 2010...2020))
            case "eyr":
                guard let value = Int(rawValue) else { return nil }
                self = Field.byr(Year(value: value, validRange: 2020...2030))
            case "hgt":
                guard let value = Int(rawValue.dropLast(2)) else { return nil }
                let unit = String(rawValue.suffix(2))
                self = Field.hgt(Height(value: value, unit: unit))
            case "hcl":
                self = Field.hcl(HairColor(rawValue: rawValue))
            case "ecl":
                guard let eyeColor = EyeColor(rawValue: rawValue) else { return nil }
                self = Field.ecl(eyeColor)
            case "pid":
                self = Field.pid(rawValue)
            default:
                return nil
            }
        }
    }

    public static let requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    public static let optionalFields = ["cid"]

    let fields: [Field]

    var hasRequiredFields: Bool {
        let fieldIds = fields.map { $0.identifier }
        return Passport.requiredFields.allSatisfy { fieldIds.contains($0) }
    }

    var isValid: Bool {
        
    }

    public init?(_ string: String) {
        fields = string
            .split(separator: " ")
            .compactMap { Field.init(String($0)) }
        print(fields)
    }
}

public struct Solver {
    public static func solveFirst(input: [Passport]) -> Int {
        return input.filter( \.hasRequiredFields ).count
    }
}
