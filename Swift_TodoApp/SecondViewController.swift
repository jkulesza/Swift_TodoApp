//
//  SecondViewController.swift
//  Swift_TodoApp
//
//  Created by Joel A. Kulesza on 12/30/16.
//  Copyright © 2016 Joel A. Kulesza. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

  @IBOutlet weak var input: UITextField!
  @IBOutlet weak var urgency: UITextField!

  @IBAction func addItem(_ sender: Any) {
    if(input.text != ""
      && urgency.text != ""
      && Int(urgency.text!) != nil) {
      if(Int(urgency.text!)! < 1) {urgency.text = "1"}
        if(Int(urgency.text!)! > 100) {urgency.text = "100"}
      data.append( item(title: input.text!, urgency: Int(urgency.text!)!) )
      input.text = ""
      urgency.text = ""
      dismissKeyboard()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SecondViewController.dismissKeyboard)))
    
  }
  
  func dismissKeyboard() {
    input.resignFirstResponder()
    urgency.resignFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

