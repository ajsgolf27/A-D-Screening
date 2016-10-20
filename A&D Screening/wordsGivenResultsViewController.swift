//
//  wordsGivenResultsViewController.swift
//  A&D Screening
//
//  Created by Andrew Stallone on 10/18/16.
//  Copyright © 2016 Cyndi Perez. All rights reserved.
//

import UIKit

class wordsGivenResultsViewController: UIViewController {

    @IBOutlet var word1Label: UILabel!
    @IBOutlet var word2Label: UILabel!
    @IBOutlet var word3Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        word1Label.text! = userAnswers[0]
        word2Label.text! = userAnswers[1]
        word3Label.text! = userAnswers[2]
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
