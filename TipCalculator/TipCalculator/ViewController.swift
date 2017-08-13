//
//  ViewController.swift
//  TipCalculator
//
//  Created by Lula Villalobos on 8/8/17.
//  Copyright © 2017 Lula Villalobos. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var tipPicker: UIPickerView!
    @IBOutlet weak var splitPicker: UIPickerView!
    @IBOutlet weak var tipLabel: UILabel!
    
    let tipPickerData = ["18%", "20%", "25%"]
    let splitPickerData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var currentSplit = 1
    let tipPercentages = [0.18, 0.2, 0.25]
    var currentTip = 0.18
    var billOnScreen:Double = 0
    var billOnScreenStr = ""
    var pointIndex:Int = -1
    
    //Views
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var splitView: UIView!
    @IBOutlet weak var totalView: UIView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipPicker.dataSource = self
        tipPicker.delegate = self
        splitPicker.dataSource = self
        splitPicker.delegate = self

        //NavigationController invisible
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        updateTotal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Change Theme
        let defaultColor = defaults.integer(forKey: "color_theme_default")
        var totalColor: UIColor
        var pickerColor: UIColor
        switch defaultColor {
        case 0:
            totalColor = UIColorFromHex(rgbValue: 0xef5656, alpha: 1)
            pickerColor = UIColorFromHex(rgbValue: 0xe63c3e, alpha: 1)
            break
        case 1:
            totalColor = UIColorFromHex(rgbValue: 0x5852f0, alpha: 1)
            pickerColor = UIColorFromHex(rgbValue: 0x5fd65b, alpha: 1)
            break
        case 2:
            totalColor = UIColorFromHex(rgbValue: 0xff6e3d, alpha: 1)
            pickerColor = UIColorFromHex(rgbValue: 0xff8a5f, alpha: 1)
            break
        default:
            totalColor = UIColorFromHex(rgbValue: 0xef5656, alpha: 1)
            pickerColor = UIColorFromHex(rgbValue: 0xe63c3e, alpha: 1)
            break
        }
        totalView.backgroundColor = totalColor
        tipView.backgroundColor = pickerColor
        splitView.backgroundColor = pickerColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaultTip = defaults.integer(forKey: "tip_percentage_default")
        tipPicker.selectRow(defaultTip, inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onKeyPress(_ sender: UIButton) {
        let billtxt = billLabel.text
        
        switch sender.currentTitle! {
        case "<":
            if(billtxt! != "") {
                let index = billtxt!.index(billtxt!.startIndex, offsetBy: billtxt!.characters.count-1)
                let substring = billtxt!.substring(to: index)
                billLabel.text = substring
                if(substring != ""){
                    billOnScreen = Double(substring)!
                } else {
                    billOnScreen = 0
                }
                if(pointIndex != -1 && billtxt!.characters.count-1 == pointIndex) {
                    pointIndex = -1
                }
            }
            break
        case ".":
            if(pointIndex == -1 && billtxt! != "") {
                pointIndex = billtxt!.characters.count
                billLabel.text = billLabel.text! + sender.currentTitle!
                billOnScreen = Double(billLabel.text!)!
            }
            break
        case "C":
            billLabel.text = ""
            billOnScreen = 0
            pointIndex = -1
        default:
            billLabel.text = billLabel.text! + sender.currentTitle!
            billOnScreen = Double(billLabel.text!)!
            break
        }
        
        //Animate Key
        let currentColor = sender.backgroundColor
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            sender.backgroundColor = self.UIColorFromHex(rgbValue: 0x737373, alpha: 1)
        }) { (success:Bool) in
            if success {
                UIView.animate(withDuration: 0.1, animations: {
                    sender.backgroundColor = currentColor
                })
            }
        }
        
        updateTotal()
    }
    
    func updateTotal() {
        let tip = billOnScreen * currentTip
        let total = (billOnScreen + tip) / Double(currentSplit)
        totalLabel.text = convertToCurrency(number: total)
        tipLabel.text = convertToCurrency(number: (tip/Double(currentSplit)))
        
        
        //Animate Total
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
          self.totalLabel.center.y += 5
        }) { (success:Bool) in
            if success {
                UIView.animate(withDuration: 0.2, animations: {
                    self.totalLabel.center.y -= 5
                })
            }
        }
    }
    
    func convertToCurrency(number: Double) -> String {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            return "\(numberFormatter.string(from: NSNumber(value: number)) ?? "$0.00")"
    }
    
    
    
    //MARK: - Delegates and data source
    
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == tipPicker) {
            return tipPickerData.count
        } else {
            return splitPickerData.count
        }
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == tipPicker) {
            return tipPickerData[row]
        } else {
            return "\(splitPickerData[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == tipPicker){
            currentTip = tipPercentages[row]
        } else {
            currentSplit = splitPickerData[row]
        }
        updateTotal()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        var titleData = ""
        if(pickerView == tipPicker) {
            titleData = tipPickerData[row]
        } else {
            titleData = "\(splitPickerData[row])"
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 30.0), NSForegroundColorAttributeName:UIColor.white])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
    
    
    //MARK - Color function
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

}









