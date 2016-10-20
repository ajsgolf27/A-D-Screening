//
//  initialResultsViewController.swift
//  A&D Screening
//
//  Created by Andrew Stallone on 10/17/16.
//  Copyright © 2016 Cyndi Perez. All rights reserved.
//

import UIKit



class initialResultsViewController: UIViewController {

    @IBOutlet var wordRecallLabel: UILabel!
    @IBOutlet var clockDrawLabel: UILabel!
    @IBOutlet var testResult: UILabel!
    
    var numberOfRecalledPoints = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordRecallLabel.text! = checkAnswers()
        if clockDrawPassed == true {
            clockDrawLabel.text! = "Clock Drawing Passed"
        }else if clockDrawPassed == false{
            clockDrawLabel.text! = "Clock Drawing Failed"
        }else{
            clockDrawLabel.text! = "Clock Drawing Not Graded"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if clockDrawPassed == true {
            clockDrawLabel.text! = "Clock Drawing Passed"
        }else if clockDrawPassed == false{
            clockDrawLabel.text! = "Clock Drawing Failed"
        }else{
            clockDrawLabel.text! = "Clock Drawing Not Graded"
        }
        
        testResult.text! = giveFinalResult()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAnswers() -> String{
        print(userAnswers)
//        if userAnswers.contains("banana") && userAnswers.contains("sunrise") && userAnswers.contains("chair"){
//            numberOfRecalledPoints = 3;
//            return "word recall 3 points"
        
//        }
        numberOfRecalledPoints = 0;
        if userAnswers.contains("banana"){
            numberOfRecalledPoints += 1
        }
        if userAnswers.contains("sunrise"){
            numberOfRecalledPoints += 1
        }
        if userAnswers.contains("chair"){
            numberOfRecalledPoints += 1
        }
        if numberOfRecalledPoints == 1{
            return "word recall 1 point"
        }else if numberOfRecalledPoints == 2{
            return "word recall 2 points"
        }else if numberOfRecalledPoints == 3{
            return "word recall 3 points"
        }
        return "word recall 0 points"
    }
    
    func giveFinalResult()-> String{
        if numberOfRecalledPoints < 3 && clockDrawPassed == false{
            return "Test Failed"
        }else if numberOfRecalledPoints == 3{
            return "Test Passed"
        }else if numberOfRecalledPoints < 3 && numberOfRecalledPoints > 1 && clockDrawPassed == true{
            return "Test Passed"
        }else if numberOfRecalledPoints == 0{
            return "Test Failed"
        }else{
            return "not determined"
        }

    }
    
    
}
