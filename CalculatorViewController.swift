//
//  ViewController.swift
//  Calculator
//
//  Created by Will Devon-Sand on 3/29/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import Foundation

class CalculatorViewController: UIViewController {
    
    public var currentUserIsTyping = false,
    binaryOperation = false
    private var digit = " ", mathematicalSymbol = " "
    private var variableValue = 0.0
    private var variableHasBeenUsed = false
    private var saveProgam:CalculatorBrain.PropertyList?
    private var brain = CalculatorBrain()
    
    @IBOutlet weak var clearButton: UIButton!
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let navcon = destinationVC as? UINavigationController{
            destinationVC = navcon.visibleViewController ?? destinationVC
        }
        if  let graphVC = destinationVC as? GraphViewController {
            if segue.identifier == "graphSegue"{
                graphVC.newXPoint = variableValue
                graphVC.newYPoint = brain.result
                graphVC.navigationItem.title = brain.printTitle
            }
        }
    }
   
    @IBOutlet weak var display: UILabel!
    
    private var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    @IBAction func setVariable(_ sender: UIButton) {
        brain.setOperand(variableName: sender.currentTitle!)
        display.text = sender.currentTitle
        variableHasBeenUsed = true
        
    }
    
    @IBAction func storeVariableValue() {
        variableValue = displayValue
        brain.variableValuesDictionary["M"] = variableValue
        saveProgam = brain.program
        display.text! = clearDisplay()
        currentUserIsTyping = false
    }
    
    @IBAction func undo() {
        let displayCount = (display.text?.characters.count)!
        if currentUserIsTyping{
            if displayCount > 1 {
                display.text = display.text?.substring(to: (display.text?.index(before: (display.text?.endIndex)!))!)
            } else{
                display.text! = clearDisplay()
            }
        }
        else{
            display.text! = clearDisplay();
        }
        brain.undo()
        currentUserIsTyping = false
        if variableHasBeenUsed{
            brain.setOperand(operand: Double (digit)!)
        }
    }
    
    @IBAction func restore() {
        if saveProgam != nil{
            brain.program = saveProgam!
            displayValue = brain.result
        }
    }
    
    @IBAction func clearButtonWehnTapped(_ sender: AnyObject) {
        display.text! = clearDisplay();
        currentUserIsTyping = false
        reNew()
    }
    
    @IBAction private func mathematicalOperation(_ sender: UIButton) {
        mathematicalSymbol = sender.currentTitle!
        if currentUserIsTyping{
            brain.setOperand(operand: displayValue)
            currentUserIsTyping = false
        }
        brain.preformOperation(mathematicalSymbol:mathematicalSymbol)
        displayValue = brain.result
    }
    
     func clearDisplay()->String{
        return " "
    }
    private func reNew(){
        self.viewDidLoad()
        self.viewWillAppear(true)
        brain.clear()
    }
    
    @IBAction func PrintDescription(_ sender: UIButton) {
        display.text! = clearDisplay()
        brain.preformOperation(mathematicalSymbol: "")
        display.text! = brain.printDescription
    }
    
    @IBAction private func digit(_ sender: UIButton) {
        digit = sender.currentTitle!
        if currentUserIsTyping{
            let currentDisplayText = display.text!
            display.text! = currentDisplayText + digit
            digit = currentDisplayText + digit
            
        }else{
            display.text! = digit
        }
        currentUserIsTyping = true
    }
}

