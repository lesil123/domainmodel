struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String
    
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    func convert (_ currName : String) -> Money {
        var calculate : Double = 0.0
        
        if (currency == "USD") {
            calculate = Double(amount)
        } else if (currency == "GBP") {
            calculate = Double(amount) / 0.5
        } else if (currency == "EUR") {
            calculate = Double(amount) / 1.5
        } else if (currency == "CAN") {
            calculate = Double(amount) / 1.25
        }

        if (currName != "USD") {
            if (currName == "GBP") {
                calculate *= 0.5
            } else if (currName == "EUR") {
                calculate *= 1.5
            } else if (currName == "CAN") {
                calculate *= 1.25
            }
        }
        
        return Money(amount: Int(calculate), currency: currName)
    }
    
    //amount;currency
    func add(_ mmoney : Money) -> Money {
       let newType = convert(mmoney.currency)
        
        return Money(amount: Int(newType.amount + mmoney.amount), currency: mmoney.currency)
        
    }
    
    func subtract(_ mmoney : Money) -> Money {
        let newType = convert(mmoney.currency)
         
         return Money(amount: Int(newType.amount - mmoney.amount), currency: mmoney.currency)
         
     }
    
    
}

////////////////////////////////////
// Job
//
public class Job {
    var title: String
    var type: JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    func calculateIncome(_ time:Int) -> Int {
        switch type {
        case .Hourly(let double):
            return Int(double * Double(time))
        case .Salary(let uInt):
            return Int(uInt)
        }
    }
    
    func raise(byAmount: Double) {
        switch type {
        case .Hourly(let double):
            self.type = JobType.Hourly(double + byAmount)
        case.Salary(let money):
            self.type = JobType.Salary(money + UInt(byAmount))
        }
    }
    
    func raise(byPercent: Double) {
        switch type {
        case .Hourly(let double):
            self.type = JobType.Hourly(double + (double * byPercent))
        case.Salary(let money):
            self.type = JobType.Salary(money + UInt(Double(money) * byPercent))
        }
        
    }
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var job: Job? {
        didSet {
            if age < 18 {
                job = nil
            }
        }
    }
    var spouse: Person? {
        didSet {
            if age < 18 {
                spouse = nil
            }
        }
    }
    
    init(firstName: String, lastName: String, age: Int) {
          self.firstName = firstName
          self.lastName = lastName
          self.age = age
          self.job = nil
          self.spouse = nil
      }
    
    func toString() -> String {
        var output = "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:"
        if job != nil {
            output += job!.title
        } else {
            output += "nil"
        }
        output += " spouse:"
        if spouse != nil {
            output += spouse!.firstName
        } else {
            output += "nil"
        }
        output += "]"
        return output
    
    }
    
    //ted.toString() == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person] = []
    
    init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members = [spouse1, spouse2]
        }
    }
    
    func haveChild(_ name : Person) -> Bool {
        if members[0].age > 21 || members[1].age > 21 {
            members.append(name)
            return true
        } else {
            return false
        }
    }
    
    func householdIncome() -> Int {
        var totalIncome : Int = 0
        for member in members {
            totalIncome += member.job?.calculateIncome(2000) ?? 0
        }
        return totalIncome
    }
}
