import Foundation

class CalculatorBrain{
    
    private var internalProgram = [AnyObject]()
    private  var accumalator = 0.0
    private var description = " "
    var isPartailResult = true
    var variableKey = ""
    var variableValue = 0.0
    var variableValuesDictionary:Dictionary<String, Double> = [:]
    var nonBinary = false
    var firstOperand = 0.0
    
    func setOperand(operand:Double){
        accumalator = operand
        firstOperand = operand
        internalProgram.append(operand as AnyObject)
        description += String(operand)
    }
    
    func setOperand(variableName: String){
        variableKey = variableName
        internalProgram.append(variableName as AnyObject)
        if variableValuesDictionary[variableName] != nil{
            accumalator = variableValuesDictionary[variableKey]!
            description += variableName
        }
    }
    
    private var  operations:Dictionary<String, Operation> = [
        "pie" :Operation.Constant(M_PI),
        "sin": Operation.UniaryOperations(sqrt),
        "e" :Operation.Constant(M_E),
        "tan":Operation.UniaryOperations(tan),
        "log": Operation.UniaryOperations(log),
        "logten" :Operation.UniaryOperations(log10),
        "logtwo" :Operation.UniaryOperations(log2),
        "+" :Operation.BinaryOperations({$0 + $1}),
        "-": Operation.BinaryOperations({$0 - $1}),
        "/": Operation.BinaryOperations({$0 / $1}),
        "x" : Operation.BinaryOperations({$0 * $1}),
        "cos" : Operation.UniaryOperations(cos),
        "√":Operation.UniaryOperations(sqrt),
        "=":Operation.Equals,
        ]
    
    private enum Operation {
        case Constant(Double)
        case UniaryOperations((Double) ->Double)
        case BinaryOperations((Double, Double)->Double)
        case Equals
    }
    
    func preformOperation(mathematicalSymbol:String){
        description += mathematicalSymbol
        internalProgram.append(mathematicalSymbol as AnyObject)
        if let operation = operations[mathematicalSymbol]{
            switch operation {
            case .Constant(let value):accumalator = value;nonBinary = true;
            case .BinaryOperations(let function): pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumalator);
            case.UniaryOperations(let function):accumalator = function(accumalator); nonBinary = true
                description = mathematicalSymbol + String(firstOperand)
            case.Equals:
                if pending != nil{
                    accumalator = pending!.binaryFunction(pending!.firstOperand, accumalator);
                    description += String(accumalator)
                    isPartailResult = false
                }
            break
            }
        }
    }
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) ->Double
        var firstOperand: Double
    }
    typealias PropertyList = AnyObject
    
    var program: PropertyList{
        get{
            return internalProgram as CalculatorBrain.PropertyList
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject]{
                for op in arrayOfOps{
                    if let operand = op as? Double{
                        setOperand(operand: operand)
                    } else if let operation = op as? String{
                        preformOperation(mathematicalSymbol: operation)
                    }else if let variable = op as? Double {
                        setOperand(operand: variable)
                    }
                }
            }
        }
    }
   
    func undo(){
        description = description.substring(to: (description.index(before: (description.endIndex))))
    }
    
    func clear(){
        accumalator = 0.0
        pending = nil
        internalProgram.removeAll()
        description = " "
    }
    
    var result:Double{
        get{
            return accumalator
        }
    }
    var printTitle:String{
        get{
        return description 
        }
    }
    
    var printDescription:String{
        get{
            if nonBinary{
                return description + " =" + " " + String(accumalator)
            }
            else if isPartailResult{
                return description + "..."
            }
            else{
                return description + String(accumalator)
            }
        }
    }
    
}
