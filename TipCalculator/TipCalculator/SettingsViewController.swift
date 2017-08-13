//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Lula Villalobos on 8/10/17.
//  Copyright © 2017 Lula Villalobos. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var percentageControl: UISegmentedControl!
    @IBOutlet weak var colorControl: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let percentageDefault = defaults.integer(forKey: "tip_percentage_default")
        let colorDefault = defaults.integer(forKey: "color_theme_default")
        percentageControl.selectedSegmentIndex = percentageDefault
        colorControl.selectedSegmentIndex = colorDefault
        changeColorTheme(colorDefault: colorDefault)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeDefaultTip(_ sender: Any) {
        let tipControl = sender as! UISegmentedControl
        defaults.set(tipControl.selectedSegmentIndex, forKey: "tip_percentage_default")
        defaults.synchronize()
    }

    @IBAction func changeDefaultColor(_ sender: Any) {
        let colorControl = sender as! UISegmentedControl
        defaults.set(colorControl.selectedSegmentIndex, forKey: "color_theme_default")
        defaults.synchronize()
        changeColorTheme(colorDefault: colorControl.selectedSegmentIndex)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK - Color function
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    //Change Color Theme
    func changeColorTheme(colorDefault: Int) {
        var controlColor: UIColor
        switch colorDefault {
        case 0:
            controlColor = UIColorFromHex(rgbValue: 0xef5656, alpha: 1)
            break
        case 1:
            controlColor = UIColorFromHex(rgbValue: 0x5852f0, alpha: 1)
            break
        case 2:
            controlColor = UIColorFromHex(rgbValue: 0xff6e3d, alpha: 1)
            break
        default:
            controlColor = UIColorFromHex(rgbValue: 0xef5656, alpha: 1)
            break
        }
        
        for i in 0..<3 {
            percentageControl.subviews[i].tintColor = controlColor
            colorControl.subviews[i].tintColor = controlColor
        }
    }

}
