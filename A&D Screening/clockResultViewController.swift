//
//  clockResultViewController.swift
//  A&D Screening
//
//  Created by Andrew Stallone on 10/18/16.
//  Copyright © 2016 Cyndi Perez. All rights reserved.
//

import UIKit

var clockDrawPassed:Bool?

class clockResultViewController: UIViewController {

    @IBOutlet var miniCogClockResult: UIImageView!
    
    @IBOutlet var scoreForClock: UISegmentedControl!
    
    @IBAction func scoreForClockChanged(_ sender: AnyObject) {
        switch scoreForClock.selectedSegmentIndex{
        case 0:
            clockDrawPassed = true
            print("passed")
            break
        case 1:
            print("failed")
            clockDrawPassed = false
            break
        default:
            break
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("ClockDrawing.png").path
        let image = UIImage(contentsOfFile: fileURL)
        
        
        
        miniCogClockResult.image = image
        if clockDrawPassed == true {
            scoreForClock.selectedSegmentIndex = 0
        }else if clockDrawPassed == false{
            scoreForClock.selectedSegmentIndex = 1
        }else{
            
        }
        clockDrawPassed = true


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
