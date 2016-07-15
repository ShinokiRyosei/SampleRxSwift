//
//  GeolocationViewController.swift
//  SampleRxSwift
//
//  Created by ShinokiRyosei on 2016/07/15.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import CoreLocation

private extension UILabel {
    var rx_driveCoordinates: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: self) { label, location in
            label.text = "Lat: \(location.latitude)\n Lon: \(location.longtitude)"
        }.asObserver()
    }
}

private extension UIView {
    var rx_driveAuthorization: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: self) { view , authorized in
            if authorized  {
                view.hidden = true
                view.subview?.sendSubViewToBack(view)
            }else {
                view.hidden = false
                view.subview?.bringSubviewToFront(view)
            }
        }.asObserver()
    }
}

class GeolocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
