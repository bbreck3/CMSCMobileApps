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
    
    //array of the objects:
    //var classArr = [LCrs1.text,LCrs2,LCrs3,LCrs4];
    
   
    //counter for the labels: keeps track of how many classes have been addded
    var classCounter: Int = 0;
    
    /**
            Debugging Variables & UI Eelements:
     */
    @IBOutlet weak var classCounterDbg: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Does any additional setup after loading the view, typically from a nib.
        
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
        
        //handles the case that the keyboard is in number pad mode, as the soultion
        //standard keyboard only works if the "return" button is visible on the keypad...which is not
        // on the numeric keypad
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
        
        //sets the classCounter Label to the current count: on load should be zero
        
        //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
        
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
            
            //Alert to user that there input was invalid and to re check their input
            let alertTitle = "Alert"
            let alertMessage = "Invalid Input: Please check you input again!"
            let alertOkButtonText = "Ok"
            
          
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
                //We add buttons to the alert controller by creating UIAlertActions:
                let actionOk = UIAlertAction(title: alertOkButtonText,
                                             style: .Default,
                                             handler: nil) //You can use a block here to handle a press on this button
                
                alertController.addAction(actionOk)
                presentViewController(alertController, animated: true, completion:nil)
            return;
            // end invalid input alert
            
        } else if(classCounter>3){
            
            //Alert to user that no more courses could be added...the maximum course limit has been exceeded
            let alertTitle = "Alert"
            let alertMessage = "Max Course limit exceeded! Cannot add more courses!"
            let alertOkButtonText = "Ok"
            
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            //We add buttons to the alert controller by creating UIAlertActions:
            let actionOk = UIAlertAction(title: alertOkButtonText,
                                         style: .Default,
                                         handler: nil) //You can use a block here to handle a press on this button
            
            alertController.addAction(actionOk)
            presentViewController(alertController, animated: true, completion:nil)
            return;
            //end max course limit exceeded alert
            
            
        } else {
            
        //input has passed the inputCheck validation and thus all input is valid so increment the classCounter by 1
        
            classCounter+=1;
            //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
            //calculate gpa
            gpa = calcGPA();
            
            //output gpa result to UI in order of class counter: 1 --> the first course added
            //                                                   2 --> second courses added
             //                                                  3 --> third courses added
            //                                                   4 --> fourth courses added
            //                                                    courses will be deleted in the order the were added by the course count: if the current count is 2 then course two will be deleted
            //max 4 course as per instructions so cases stop at 4
            
            
            
            if(classCounter==1){
                LCrs1.text = crsTitle.text! + " GPA " + String(format: "%.2f",gpa)
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                return;
            } else if(classCounter==2){
                LCrs2.text = crsTitle.text! + " GPA " + String(format: "%.2f",gpa)
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                return;
            } else if(classCounter==3){
                LCrs3.text = crsTitle.text! + " GPA " + String(format: "%.2f",gpa)
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                return;
            } else {
                LCrs4.text = crsTitle.text! + " GPA " + String(format: "%.2f",gpa)
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                return;
            } //end if else chain

            
            /**
                    Switches are great but  I could not get them to work so  I used an if else chain instead...
            */
            
            
            /*switch classCounter {
            case 1://Course 1
                LCrs1.text = crsTitle.text! + " GPA " + String(format: "%.2f",gpa)
                return;
            case 2: //Course 2
                LCrs2.text = crsTitle.text! + " GPA " + String(format: "%.2f",gpa)
                return;
            case 3: //Course 3
                LCrs3.text = crsTitle.text! + " GPA " + String(format: "%.2f",gpa)
                return;
            case 4: //Course 4
                LCrs4.text = crsTitle.text! + " GPA " + String(format: "%.2f",gpa)
                return;
                
            default:
                print("Debug: --> Only for courses! No other options...")
            }// end switch*/
            
            
        } // end if else chain
    
    }
    
    //Delete Course
    @IBAction func delCrs(sender: UIButton) {
        
        //print("Delete Test") --> Test was successfull
        
        //output gpa result to UI in order of class counter: 1 --> the first course added
        //                                                   2 --> second courses added
        //                                                   3 --> third courses added
        //                                                   4 --> fourth courses added
        //                                                    courses will be deleted in the order the were added by the course count: if the current count is 2 then course two will be deleted
        //max 4 course as per instructions so cases stop at 4
        
        //output error to user: cannout delete a coutse if it does not exist
        if(classCounter==0){
            let alertTitle = "Alert"
            let alertMessage = "Cannot Delete Courses! No Courses to delete!"
            let alertOkButtonText = "Ok"
            
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            //We add buttons to the alert controller by creating UIAlertActions:
            let actionOk = UIAlertAction(title: alertOkButtonText,
                                         style: .Default,
                                         handler: nil) //You can use a block here to handle a press on this button
            
            alertController.addAction(actionOk)
            presentViewController(alertController, animated: true, completion:nil)

            //reset the counter to zero to veriffy the the next increment in the chain starts from zero
            //classCounter=0;
            //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
            return;

        } else {
            //decrement the number of total courses as one is about to be deleted
            
            //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
        //if class count is between 1 & 3 then select the course to be deleted, and reset its label to blank
        
            if(classCounter==1){
                LCrs1.text = "";
                classCounter-=1
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                
                return;
            } else if(classCounter==2){
                LCrs2.text = "";
                classCounter-=1
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                
                    return;
            } else if(classCounter==3){
                LCrs3.text = "";
                classCounter-=1
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                
                return;
            } else if (classCounter==4){
                LCrs4.text = "";
                classCounter-=1
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                
                return;
            } else {
                //do nothing--no such case
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                return;
            } //end if else chain
            
            
            
            
            /**
             Switches are great but  I could not get them to work so  I used an if else chain instead...
             */

            
            
            /*switch classCounter {
        case 1://Course 1
            LCrs1.text = "";
            print("Debug");
            return;
        case 2: //Course 2
            LCrs2.text = "";
            return;
        case 3: //Course 3
            LCrs3.text = "";
            return;
        case 4: //Course 4
            LCrs4.text = "";
            return;
            
        default:
            print("Debug: -->Only for courses! No other options...")
            classCounterDbg.text = "Debug: switch " + String(format: "%d",classCounter)
        }*/// end switch
        }//end if else chain

        
    
    }
    
    //checks for valid input: Validity Defintion: Value must not be blank;
    func checkInput() -> Bool{
        if(crsTitle.text==""){
            return false;
        } else if(assTypePts.text==""){
            return false;
        } else if(assTypeMax.text==""){
            return false;
        } else if(assTypeWeight.text==""){
            return false;
        } else if(midTermPts.text==""){
            return false;
        } else if(midTermMax.text==""){
            return false;
        } else if(midTermWeight.text==""){
            return false;
        } else if(finalPts.text==""){
            return false;
        } else if(finalMax.text==""){
            return false;
        } else if(finalPrc.text==""){
            return false;
        }; return true;
        
    }
    
    
    //calculates GPA
    func calcGPA() -> Float{
        
        
        /**
            All UI and testing functionality seem to be good and holds stable (working)
            All that is left to do is correctly impliment the corrct logic for for gpa calculation:
            currently any valid numbers and mathical operatins work....but it may not make sence for a gpa to be 198.45....
         
            ---> correct gpa logic and 
            ---> after that the only thing left to do is include aesthetics...picture and correct colors...etc
 
        */
        
        
        
        
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
    
    
    
    @IBAction func showAlert(sender: UIButton) {
        
        let alertTitle = "Alert"
        let alertMessage = "Debug: Testing Alert Functionality!"
        let alertOkButtonText = "Ok"
        
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: alertOkButtonText,
                                     style: .Default,
                                     handler: nil) //You can use a block here to handle a press on this button
        
        alertController.addAction(actionOk)
        presentViewController(alertController, animated: true, completion:nil)

    }
    
    //handles the case that the keyboard is in number pad mode, as the soultion
    //standard keyboard only works if the "return" button is visible on the keypad...which is not
    // on the numeric keypad

    //function that furher aids in the above commnent and extends from the code in the "viewDidLoad" method
    func didTapView(){
        self.view.endEditing(true)
    }
    
    
    


}

