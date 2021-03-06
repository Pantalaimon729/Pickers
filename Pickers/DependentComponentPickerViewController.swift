//
//  DependentComponentPickerViewController.swift
//  Pickers
//
//  Created by Chen Mingwei on 31/05/2016.
//  Copyright © 2016 Chen Mingwei. All rights reserved.
//

import UIKit

class DependentComponentPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var dependentPicker: UIPickerView!
    
    private let stateComponent = 0
    private let zipComponent = 1
    private var states: [String]!
    private var zips: [String]!
    private var stateZips: [String:[String]]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bundle = NSBundle.mainBundle()
        let plistURL = bundle.URLForResource("statedictionary", withExtension: "plist")
        
        stateZips = NSDictionary(contentsOfURL: plistURL!) as! [String : [String]]
        
        let allStates = stateZips.keys
        states = allStates.sort()
        
        let selectedState = states[0]
        zips = stateZips[selectedState]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onButtonPressed(sender: UIButton) {
        
        let state = states[dependentPicker.selectedRowInComponent(stateComponent)]
        let zip = zips[dependentPicker.selectedRowInComponent(zipComponent)]
        
        let title = "You have selected zip code \(zip)"
        let message = "\(zip) is in \(state)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // MARK:-
    // MARK: Picker Datasource methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == stateComponent) {
            return states.count
        } else {
            return zips.count
        }
    }
    
    //MARK: Picker Delegate methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == stateComponent) {
            return states[row]
        } else {
            return zips[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == stateComponent) {
            let selectedState = states[row]
            zips = stateZips[selectedState]
            dependentPicker.reloadComponent(zipComponent)
            dependentPicker.selectRow(0, inComponent: zipComponent, animated: true)
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        if component == stateComponent {
            return 2 * pickerWidth/3
        } else {
            return pickerWidth/3
        }
    }
}
