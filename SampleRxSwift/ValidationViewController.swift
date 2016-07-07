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

let minimumUsernameLength = 5
let minimumPasswordLength = 5

class ValidationViewController: UIViewController {
    
    @IBOutlet var userenameTextField: UITextField!
    @IBOutlet var usernameValidLabel: UILabel!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordValidLabel: UILabel!
    
    @IBOutlet var doSomethinfButton: UIButton!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameValidLabel.text = "username has to be at least \(minimumUsernameLength) characters"
        passwordValidLabel.text = "password has to be at least \(minimumPasswordLength) characters"
        
        let usernameValid = userenameTextField.rx_text.map({ $0.characters.count > minimumUsernameLength}).shareReplay(1)
        
        let passwordValid = passwordTextField.rx_text.map { $0.characters.count > minimumPasswordLength}.shareReplay(1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1}.shareReplay(1)
        
        usernameValid.bindTo(passwordTextField.rx_enabled).addDisposableTo(disposeBag)
        
        usernameValid.bindTo(usernameValidLabel.rx_hidden).addDisposableTo(disposeBag)
        passwordValid.bindTo(passwordValidLabel.rx_hidden).addDisposableTo(disposeBag)
        
        everythingValid.bindTo(doSomethinfButton.rx_enabled).addDisposableTo(disposeBag)
        
        doSomethinfButton.rx_tap.subscribeNext { [weak self] in
            self?.showAlert()
        }.addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
}
