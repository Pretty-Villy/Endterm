//
//  ColorViewController.swift
//  toDoList2
//
//  Created by Darkhan Zhapparov on 11.12.2020.
//

import UIKit

protocol Colors {
    func setBackgroundColor() -> UIColor
    func makeNavBarHidden()
    func printCurrentVCName()
}
protocol Change {
    func changeColor(color: UIColor)
}

class ColorViewController: UIViewController, Colors {
    func setBackgroundColor() -> UIColor {
        return .white
    }
    
    func makeNavBarHidden() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func printCurrentVCName() {
        print("Parent View Controller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printCurrentVCName()
        self.view.backgroundColor = self.setBackgroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}

class ColorPage: ColorViewController{
    var changeColor: Change?
    
    
    @IBAction func changeColor(_ sender: Any) {
        changeColor?.changeColor(color: .systemGray)
    }
}
