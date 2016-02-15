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
    
    //Course Color Labels:
    @IBOutlet weak var crs1color: UILabel!
    @IBOutlet weak var crs2color: UILabel!
    @IBOutlet weak var crs3color: UILabel!
    @IBOutlet weak var crs4color: UILabel!
    
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
        //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter) --> if ever needs to be debugged again: uncomment 
                                                                                        // reference classCounterDbg.text = <varName> where ever
                                                                                        // in the code needed for debugging purposes
        
        //sets the classCounterDbg label to empty to take it off the screen when not needed for debugging:
        //I could simply delete are the reference in the code but if the error has to be debugged again in the future then the implimentation is 
        //already there, so I it easier to simply set it to invisible by assigned it to the null string "". Besides: this is easier on my end:
        // dont want to go through the code and delete all the refeerences anyway haha ;P
        classCounterDbg.text="";
        
        //sets all of the course labels to null on load as to prevent from appearing as a blank label on start. as coarses are added, the labels will be updated occordingly in the code below
        LCrs1.text = "";
        LCrs2.text = "";
        LCrs3.text = "";
        LCrs4.text = "";
        
        //Ensures that the course color label does not display unless add and removal will be handled with the delete course method
        crs1color.text = ""
        crs2color.text = ""
        crs3color.text = ""
        crs4color.text = ""
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Buttons:: add and deletecourse
    //Button Add Course
    @IBAction func addCrs(sender: UIButton) {
        //print("Add Test") --> Test was successfull
        
        //variable to hold the currentyl calculated courseCrade
        var grade: Float;
        
        
       
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
            
        } else if (checkMaxVals()==false){ // --> checks all max values from the input
            //Alert to user that there input was invalid and to re check their input
            let alertTitle = "Alert"
            let alertMessage = "Max values muxt between 0 and 100! Please check you max numbers!"
            let alertOkButtonText = "Ok"
            
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            //We add buttons to the alert controller by creating UIAlertActions:
            let actionOk = UIAlertAction(title: alertOkButtonText,
                                         style: .Default,
                                         handler: nil) //You can use a block here to handle a press on this button
            
            alertController.addAction(actionOk)
            presentViewController(alertController, animated: true, completion:nil)
            return;

        } else if(checkWeights()==false){ //--> check to ensure that the sum of the percentages = to 100
            let alertTitle = "Alert"
            let alertMessage = "Course percentage numbers must sum to 100! Please check your percentage numbers!"
            let alertOkButtonText = "Ok"
            
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            //We add buttons to the alert controller by creating UIAlertActions:
            let actionOk = UIAlertAction(title: alertOkButtonText,
                                         style: .Default,
                                         handler: nil) //You can use a block here to handle a press on this button
            
            alertController.addAction(actionOk)
            presentViewController(alertController, animated: true, completion:nil)
            return;

            
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
            grade = calcGPA();
            
            //output gpa result to UI in order of class counter: 1 --> the first course added
            //                                                   2 --> second courses added
             //                                                  3 --> third courses added
            //                                                   4 --> fourth courses added
            //                                                    courses will be deleted in the order the were added by the course count: if the current count is 2 then course two will be deleted
            //max 4 course as per instructions so cases stop at 4
            
            
            var color: String;
            var letter: String;
            var LGrade: String;
            if(grade >= 90){
                    color = "green";
                    letter = "A";
                
                //ensures the right color goes to the right label
                if(classCounter==1){
                    crs1color.text =  letter;
                    crs1color.textColor = UIColor.greenColor();
                } else if(classCounter==2){
                    crs2color.text = letter;
                    crs2color.textColor = UIColor.greenColor();
                } else if(classCounter==3){
                    crs3color.text = letter;
                    crs3color.textColor = UIColor.greenColor();
                } else {
                    crs4color.text = letter;
                    crs4color.textColor = UIColor.greenColor();  }
                
            } else if( grade <= 89.9 || grade >= 80 ){
                    color = "orange";
                    letter = "B";
                //ensures the right color goes to the right label
                if(classCounter==1){
                    crs1color.text = letter;
                    crs1color.textColor = UIColor.orangeColor();
                } else if(classCounter==2){
                    crs2color.text = letter;
                    crs2color.textColor = UIColor.orangeColor();
                } else if(classCounter==3){
                    crs3color.text = letter;
                    crs3color.textColor = UIColor.orangeColor();
                } else {
                    crs4color.text = letter;
                    crs4color.textColor = UIColor.orangeColor();  }
            } else if( grade <= 79.9 || grade >= 70 ){
                    color = "orange";
                    letter = "C";
                //ensures the right color goes to the right label
                if(classCounter==1){
                    crs1color.text = letter;
                    crs1color.textColor = UIColor.orangeColor();
                } else if(classCounter==2){
                    crs2color.text = letter;
                    crs2color.textColor = UIColor.orangeColor();
                } else if(classCounter==3){
                    crs3color.text = letter;
                    crs3color.textColor = UIColor.orangeColor();
                } else {
                    crs4color.text = letter;
                    crs4color.textColor = UIColor.orangeColor();  }
            } else if( grade <= 69.9 || grade >= 60 ){
                    color = "organge";
                    letter = "D";
                //ensures the right color goes to the right label
                if(classCounter==1){
                    crs1color.text = letter;
                    crs1color.textColor = UIColor.orangeColor();
                } else if(classCounter==2){
                    crs2color.text = letter;
                    crs2color.textColor = UIColor.orangeColor();
                } else if(classCounter==3){
                    crs3color.text = letter;
                    crs3color.textColor = UIColor.orangeColor();
                } else {
                    crs4color.text = letter;
                    crs4color.textColor = UIColor.orangeColor();  }
            } else {
                color = "red";
                letter = "F";
                //ensures the right color goes to the right label
                if(classCounter==1){
                    crs1color.text = letter;
                    crs1color.textColor = UIColor.orangeColor();
                } else if(classCounter==2){
                    crs2color.text = letter;
                    crs2color.textColor = UIColor.orangeColor();
                } else if(classCounter==3){
                    crs3color.text = letter;
                    crs3color.textColor = UIColor.orangeColor();
                } else {
                    crs4color.text = letter;
                    crs4color.textColor = UIColor.orangeColor();  }
            }
            
            if(classCounter==1){
                LCrs1.text = crsTitle.text! + " " + String(format: "%.2f",grade)
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                return;
            } else if(classCounter==2){
                LCrs2.text = crsTitle.text! + " " + String(format: "%.2f",grade)
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                return;
            } else if(classCounter==3){
                LCrs3.text = crsTitle.text! + " " + String(format: "%.2f",grade)
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                return;
            } else {
                LCrs4.text = crsTitle.text! + " " + String(format: "%.2f",grade)
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
                crs1color.text = ""
                classCounter-=1
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                
                return;
            } else if(classCounter==2){
                LCrs2.text = "";
                crs2color.text = ""
                classCounter-=1
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                
                    return;
            } else if(classCounter==3){
                LCrs3.text = "";
                crs3color.text = ""
                classCounter-=1
                //classCounterDbg.text = "Class Counter: " + String(format: "%d",classCounter)
                print("Debug " + String(format: "%d",classCounter));
                
                return;
            } else if (classCounter==4){
                LCrs4.text = "";
                crs4color.text = ""
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
        var assSum, midTerm, final, assWeight, midTerm_WeightF, finalWeight,courseGrade: Float;
        
        
        /**
            1: Assignement Calculation
         
        */
        //calculates the assignment grade
        assSum = ((assTypePts.text! as NSString).floatValue / (assTypeMax.text! as NSString).floatValue)
        
        //calculates the assigment total with  the weight of the assignment
        assWeight=assSum * (assTypeWeight.text! as NSString).floatValue;
        
        
        /**
         2: MidTerm Calculation
         
         */

        
        //calculates the mid term grade
        midTerm = ((midTermPts.text! as NSString).floatValue / (midTermMax.text! as NSString).floatValue)
        //calculates the mide term total with  the weight of the total
        midTerm_WeightF=midTerm * (midTermWeight.text! as NSString).floatValue;
        
        
        /**
         3: Final Calculation
         
         */

        
        //calculats the final grade
        final = ((finalPts.text! as NSString).floatValue / (finalMax.text! as NSString).floatValue)
         //calculates the final total with  the weight of the final
        finalWeight = final * (finalPrc.text! as NSString).floatValue;

        
        
        //calculate the total course average as the sum of the above calculations:
        // more specifically:
        
        //     courseGrade =
        //                  assWeight +
        //                  midTermWeightF +
        //                  finalWeight +
        //
        courseGrade = assWeight + midTerm_WeightF + finalWeight;
        
        return courseGrade;
        
    }
    
    //testing rid the keyboard when the return key is pressed
    func textFieldShouldReturn(TextField: UITextField) -> Bool {
        
        TextField.resignFirstResponder();
                return true
    }
    
    
    //function used as a test to ensure that the alertcontroller was function correctly withoutt the addition of the add and delete course code
    //was simply to test a plain vanila UIAlerController and make sure it was functioning properly
    
    //currently not visible: color is set to white to match the background color to give the illusion of invisible.
    //to use for debguging simply go to the setting and change the color from:
    // "white" to "blue" or whatever color you wish....
    //invisible color apt to change as color to accomplish this goal is subject to the
    //current background color. If the background color is changed, then the color of the button will have to be update occordinly to keep it invisibility
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
    
    //checks and validate user input numebrs for weights
    func checkWeights() -> Bool{
        
        //varibale for the temp weight calculation
        var assW, midTermW, finalW: Float;
        
        //grabs the actual numeric value from the text field--> parses the textField
        assW = (assTypeWeight.text! as NSString).floatValue;
        midTermW = (midTermWeight.text! as NSString).floatValue;
        finalW = (finalPrc.text! as NSString).floatValue;
        
        if((assW + midTermW + finalW) != 100){
            return false; // sum of the wieghts CANNOT equal ANYTHING but 100
        }
        else { return true; } //sum of weights == 100
    }
    
    //checks and validate user input numebrs for max types
    func checkMaxVals() -> Bool{
        
        var assM, midTermM, finalM: Float;
        
        //grabs the actual numeric value from the text field--> parses the textField
        assM = (assTypeMax.text! as NSString).floatValue;
        midTermM = (midTermMax.text! as NSString).floatValue;
        finalM = (finalMax.text! as NSString).floatValue;
        
        if(assM > 100 || assM < 1){
        return false; //max for field must be between 0 and 100
        } else if (midTermM > 100 || midTermM < 1){
        return false; //max for field must be between 0 and 100
        } else if (finalM > 100 || finalM < 1){
        return false; //max for field must be between 0 and 100
        }
        else { return true; } //all fields have correct ranges

        
    }
    
    
    


}

