import XCTest
@testable import DomainModel

class MoneyTests: XCTestCase {

  let tenUSD = Money(amount: 10, currency: "USD")
  let twoUSD = Money(amount: 2, currency: "USD")
  let fourUSD = Money(amount: 4, currency: "USD")
  let threeEUR = Money(amount: 3, currency: "EUR")
  let fiveCAN = Money(amount: 5, currency: "CAN")
    
  let fiveUSD = Money(amount: 5, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")

  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")

    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
  }

  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
  }

  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }

  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
  }

  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
  }
    
    func testSubtractUSDtoUSD() {
        let result = tenUSD.subtract(fiveUSD)
        XCTAssert(result.amount == 5)
        XCTAssert(result.currency == "USD")
        
    }
    
    func testSubtractUSDtoUSD_0() {
        let result = tenUSD.subtract(tenUSD)
        XCTAssert(result.amount == 0)
        XCTAssert(result.currency == "USD")
    }
    
    func testSubtractUSDtoGBP() {
        let result = tenUSD.subtract(fiveGBP)
        XCTAssert(result.amount == 0)
        XCTAssert(result.currency == "GBP")
    }
    
    func testSubtractEURtoEUR() {
        let result = fifteenEUR.subtract(fifteenEUR)
        XCTAssert(result.amount == 0)
        XCTAssert(result.currency == "EUR")
    }
    
    func testSubtractCANtoCAN() {
        let result = fifteenCAN.subtract(fifteenCAN)
        XCTAssert(result.amount == 0)
        XCTAssert(result.currency == "CAN")
    }
    
    func testSubtractGBPtoGBP() {
        let result = fiveGBP.subtract(fiveGBP)
        XCTAssert(result.amount == 0)
        XCTAssert(result.currency == "GBP")
    }
    
    func testSubtractUSDtoCAN() {
        let result = fourUSD.subtract(fiveCAN)
        XCTAssert(result.amount == 0)
        XCTAssert(result.currency == "CAN")
    }
    
    func testSubtractUSDtoERO() {
        let result = twoUSD.subtract(threeEUR)
        XCTAssert(result.amount == 0)
        XCTAssert(result.currency == "EUR")
    }
    
    
    
    
    

    static var allTests = [
        ("testCanICreateMoney", testCanICreateMoney),

        ("testUSDtoGBP", testUSDtoGBP),
        ("testUSDtoEUR", testUSDtoEUR),
        ("testUSDtoCAN", testUSDtoCAN),
        ("testGBPtoUSD", testGBPtoUSD),
        ("testEURtoUSD", testEURtoUSD),
        ("testCANtoUSD", testCANtoUSD),
        ("testUSDtoEURtoUSD", testUSDtoEURtoUSD),
        ("testUSDtoGBPtoUSD", testUSDtoGBPtoUSD),
        ("testUSDtoCANtoUSD", testUSDtoCANtoUSD),

        ("testAddUSDtoUSD", testAddUSDtoUSD),
        ("testAddUSDtoGBP", testAddUSDtoGBP),
    ]
}

