
import Quick
import Nimble
@testable import Calculator2

class CalculatorBrainSpec:QuickSpec{
    override func spec(){
        describe("first operand"){
            var brain : CalculatorBrain?
            beforeEach {brain = CalculatorBrain()}
            describe("first operand is set correctly when the operand is a number"){
                context("operand paramater equals 1"){
                    beforeEach {
                        brain?.setOperand(operand: 1)
                    }
                    it("is set to the operand parameter"){ expect(brain!.firstOperand).to(equal(1))
                    }
                    it("is added to the description"){
                        expect(brain!.printDescription).to(equal(" 1.0..."))
                    }
                }
            }
            describe("operand is beign set for the variable"){
                 context("operand variable is set to M"){
                beforeEach {
                    brain?.setOperand(variableName: "M")
                }
                    it("variable key should equal 'M'"){
                        expect(brain!.variableKey).to(equal("M"))
                    }
                }
            }
            
        }
    }
}
