//
//  Tehilim.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 26/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class Tehilim: NSObject {
    
    static let tehilimManager: Tehilim = Tehilim()
    
    private let chaptersArray: [String]

    
    private override init() {
        chaptersArray = Tehilim.getNamesOfTehilimDirectory() ?? []
        super.init()
    }
    
    private static func getNamesOfTehilimDirectory() -> [String]? {
        var arr : [String] = []
        for i in 0...245{
            arr += ["\(i)"]
        }
        
        return arr
    }
    
    func getAllNamesOfTehilim() -> [String]{
        return getTehilim(from: 0, to: 215)
    }
    
    func getTehilimOfYortzeitWith(name: String) -> [String] {
        var result: [String] = []
        let array = [33,16,17,72,91,104,130]
        result.append(chaptersArray[218])
        for i in 0..<array.count {
            result += getNamesTehilimBy(perek: array[i])
        }
        result += get119By(name: name+"נשמה")
        result.append(chaptersArray[241])
        result.append(chaptersArray[242])
        return result
    }
    
    func getTehilimForHealingWith(name: String) -> [String] {
        //todo...
        var result: [String] = []
        let array = [20,6,9,13,16,17,18,22,23,28,30,31,32,33,37,38,39,41,49,55,56,69,86,88,89,90,91,102,103,104,107,116,118,142,143,148]
        for i in 0..<array.count {
            result += getNamesTehilimBy(perek: array[i])
        }
        
        result += get119By(name: name+"קרעשטנ")
        
        
        result.append(chaptersArray[243])
        result.append(chaptersArray[244])
        result.append(chaptersArray[245])
        
        return result
    }
    
    private func get119By(name: String) -> [String] {
        let name = name.replacingOccurrences(of: " ", with: "")
        var result: [String]! = []
        for c in name.characters {
            result.append(getPartOf119By(letter: c))
        }
        return result
    }
    
    
    private func getPartOf119By(letter: Character) -> String {
        var result: String = ""
        switch letter {
        case "א": result = "219"
        case "ב": result = "220"
        case "ג": result = "221"
        case "ד": result = "222"
        case "ה": result = "223"
        case "ו": result = "224"
        case "ז": result = "225"
        case "ח": result = "226"
        case "ט": result = "227"
        case "י": result = "228"
        case "כ","ך": result = "229"
        case "ל": result = "230"
        case "מ","ם": result = "231"
        case "נ","ן": result = "232"
        case "ס": result = "233"
        case "ע": result = "234"
        case "פ","ף": result = "235"
        case "צ","ץ": result = "236"
        case "ק": result = "237"
        case "ר": result = "238"
        case "ש": result = "239"
        case "ת": result = "240"
        default: break
            
        }
        return result
    }
    
    func getYehiRatzon(befor: Bool) -> [String] {
        return befor ? getTehilim(from: 216, to: 216) : getTehilim(from: 217, to: 217)
    }
    
    func getNamesTehilimBy(weekday: Int) -> [String] {
        var start: Int
        var end: Int
        switch weekday {
        case 1: start = 0; end = 36
        case 2: start = 37; end = 69
        case 3: start = 70; end = 100
        case 4: start = 101; end = 129
        case 5: start = 130; end = 154
        case 6: start = 155; end = 179
        case 7: start = 180; end = 215
        default:
            return []
        }
        return getTehilim(from: start, to: end)
    }
    
    func getNamesTehilimBy(dayOfMonth: Int) -> [String] {
        var start: Int = -1
        var end: Int = -1
        switch dayOfMonth {
        case 1: start = 0; end = 10
        case 2: start = 11; end = 19
        case 3: start = 20; end = 27
        case 4: start = 28; end = 35
        case 5: start = 36; end = 44
        case 6: start = 45; end = 52
        case 7: start = 53; end = 58
        case 8: start = 59; end = 65
        case 9: start = 66; end = 74
        case 10: start = 75; end = 81
        case 11: start = 82; end = 87
        case 12: start = 88; end = 93
        case 13: start = 94; end = 98
        case 14: start = 99; end = 106
        case 15: start = 107; end = 112
        case 16: start = 113; end = 118
        case 17: start = 119; end = 124
        case 18: start = 125; end = 129
        case 19: start = 130; end = 137
        case 20: start = 138; end = 146
        case 21: start = 147; end = 151
        case 22: start = 151; end = 157
        case 23: start = 158; end = 163
        case 24: start = 164; end = 170
        case 25: start = 171; end = 175
        case 26: start = 176; end = 179
        case 27: start = 180; end = 194
        case 28: start = 195; end = 202
        case 29: start = 203; MyDate.dateManager.twoDayOfRoshChodesh() ? (end = 207) : (end = 215)
        case 30: start = 208; end = 215
        default:
            return []
        }
        return getTehilim(from: start, to: end)
    }
    
    func getNamesTehilimBy(sefer: Int) -> [String] {
        let start: Int
        let end: Int
        switch sefer {
        case 1: start = 0; end = 56
        case 2: start = 57; end = 100
        case 3: start = 101; end = 129
        case 4: start = 130; end = 154
        case 5: start = 155; end = 215
        default:
            return []
        }
        return getTehilim(from: start, to: end)
    }
    
    func getNamesTehilimBy(perek: Int) -> [String] {
        var start: Int
        var end: Int
        
        switch perek {
        case 1: start = 0; end = 0
        case 2: start = 1; end = 1
        case 3: start = 2; end = 2
        case 4: start = 3; end = 3
        case 5: start = 4; end = 4
        case 6: start = 5; end = 5
        case 7: start = 6; end = 7
        case 8: start = 8; end = 8
        case 9: start = 9; end = 10
        case 10: start = 11; end = 12
        case 11: start = 13; end = 13
        case 12: start = 14; end = 14
        case 13: start = 15; end = 15
        case 14: start = 16; end = 16
        case 15: start = 17; end = 17
        case 16: start = 18; end = 18
        case 17: start = 19; end = 19
        case 18: start = 20; end = 22
        case 19: start = 23; end = 23
        case 20: start = 24; end = 24
        case 21: start = 25; end = 25
        case 22: start = 26; end = 27
        case 23: start = 28; end = 28
        case 24: start = 29; end = 29
        case 25: start = 30; end = 31
        case 26: start = 32; end = 32
        case 27: start = 33; end = 34
        case 28: start = 35; end = 35
        case 29: start = 36; end = 36
        case 30: start = 37; end = 37
        case 31: start = 38; end = 39
        case 32: start = 40; end = 40
        case 33: start = 41; end = 42
        case 34: start = 43; end = 44
        case 35: start = 45; end = 46
        case 36: start = 47; end = 47
        case 37: start = 48; end = 50
        case 38: start = 51; end = 52
        case 39: start = 53; end = 53
        case 40: start = 54; end = 55
        case 41: start = 56; end = 56
        case 42: start = 57; end = 57
        case 43: start = 58; end = 58
        case 44: start = 59; end = 60
        case 45: start = 61; end = 62
        case 46: start = 63; end = 63
        case 47: start = 64; end = 64
        case 48: start = 65; end = 65
        case 49: start = 66; end = 67
        case 50: start = 68; end = 69
        case 51: start = 70; end = 71
        case 52: start = 72; end = 72
        case 53: start = 73; end = 73
        case 54: start = 74; end = 74
        case 55: start = 75; end = 76
        case 56: start = 77; end = 77
        case 57: start = 78; end = 78
        case 58: start = 79; end = 79
        case 59: start = 80; end = 81
        case 60: start = 82; end = 82
        case 61: start = 83; end = 83
        case 62: start = 84; end = 84
        case 63: start = 85; end = 85
        case 64: start = 86; end = 86
        case 65: start = 87; end = 87
        case 66: start = 88; end = 89
        case 67: start = 90; end = 90
        case 68: start = 91; end = 93
        case 69: start = 94; end = 95
        case 70: start = 96; end = 96
        case 71: start = 97; end = 98
        case 72: start = 99; end = 100
        case 73: start = 101; end = 102
        case 74: start = 103; end = 104
        case 75: start = 105; end = 105
        case 76: start = 106; end = 106
        case 77: start = 107; end = 108
        case 78: start = 109; end = 112
        case 79: start = 113; end = 114
        case 80: start = 115; end = 116
        case 81: start = 117; end = 117
        case 82: start = 118; end = 118
        case 83: start = 119; end = 119
        case 84: start = 120; end = 120
        case 85: start = 121; end = 121
        case 86: start = 122; end = 123
        case 87: start = 124; end = 124
        case 88: start = 125; end = 126
        case 89: start = 127; end = 129
        case 90: start = 130; end = 130
        case 91: start = 131; end = 131
        case 92: start = 132; end = 132
        case 93: start = 133; end = 133
        case 94: start = 134; end = 135
        case 95: start = 136; end = 136
        case 96: start = 137; end = 137
        case 97: start = 138; end = 138
        case 98: start = 139; end = 139
        case 99: start = 140; end = 140
        case 100: start = 141; end = 141
        case 101: start = 142; end = 142
        case 102: start = 143; end = 144
        case 103: start = 145; end = 146
        case 104: start = 147; end = 148
        case 105: start = 149; end = 151
        case 106: start = 152; end = 154
        case 107: start = 155; end = 157
        case 108: start = 158; end = 158
        case 109: start = 159; end = 160
        case 110: start = 161; end = 161
        case 111: start = 162; end = 162
        case 112: start = 163; end = 163
        case 113: start = 164; end = 164
        case 114: start = 165; end = 165
        case 115: start = 166; end = 166
        case 116: start = 167; end = 167
        case 117: start = 168; end = 168
        case 118: start = 169; end = 170
        case 119: start = 171; end = 179
        case 120: start = 180; end = 180
        case 121: start = 181; end = 181
        case 122: start = 182; end = 182
        case 123: start = 183; end = 183
        case 124: start = 184; end = 184
        case 125: start = 185; end = 185
        case 126: start = 186; end = 186
        case 127: start = 187; end = 187
        case 128: start = 188; end = 188
        case 129: start = 189; end = 189
        case 130: start = 190; end = 190
        case 131: start = 191; end = 191
        case 132: start = 192; end = 192
        case 133: start = 193; end = 193
        case 134: start = 194; end = 194
        case 135: start = 195; end = 196
        case 136: start = 197; end = 198
        case 137: start = 199; end = 199
        case 138: start = 200; end = 200
        case 139: start = 201; end = 202
        case 140: start = 203; end = 203
        case 141: start = 204; end = 204
        case 142: start = 205; end = 205
        case 143: start = 206; end = 206
        case 144: start = 207; end = 207
        case 145: start = 208; end = 209
        case 146: start = 210; end = 210
        case 147: start = 211; end = 212
        case 148: start = 213; end = 213
        case 149: start = 214; end = 214
        case 150: start = 215; end = 215
        default:
            return []
        }
        return getTehilim(from: start, to: end)
    }
    
    func getNamesTehilimBy(birthday: NSDate) -> [String] {
        let now = Date()
        let birthday: Date = birthday as Date
        let calendar = Calendar(identifier: .hebrew)
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
                
        return getNamesTehilimBy(perek: age + 1)
    }
    
    func getNamesTehilimOfEllulMonthBy(dayOfMonth: Int, month: Int) -> [String] {
        let pereksOfTehilm = month == 13 ? dayOfMonth*3 : (dayOfMonth+29)*3
        let first = pereksOfTehilm - 2
        let second = pereksOfTehilm - 1
        let latest = pereksOfTehilm
        let ellulPereks = getNamesTehilimBy(perek: first) + getNamesTehilimBy(perek: second) + getNamesTehilimBy(perek: latest)
        return ellulPereks
    }
    
    func perek20() -> [String] {
        return getNamesTehilimBy(perek: 20)
    }
    
    func randomTehilim() -> [Int:[String]] {
        let r = Int(arc4random_uniform(UInt32(150)) + 1)
        return [r:getNamesTehilimBy(perek: r)]
    }
    
    func tikunHaklali() -> [String] {
        let tikunHaklali = [16,32,41,42,77,90,105,137,150]

        var prakim: [String] = []
        for perek in tikunHaklali {
            prakim += getNamesTehilimBy(perek: perek)
        }
        
        return prakim
    }

    private func getTehilim(from: Int, to: Int) -> [String] {
        debugPrint(chaptersArray.count)
        return Array(chaptersArray[from...to])
    }
    
}

