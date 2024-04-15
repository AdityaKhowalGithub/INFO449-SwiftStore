//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//


/*Implement the following:

All items sold in the store have a "stock keeping unit" (SKU) number associated with them. When the item is swiped over the barcode scanner, the tag on the item sends the SKU to the Register, where it is looked up and added to the Receipt. To support this, you need to:

Implement SKU as a protocol. It should require a property name that retrieves the name of the item, and a method price that returns the price (as an Int, in USD pennies).
When a Register is created, have it create a Receipt on which to capture all the items scanned.
On the Register class, implement a scan method that takes a SKU as a parameter, and add the SKU to the Receipt.
The Register is responsible for displaying the total along the way, so you need to:

Implement a subtotal method that returns the current total for all the items on the Receipt.
Implmement a total method that returns the Receipt (which contains all the items scanned), and clears its state to start a new Receipt. (In other words, subtotal displays the price along the way, whereas total is the finished transaction.)
The Receipt is a list of the entire transaction.

Implement an items method that returns the list of SKUs that were scanned.
Implement an output method to print out all of the items stored on the Receipt.
Create a class Item that implements SKU and uses a price-per-item pricing scheme. That is to say, a $4.99 can of beans (an Iten("Beans", 499)) or a $.99 pencil (a Item("Pencil", 99)).

Create a unit test that tests adding a single Item to the Register and displays its subtotal (which should be the single Item's price).*/

import Foundation

protocol SKU {
    var name: String {get}
    func price() -> Int
}

class Item: SKU {
    var name: String
    private var priceEach: Int
    
    init(name: String, priceEach: Int) {
        self.name = name
        self.priceEach = priceEach
    }
    init(SKU: SKU){
        self.name = SKU.name
        self.priceEach = SKU.price()
    }
    
    func price() -> Int{
        return self.priceEach
    }
}

class Receipt {
    private var items: [SKU]
    init() {
        self.items = []
    }
    
    func add(_ item: SKU){
        self.items.append(item)
    }
    func total() -> Int {
        var t = 0
        for x in items{
            t += x.price()
        }
        return t
    }
    func output() -> String{
        var receiptText = "Receipt:\n"
       for item in items {
        let priceFormatted = String(format: "%.2f", Double(item.price()) / 100)
           receiptText += "\(item.name): $\(priceFormatted)\n"
       }
       let totalFormatted = String(format: "%.2f", Double(total()) / 100)
       receiptText += "------------------\n"
       receiptText += "TOTAL: $\(totalFormatted)"
       return receiptText
    }
}


class Register {
    private var receipt: Receipt
    init(){
        self.receipt = Receipt()
    }
    func scan(_ item: SKU){
        receipt.add(item)
    }
    func subtotal() -> Int{
        return receipt.total()
    }
    func total() -> Receipt{
        let r = receipt
        self.receipt = Receipt()
        return r
    }
    
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}

