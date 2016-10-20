//
//  resultsViewController.swift
//  A&D Screening
//
//  Created by Andrew Stallone on 9/8/16.
//  Copyright © 2016 Cyndi Perez. All rights reserved.
//

import UIKit

class resultsViewController: UIViewController {
    
    //MARK: variables
   
    
    
    //MARK: outlets
    @IBOutlet var angerLabel: UILabel!
    @IBOutlet var contemptLabel: UILabel!
    @IBOutlet var disgustLabel: UILabel!
    @IBOutlet var fearLabel: UILabel!
    @IBOutlet var happinessLabel: UILabel!
    @IBOutlet var neutralLabel: UILabel!
    @IBOutlet var sadnessLabel: UILabel!
    @IBOutlet var surpriseLabel: UILabel!
    @IBOutlet var dominentEmotionLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if emotionDictionary.count != 0{
        createLabels()
        findMax()
        }else{
            dominentEmotionLabel.text = "unavailible"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createLabels(){
        //var angerString: String = String(describing: emotionDictionary["anger"]!)
        angerLabel.text?.append(String(describing: emotionDictionary["anger"]!))
        contemptLabel.text?.append(String(describing: emotionDictionary["contempt"]!))
        disgustLabel.text?.append(String( describing: emotionDictionary["disgust"]!))
        fearLabel.text?.append(String( describing: emotionDictionary["fear"]!))
        happinessLabel.text?.append(String( describing: emotionDictionary["happiness"]!))
        neutralLabel.text?.append(String( describing: emotionDictionary["neutral"]!))
        sadnessLabel.text?.append(String( describing: emotionDictionary["sadness"]!))
        surpriseLabel.text?.append(String( describing: emotionDictionary["surprise"]!))
    }
    
    func createSubstring(makeSub: String)-> String{
        
        
        return makeSub
    }
    
    func findMax() {
        var emotionArray : Array = Array(emotionDictionary.values)
        var maxIndex = 0
        var maxNumber : [Float] = emotionArray[0]
        for (i, _)in emotionArray.enumerated() {
            var inital: [Float] = emotionArray[i]
            
            if (maxNumber[0] < inital[0]) {
                maxNumber.insert(inital[0], at: 0)
                maxIndex = i
            }
        }
        
        // find switch statement for index that corresponds to the emotion name
        switch(maxIndex) {
        case 0  :
            dominentEmotionLabel.text = "anger "
            
            break;
        case 1  :
            dominentEmotionLabel.text = "fear "
            
            break;
        case 2  :
            dominentEmotionLabel.text = "surprise "
            
            break;
        case 3  :
            dominentEmotionLabel.text = "contempt "
            break;
        case 4  :
            dominentEmotionLabel.text = "disgust "
            break;
        case 5  :
            dominentEmotionLabel.text = "happiness "
            break;
        case 6  :
            dominentEmotionLabel.text = "neutral "
            
            break;
        case 7  :
            dominentEmotionLabel.text = "sadness "
            
            break;
                default :
            break
           
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
