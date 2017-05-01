import Quick
import Nimble
@testable import Calculator2
class CalculatorViewControllerSpec:QuickSpec{
    override func spec(){
        describe("ViewController"){
            var calculatorViewController:CalculatorViewController!
            beforeEach {
                let storyboard = UIStoryboard(name:"Main", bundle:nil)
                calculatorViewController = storyboard.instantiateViewController(withIdentifier: "CalculatorViewControllerID") as! CalculatorViewController
                let _ = calculatorViewController.view
            }
            it(" should be loaded and not be nil"){
                expect(calculatorViewController.view).notTo(beNil())
            }
            describe("The clear button"){
                beforeEach {
                calculatorViewController.clearButton.sendActions(for: .touchUpInside)
                }
                it(" is pressed, the user is not currently typing"){
                expect(calculatorViewController.currentUserIsTyping).to(equal(false))
                }
            }
            describe("Clear function"){
                it("should return an empty string for the display text"){
                    let displayText = calculatorViewController.clearDisplay()
                    expect(displayText).to(equal(" "))
                }
            }
        }
    }
}




