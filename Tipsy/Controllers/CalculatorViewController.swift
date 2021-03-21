//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import Foundation
import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    var tip = 0.0
    var totalPeople = 2
    var billTotal = 0.0
    var finalPricePerPerson = ""


    @IBAction func tipChanged(_ sender: UIButton) {
        
        // Force fully end keyboard
        billTextField.endEditing(true)
        
        // Get name of button thats currently selected
        let buttonPressed = sender.currentTitle
        
        if buttonPressed=="0%"{
            // deselect other 2 buttons
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            zeroPctButton.isSelected = true
        }
        else if buttonPressed=="10%"{
            // deselect other 2 buttons
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            zeroPctButton.isSelected = false
            tip = 0.1
        }
        else{
            // deselect other 2 buttons
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            zeroPctButton.isSelected = false
            tip = 0.2
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
            splitNumberLabel.text = String(format: "%.0f", sender.value)
        totalPeople = Int(sender.value)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        //Get the text the user typed in the billTextField
                let bill = billTextField.text!
                
                //If the text is not an empty String ""
                if bill != "" {
                    
                    //Turn the bill from a String e.g. "123.50" to an actual String with decimal places.
                    //e.g. 125.50
                    billTotal = Double(bill)!
                    
                    //Multiply the bill by the tip percentage and divide by the number of people to split the bill.
                    let result = (billTotal * (1 + tip)) / Double(totalPeople)
                    
                    //Round the result to 2 decimal places and turn it into a String.
                    finalPricePerPerson = String(format: "%.2f", result)
                }
    }
                    
                    // call next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
                        
                        if segue.identifier == "goToResult"{
                            
                            // Get hold of instance of destination segue(controller)
                            let destinationVC = segue.destination as! ResultsViewController
                            
                            // Set variables
                            destinationVC.numberOfPeople = totalPeople
                            destinationVC.tip = Int(tip * 100)
                            destinationVC.totalPerPerson = finalPricePerPerson
                        }
                    }
    
}

