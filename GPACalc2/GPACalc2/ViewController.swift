//
//  ViewController.swift
//  GPACalc2
//
//  Created by Rob on 2/14/16.
//  Copyright © 2016 Rob. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    //UI Components: TextFields, Lables etc...
    @IBOutlet weak var crsTitle: UITextField!
    @IBOutlet weak var assTypePts: UITextField!
    @IBOutlet weak var assTypeMax: UITextField!
    @IBOutlet weak var assTypeWeight: UITextField!
    
    @IBOutlet weak var midTermPts: UITextField!
    @IBOutlet weak var midTermMax: UITextField!
    @IBOutlet weak var midTermWeight: UITextField!
    
    @IBOutlet weak var finalPts: UITextField!
    @IBOutlet weak var finalMax: UITextField!
    @IBOutlet weak var finalPrc: UITextField!
    @IBOutlet weak var numCreds: UITextField!
    
    //Course Labels
    @IBOutlet weak var LCrs1: UILabel!
    @IBOutlet weak var LCrs2: UILabel!
    @IBOutlet weak var LCrs3: UILabel!
    @IBOutlet weak var LCrs4: UILabel!
    
    //counter for the labels: keeps track of how many classes have been addded
    var classCounter: Int = 0;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //sets the enity of the textfield to refer to itself as to enable to self referential call the resignFirstResonder functions to enable the exiting of the keyboard on "return" pressed. 
        
        //The function below is designed to resign the first repsonder in association of a textField. Thus, you have to give a reference to the delegate of each textField to refer to itself to get the solution to work for all textFields
        crsTitle.delegate = self;
        assTypePts.delegate = self;
        assTypeMax.delegate = self;
        assTypeWeight.delegate = self;
        midTermPts.delegate = self;
        midTermMax.delegate = self;
        midTermWeight.delegate = self;
        finalPts.delegate = self;
        finalMax.delegate = self;
        finalPrc.delegate = self;
        numCreds.delegate = self;
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Buttons:: add and deletecourse
    //Button Add Course
    @IBAction func addCrs(sender: UIButton) {
        //print("Add Test") --> Test was successfull
        
        //variable to hold the currentyl calculated gpa
        var gpa: Float;
        
        //if any input is invalid: prompt user with a error dialog and then let them correct
        //their input
        if(checkInput()==false){
            let alertTitle = "Alert"
            let alertMessage = "Invalid Input: Please check you input again!"
            let alertOkButtonText = "Ok"
            
          
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
                //We add buttons to the alert controller by creating UIAlertActions:
                let actionOk = UIAlertAction(title: alertOkButtonText,
                                             style: .Default,
                                             handler: nil) //You can use a block here to handle a press on this button
                
                alertController.addAction(actionOk)
            
            
                /*let alertView = UIAlertView(title: alertTitle, message: alertMessage, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: alertOkButtonText)
                alertView.show()*/
            
        } else {
        //input has passed the inputCheck validation and thus all input is valid so increment the classCounter by 1
        
            classCounter+=1;
            gpa = calcGPA();
            
            //max 4 course as per instructions so cases stop at 4
            switch classCounter {
            case 1://Course 1
                LCrs1.text = crsTitle.text! + "GPA " + String(format: "%.2f",gpa)
            case 2: //Course 2
                LCrs2.text = crsTitle.text! + "GPA " + String(format: "%.2f",gpa)
            case 3: //Course 3
                LCrs3.text = crsTitle.text! + "GPA " + String(format: "%.2f",gpa)
            case 4: //Course 4
                LCrs4.text = crsTitle.text! + "GPA " + String(format: "%.2f",gpa)
                
            default:
                print("Only for courses! No other options...")
            }
            
            
        }
    
    }
    
    //Delete Course
    @IBAction func delCrs(sender: UIButton) {
        
        //print("Delete Test") --> Test was successfull
        
        switch classCounter {
        case 1://Course 1
            LCrs1.text = ""
        case 2: //Course 2
            LCrs2.text = ""
        case 3: //Course 3
            LCrs3.text = ""
        case 4: //Course 4
            LCrs4.text = ""
            
        default:
            print("Only for courses! No other options...")
        }

        
    
    }
    
    //checks for valid input: Validity Defintion: Value must not be blank;
    func checkInput() -> Bool{
        if(crsTitle.text==nil){
            return false
        } else if(assTypePts.text==nil){
            return false
        } else if(assTypeMax.text==nil){
            return false
        } else if(assTypeWeight.text==nil){
            return false
        } else if(midTermPts.text==nil){
            return false
        } else if(midTermMax.text==nil){
            return false
        } else if(midTermWeight.text==nil){
            return false
        } else if(finalPts.text==nil){
            return false
        } else if(finalMax.text==nil){
            return false
        } else if(finalPrc.text==nil){
            return false
        }; return true
        
    }
    
    
    //calculates GPA
    func calcGPA() -> Float{
        //varibles for the assignment sum grade, midTerm grade, final grade, and the calculated gpa using the previous variables
        var gpa, assSum, midTerm, final: Float;
        
        //calculates the assignment grade
        assSum = ((assTypePts.text! as NSString).floatValue / (assTypeMax.text! as NSString).floatValue) * (assTypeWeight.text! as NSString).floatValue;
        
        //calculates the mid term grade
        midTerm = ((midTermPts.text! as NSString).floatValue / (midTermMax.text! as NSString).floatValue) * (midTermWeight.text! as NSString).floatValue;
        
        //calculats the final grade
        final = ((finalPts.text! as NSString).floatValue / (finalMax.text! as NSString).floatValue) * (finalPrc.text! as NSString).floatValue;
        
        gpa = assSum + midTerm + final;
        
        return gpa
        
    }
    
    //testing rid the keyboard when the return key is pressed
    func textFieldShouldReturn(TextField: UITextField) -> Bool {
        
        TextField.resignFirstResponder();
                return true
    }
    
    
    
    
    
    
    


}

