//
//  ViewController.swift
//  Mod11
//
//  Created by clawesome on 10/15/21.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Store real accounts
        var realAccounts = [String]()
        // Printout string of all the invalid accounts
        var printOutStr = ""
        // Loop through 0 to 600k
        for x in 0...600000 {
            // Convert number to string
            var aacountStr = String(x)
            let checkDigit = aacountStr.last!.wholeNumberValue!
            // Drop last number of account
            aacountStr = String(aacountStr.dropLast())
            // Variable to hold the calculated sum
            var sum = 0
            // Create an array from the account string and reverse it so
            // it's easier to loop through starting with least significant digit first
            let accountArr = Array(aacountStr).reversed()
            // Loop through all of the numbers in the account
            for (i,val) in accountArr.enumerated() {
                let n = val.wholeNumberValue
                // Multiplier for the each digit is the index i plus 2, first multiplier
                // will be 0+2=2, then 1+2=3, then 2+2=4, etc...
                let multiplier = i+2
                // Add the digit times the multiplier and add to the existing sum
                sum = sum + (n! * multiplier)
            }
            // Get the value of the (sum mod 11) and subtract that from 11,
            // then mod 10 the result to so 10 becomes 0
            let mod = (11 - (sum % 11)) % 10
            
            // Add leading zeros
            var fullAccountStr = String(x)
            let diff = 10 - fullAccountStr.count
            fullAccountStr = "C" + Array(repeating: "0", count: diff) + fullAccountStr

            if mod != checkDigit {
                let accountPrintOut = "account: \(fullAccountStr) sum: \(sum) mod: \(mod)\n"
                printOutStr.append(accountPrintOut)
            } else {
                realAccounts.append(fullAccountStr)
            }
        }
        
        let filename = getDocumentsDirectory().appendingPathComponent("mod11.txt")

        print(filename)
        do {
            try printOutStr.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