extension Tehilim{
    enum Segulot {
        case LIVELIHOOD, SHALOM_BAYIT, AT_BIRTH, CHILDREN, SHIDDUCH, PREGNANCY
    }
    
    func getTehilimFor(segulot: Segulot) -> [String] {
        let tehilimArr: [Int]!
        switch segulot {
        case .LIVELIHOOD: tehilimArr = [23,24]
        case .SHALOM_BAYIT: tehilimArr = [45,46]
        case .AT_BIRTH:
            tehilimArr = [1,2,3,4,20,21,22,23,24,33,47,72,86,90,91,92,93,104]
            for i in 112...150 {
                tehilimArr.append(i)
            }
        case .CHILDREN: tehilimArr = [102,103]
        case .SHIDDUCH: tehilimArr = [32,33,70,71,72,82,121,124]
        case .PREGNANCY: tehilimArr = [128]
        }
        
        var prakim: [String] = []
        for perek in tehilimArr {
            prakim += getNamesTehilimBy(perek: perek)
        }
        return prakim
    }
    
    func getMyChaptersBy(tehilimCore: [TehilimCore]) -> [String] {
        var result: [String] = []
        for t in tehilimCore {
            if t.perek != 0 {
                result += getNamesTehilimBy(perek: Int(t.perek))
            } else if let d = t.date {
                result += getNamesTehilimBy(birthday: d)
            }
        }
        return result
    }
}










