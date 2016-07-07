//
//  ValidationViewController.swift
//  SampleRxSwift
//
//  Created by ShinokiRyosei on 2016/07/07.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ValidationViewController: UIViewController {
    
    @IBOutlet var usrenameTextField: UITextField!
    @IBOutlet var usernameValidLabel: UILabel!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordValidLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
