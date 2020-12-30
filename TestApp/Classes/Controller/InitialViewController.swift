//
//  InitialViewController.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //MARK:- Add Fade transitions between view controllers
        let transition: CATransition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController!.view.layer.add(transition, forKey: nil)

        let vc = self.storyboard?.instantiateViewController(withIdentifier: VCIdentifier.vC.rawValue) as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
