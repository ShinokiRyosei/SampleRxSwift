//
//  ViewController.swift
//  SampleRxSwift
//
//  Created by ShinokiRyosei on 2016/07/07.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet var firstTextField: UITextField!
    
    @IBOutlet var secondTextField: UITextField!
    
    @IBOutlet var thirdTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Observable.combineLatest(firstTextField.rx_text, secondTextField.rx_text, thirdTextField.rx_text) { (textValue1, textValue2, textValue3) -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bindTo(resultLabel.rx_text).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

