import UIKit

var greeting = "Hello, playground"

//1. Closures

//Non-Escaping Closure
var closure = {
    print("type of non-escaping closure")
}
func loadInfo(closure : () -> Void) {
    closure()
}

loadInfo {
    print("another type of non-escaping closure")
}

func add(num1: Int, num2: Int, completion: (Int) -> Void) {
    let x = num1 + num2
    completion(x)
}

add(num1: 6, num2: 5) { result in
    print("this is the result of the numbers added in the function \(result); another way to write a non-escaping closure")
}

//Escaping
func subtract(num1: Int, num2: Int, completion: @escaping (Int) -> Void) {
    print("start of demonstration")
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let x = num1 + num2
        completion(x)
    }
    print("assumed end of demonstration; it is possible for completion to appear after this print statement because the lambda escapes the subtract function")
    
}

subtract(num1: 11, num2: 5) { result in
    print("this is the result from completion: \(result)")
}

//2. Protocol Usage - used to define contracts to later be implemented in classes that inherit from it; similar to interfaces in Kotlin

protocol Basketball {
    var coachName: String { get set }
    
    func dribbleBasketball()
    func shootBasketball()
}

protocol Football {
    var coachName: String { get set}
    
    func blockLinebacker()
    func runRoute()
    
}

class popularSportExercises : Basketball, Football {
    var coachName = "John"
    
    func dribbleBasketball() {
        print("player runs up and down the court dribbling basketball")
    }
    
    func shootBasketball() {
        print("player practices three point jumpshot")
    }
    
    func blockLinebacker() {
        print("player blocks linebacker from getting to quarterback")
    }
    
    func runRoute() {
        print("wide receiver runs route in anticipation for the pass from quarterback")
    }
    
    
}

//ARC
//example class
// The Retain Cycle is prevalent in this class because Student depends on TypeOfBatch and TypeOfBatch is dependent on Student, so if not handled with a weak var, or declaring the depending variable to nil at the end of its use necessity, The Retain Cycle will not decompress in the most optimal capacity
class Student {
    //Batch is weak var because Student is the least important variable, prevents excess Memory issues with Batch Dependency in the Retain Cylce
    weak var batchName: TypeOfBatch?
    var batchLength: String
    
    init(batchName: TypeOfBatch?, batchLength: String) {
        self.batchName = batchName
        self.batchLength = batchLength
    }
    
    deinit {
        
    }
}

class TypeOfBatch {
    var batchName: String
    var stack: [String]
    var students: [Student] = []
    
    init(batchName: String, stack: [String], students: [Student]) {
        self.batchName = batchName
        self.stack = stack
        self.students = students
    }
    
    deinit {
        
    }
}


var firstBatch : TypeOfBatch? = TypeOfBatch(batchName: "Android", stack: ["Kotlin", "Jetpack Compose", "Coroutines", "State Management"], students: [])
var firstStudent : Student? = Student(batchName: firstBatch ?? nil, batchLength: "8 weeks")

if let student = firstStudent {
    firstBatch?.students.append(student)
}

// The weak variable allows for each variable to be initialized and de-initialized
firstStudent?.batchName = nil // reduces RetainCycle to 2
firstStudent = nil // reduces RetainCycle to 1
firstBatch = nil // reduces RetainCycle to 0

//Multi-Threading
//GCD

//Main Queue
DispatchQueue.main.async {
    print("this block of code is on the main thread, is used sparingly, specific for UI necessities")
}

//Global Queue
DispatchQueue.global().async {
    print("this block of code is on the global scope and is used for simple one time operations")
}

//Serial and Concurrent
let serialQueue = DispatchQueue(label: "com.example.Serial")
serialQueue.async {
    print("this thread runs code sequentially")
}

let concurrentQueue = DispatchQueue(label: "com.example.Concurrent")
concurrentQueue.async {
    print("this thread operates code asynchronously, without priority for each call")
}

//OperationQueue - allows calls to be grouped and monitored and cancelled
let operationQueue = OperationQueue()
let op1 = BlockOperation {
    print("first op")
}

let op2 = BlockOperation {
    print ("second op")
}

operationQueue.addOperations([op1, op2], waitUntilFinished: true)


//actor - allows for thread safety prevents race condition (multiple threads accessing the same data files at the same time
actor ExampleActor {
    var x : String
    var y : Int
    
    init(x: String, y: Int) {
        self.x = x
        self.y = y
    }
    deinit {
        
    }
}

//Async Let example
func asyncExample() async {
    print("this is an example")
}

Task {
    async let x1: () = asyncExample()
    async let x2: () = asyncExample()

    await x1
    await x2

}





