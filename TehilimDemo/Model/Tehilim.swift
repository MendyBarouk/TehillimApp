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
        chaptersArray = Tehilim.getNamesOfAllTehilim() ?? []
        super.init()
    }
    
    private static func getNamesOfAllTehilim() -> [String]? {
        guard let path = Bundle.main.resourcePath else { return nil }
        
        let tehilimPath = path + "/tehilim"
        let fileManager = FileManager.default
        
        do {
            let imageNames = try fileManager.contentsOfDirectory(atPath: tehilimPath)
            print(imageNames)
            print(imageNames.count)
            return imageNames
            
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    func getAllNamesOfTehilim() -> [String]{
        return getTehilim(from: 0, to: 173)
    }
    
    func getNamesTehilimBy(weekday: Int) -> [String] {
        var start: Int
        var end: Int
        switch weekday {
        case 1: start = 0; end = 28
        case 2: start = 28; end = 55
        case 3: start = 55; end = 81
        case 4: start = 81; end = 105
        case 5: start = 105; end = 126
        case 6: start = 126; end = 148
        case 7: start = 148; end = 172
        default:
            return []
        }
        return getTehilim(from: start, to: end)
    }
    
    func getNamesTehilimBy(dayOfMonth: Int) -> [String] {
        var start: Int = -1
        var end: Int = -1
        switch dayOfMonth {
        case 1: start = 0; end = 8
        case 2: start = 8; end = 14
        case 3: start = 14; end = 22
        case 4: start = 22; end = 28
        case 5: start = 28; end = 34
        case 6: start = 35; end = 41
        case 7: start = 41; end = 46
        case 8: start = 47; end = 52
        case 9: start = 52; end = 59
        case 10: start = 59; end = 65
        case 11: start = 65; end = 70
        case 12: start = 70; end = 75
        case 13: start = 75; end = 79
        case 14: start = 79; end = 86
        case 15: start = 86; end = 91
        case 16: start = 92; end = 96
        case 17: start = 96; end = 101
        case 18: start = 101; end = 105
        case 19: start = 105; end = 112
        case 20: start = 112; end = 119
        case 21: start = 119; end = 123
        case 22: start = 123; end = 129
        case 23: start = 129; end = 133
        case 24: start = 134; end = 139
        case 25: start = 139; end = 144
        case 26: start = 144; end = 148
        case 27: start = 148; end = 156
        case 28: start = 156; end = 162
        case 29: start = 162; MyDate.dateManager.twoDayOfRoshChodesh() ? (end = 166) : (end = 172)
        case 30: start = 167; end = 172
        default:
            return []
        }
        return getTehilim(from: start, to: end)
    }
    
    func getNamesTehilimBy(sefer: Int) -> [String] {
        let start: Int
        let end: Int
        switch sefer {
        case 1: start = 0; end = 45
        case 2: start = 45; end = 81
        case 3: start = 81; end = 105
        case 4: start = 105; end = 126
        case 5: start = 126; end = 172
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
        case 2: start = 0; end = 1
        case 3: start = 1; end = 2
        case 4: start = 2; end = 2
        case 5: start = 3; end = 3
        case 6: start = 4; end = 4
        case 7: start = 4; end = 5
        case 8: start = 6; end = 6
        case 9: start = 6; end = 8
        case 10: start = 8; end = 9
        case 11: start = 9; end = 10
        case 12: start = 10; end = 10
        case 13: start = 10; end = 11
        case 14: start = 11; end = 11
        case 15: start = 12; end = 12
        case 16: start = 12; end = 13
        case 17: start = 13; end = 14
        case 18: start = 14; end = 17
        case 19: start = 17; end = 18
        case 20: start = 18; end = 19
        case 21: start = 19; end = 20
        case 22: start = 20; end = 22
        case 23: start = 22; end = 23
        case 24: start = 23; end = 23
        case 25: start = 24; end = 25
        case 26: start = 25; end = 25
        case 27: start = 26; end = 27
        case 28: start = 27; end = 28
        case 29: start = 28; end = 28
        case 30: start = 28; end = 29
        case 31: start = 29; end = 31
        case 32: start = 31; end = 32
        case 33: start = 32; end = 33
        case 34: start = 33; end = 34
        case 35: start = 35; end = 36
        case 36: start = 36; end = 37
        case 37: start = 37; end = 40
        case 38: start = 40; end = 41
        case 39: start = 41; end = 42
        case 40: start = 42; end = 44
        case 41: start = 44; end = 45
        case 42: start = 45; end = 46
        case 43: start = 46; end = 46
        case 44: start = 47; end = 48
        case 45: start = 48; end = 50
        case 46: start = 50; end = 50
        case 47: start = 51; end = 51
        case 48: start = 51; end = 52
        case 49: start = 52; end = 54
        case 50: start = 54; end = 55
        case 51: start = 55; end = 57
        case 52: start = 57; end = 57
        case 53: start = 58; end = 58
        case 54: start = 58; end = 59
        case 55: start = 59; end = 60
        case 56: start = 61; end = 61
        case 57: start = 62; end = 62
        case 58: start = 63; end = 63
        case 59: start = 64; end = 65
        case 60: start = 65; end = 66
        case 61: start = 66; end = 67
        case 62: start = 67; end = 68
        case 63: start = 68; end = 68
        case 64: start = 69; end = 69
        case 65: start = 69; end = 70
        case 66: start = 70; end = 72
        case 67: start = 72; end = 72
        case 68: start = 72; end = 75
        case 69: start = 75; end = 77
        case 70: start = 77; end = 78
        case 71: start = 78; end = 79
        case 72: start = 79; end = 81
        case 73: start = 81; end = 82
        case 74: start = 83; end = 84
        case 75: start = 84; end = 85
        case 76: start = 85; end = 86
        case 77: start = 86; end = 87
        case 78: start = 87; end = 91
        case 79: start = 92; end = 93
        case 80: start = 93; end = 04
        case 81: start = 94; end = 95
        case 82: start = 95; end = 96
        case 83: start = 96; end = 97
        case 84: start = 97; end = 98
        case 85: start = 98; end = 99
        case 86: start = 99; end = 100
        case 87: start = 100; end = 101
        case 88: start = 101; end = 102
        case 89: start = 102; end = 105
        case 90: start = 105; end = 106
        case 91: start = 106; end = 107
        case 92: start = 107; end = 108
        case 93: start = 108; end = 109
        case 94: start = 109; end = 110
        case 95: start = 110; end = 111
        case 96: start = 111; end = 112
        case 97: start = 112; end = 113
        case 98: start = 113; end = 113
        case 99: start = 114; end = 114
        case 100: start = 114; end = 115
        case 101: start = 115; end = 115
        case 102: start = 116; end = 117
        case 103: start = 117; end = 119
        case 104: start = 119; end = 121
        case 105: start = 121; end = 123
        case 106: start = 123; end = 126
        case 107: start = 126; end = 129
        case 108: start = 129; end = 130
        case 109: start = 130; end = 131
        case 110: start = 132; end = 132
        case 111: start = 132; end = 133
        case 112: start = 133; end = 133
        case 113: start = 134; end = 134
        case 114: start = 134; end = 135
        case 115: start = 135; end = 136
        case 116: start = 136; end = 137
        case 117: start = 137; end = 137
        case 118: start = 137; end = 139
        case 119: start = 139; end = 148
        case 120: start = 148; end = 148
        case 121: start = 149; end = 149
        case 122: start = 149; end = 150
        case 123: start = 150; end = 150
        case 124: start = 150; end = 151
        case 125: start = 151; end = 151
        case 126: start = 151; end = 152
        case 127: start = 152; end = 152
        case 128: start = 152; end = 153
        case 129: start = 153; end = 153
        case 130: start = 153; end = 154
        case 131: start = 154; end = 154
        case 132: start = 154; end = 155
        case 133: start = 155; end = 156
        case 134: start = 156; end = 156
        case 135: start = 156; end = 157
        case 136: start = 157; end = 159
        case 137: start = 159; end = 159
        case 138: start = 160; end = 160
        case 139: start = 160; end = 162
        case 140: start = 162; end = 163
        case 141: start = 163; end = 164
        case 142: start = 164; end = 164
        case 143: start = 164; end = 165
        case 144: start = 165; end = 166
        case 145: start = 167; end = 168
        case 146: start = 168; end = 169
        case 147: start = 169; end = 170
        case 148: start = 170; end = 171
        case 149: start = 171; end = 171
        case 150: start = 172; end = 172
        default:
            return []
        }
        return getTehilim(from: start, to: end)
    }
    
    func getNamesTehilimOfEllulMonthBy(dayOfMonth: Int, month: Int) -> [String] {
        var start: Int = -1
        var end: Int = -1
        if month == 13 {
            switch dayOfMonth {
            case 1: start = 0; end = 2
            case 2: start = 2; end = 4
            case 3: start = 4; end = 8
            case 4: start = 8; end = 10
            case 5: start = 10; end = 12
            case 6: start = 12; end = 17
            case 7: start = 17; end = 20
            case 8: start = 20; end = 23
            case 9: start = 44; end = 27
            case 10: start = 27; end = 29
            case 11: start = 29; end = 33
            case 12: start = 33; end = 37
            case 13: start = 37; end = 42
            case 14: start = 42; end = 46
            case 15: start = 46; end = 50
            case 16: start = 50; end = 52
            case 17: start = 52; end = 57
            case 18: start = 57; end = 59
            case 19: start = 59; end = 62
            case 20: start = 63; end = 66
            case 21: start = 66; end = 68
            case 22: start = 69; end = 72
            case 23: start = 72; end = 77
            case 24: start = 77; end = 81
            case 25: start = 81; end = 85
            case 26: start = 85; end = 91
            case 27: start = 92; end = 95
            case 28: start = 95; end = 98
            case 29: start = 98; end = 101
            default:
                return []
            }
        } else {
            switch dayOfMonth {
            case 1: start = 101; end = 106
            case 2: start = 106; end = 109
            case 3: start = 109; end = 112
            case 4: start = 112; end = 114
            case 5: start = 114; end = 117
            case 6: start = 117; end = 123
            case 7: start = 123; end = 130
            case 8: start = 130; end = 133
            case 9: start = 133; end = 142
            default:
                return []
            }
        }

        return getTehilim(from: start, to: end)
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
        
        prakim.remove(at: 6)
        
        return prakim
    }

    private func getTehilim(from: Int, to: Int) -> [String] {
        debugPrint(chaptersArray.count)
        return Array(chaptersArray[from...to])
    }
    
}










