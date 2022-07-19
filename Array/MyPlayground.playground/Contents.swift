import UIKit
import Foundation
import Darwin

protocol Moveable {
    func goForward()
    func goBackward()
}

class ToyCar: Moveable {
    func goForward() {}
    func goBackward() {}
    func honk(){
        print("Honky honk honk")
    }
}

class SkateBoard: Moveable {
    func goForward() {}
    func goBackward() {}
    func kickFlip() {
        print("Wow kickflip")
    }
}

let inventory: [Moveable] = [ToyCar(), SkateBoard(), ToyCar(), SkateBoard(), ToyCar()]

var toyCarNumber = 0
var skateBoardNumber = 0


for stock in inventory {
    if stock is ToyCar {
        toyCarNumber += 1
    }
    if stock is SkateBoard {
        skateBoardNumber += 1
    }
}

toyCarNumber
skateBoardNumber

// Downcasting

if let toycar = inventory[0] as? ToyCar {
    toycar.honk()
}

for toy in inventory {
    if let store = toy as? ToyCar {
        store.honk()
    }
    if let kick = toy as? SkateBoard {
        kick.kickFlip()
    }
}


// Force Downcasting ~As a developer you are guarentting this info is there.

let toyCar = inventory[0] as! ToyCar
toyCar.honk()


////////////////////////////////////////////////////////////////////////////////////// Delegate

protocol iOSDeveloperNeeded {
    func buildApp()
}

class Boss {
    func Meetings() {
        print("go to meetings")
        delegate?.buildApp()
    }
    var delegate: iOSDeveloperNeeded?
}

class Developer: iOSDeveloperNeeded {
    var name: String?
    init(name: String?) {
        self.name = name
    }
    func buildApp() {
        print("\(name ?? "someone else ") Build build build")
    }
}

let bossJake = Boss()
bossJake.Meetings()

let tim = Developer(name: "Jimmy")
bossJake.delegate = tim
bossJake.Meetings()
//tim.buildApp()

/////////////////////////////////////////// Codable protocol

class Person: Codable {
    let name: String
    var lovesApple: Bool
    
    init(name: String, lovesApple: Bool) {
        self.name = name
        self.lovesApple = lovesApple
    }
}
do {
    let amy = Person(name: "Amy", lovesApple: true)
    let encoder = JSONEncoder()
    let data = try encoder.encode(amy)
    let results = String(data: data, encoding: .utf8)
} catch {
    print(" Hello world\(error.localizedDescription)")
}


do {
    let decodeMessage = "{\"name\":\"Amy\",\"lovesApple\":true}"
    let decoder = JSONDecoder()
    let data = decodeMessage.data(using: .utf8)
    let myData = try decoder.decode(Person.self,from: data!)
    myData.name
    myData.lovesApple
} catch {
    print("\(error.localizedDescription)")
}
////////////////////////////////////////////////////////////UserDefaults
var fruit = "Apple"


UserDefaults.standard.set(fruit, forKey: "text")

let killer = UserDefaults.standard.string(forKey: "text")
killer

///File Manager
var bunny = "bunny"
var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
// If the user put some sort of data in textfield or w/e
if let data = killer?.data(using: .utf8) {
    do {
        try data.write(to: url)
    }catch {
        error.localizedDescription
    }
}



///In viewdidload put this to get the file:
//var cool = ""
//var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//
//if FileManager.default.fileExists(atPath: url!.path) {
//    cool = try! String(contentsOf: url!, encoding: .utf8)
//}
//cool

// Protocol

protocol rockLifter {
    func pickUpRocks()
}


//Delegate
class Contractor: rockLifter {

    var name = ""
    init(name: String) {
        self.name = name
    }
    func pickUpRocks() {
        print("\(name) is going to to pick up these rocks so i don't have too")
    }
}

// Delegator
class Forman {
    var name = ""
    var delegate: rockLifter?
    init(name: String) {
        self.name = name
    }
    
    func getPeopleToWork() {
        print("Go to meetings")
        delegate?.pickUpRocks() ?? print("Shit i need to pick up rocks cause i didn't hire anyone")
    }
}

let Mike = Forman(name: "Mike")
let Jimmy = Contractor(name: "Jimmy")
Mike.delegate = Jimmy
Mike.getPeopleToWork()



var cool = [["Jimmy", "is cool"],["Timmy", "is cool"]]



for (index, element) in cool.enumerated() {
    print(element)
    print("I hate this fucker\(index)")
}









