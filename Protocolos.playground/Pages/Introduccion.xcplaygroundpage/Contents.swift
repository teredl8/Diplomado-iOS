import Foundation

//Protocolos
//Permite definir la lista mínima de características que queremos

let data = [
    ["Eva", "30", "6"],
    ["Saleh", "40", "18"],
    ["Amit", "50", "20"],
]

func printTable(_ data: [[String]], withColumnHeaders columnLabels: [String]) {
    var headerRow = "|"
    
    var columnWitdths = [Int]()
    
    for columnLabel in columnLabels {
        let columnHeader = " \(columnLabel) |"
        headerRow += columnHeader
        columnWitdths.append(columnLabel.count)
    }
    print(headerRow)
    
    
    for row in data {
        var output = "|"
        
        for (index, item) in row.enumerated() {
            let paddingNeeded = columnWitdths[index] - item.count
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
            output += "\(padding) \(item) |"
        }
        
        print(output)
    }
}

printTable(data, withColumnHeaders: ["Employee name", "Age", "Years of experience"])

               


