//
//  ImagePickerViewController.swift
//  SampleRxSwift
//
//  Created by ShinokiRyosei on 2016/07/08.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ImagePickerViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var galleryButton: UIButton!
    @IBOutlet var cropButton: UIButton!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)

        cameraButton.rx_tap.flatMapLatest { [weak self] _ in
            return UIImagePickerController.rx_createWithParent(self) { (picker) in
                picker.sourceType = .Camera
                picker.allowsEditing = false
                }.flatMap({ $0.rx_didFinishPickingMediaWithInfo
                }).take(1)
        }.map { (info) in
            return info[UIImagePickerControllerOriginalImage] as? UIImage
        }.bindTo(imageView.rx_image).addDisposableTo(disposeBag)
        
        galleryButton.rx_tap.flatMapLatest { [weak self] _ in
            return UIImagePickerController.rx_createWithParent(self) { picker in
                picker.sourceType = .PhotoLibrary
                picker.allowsEditing = false
            }.flatMap({
                $0.rx_didFinishPickingMediaWithInfo
            })}.take(1)
            .map({ info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }).bindTo(imageView.rx_image).addDisposableTo(disposeBag)
        
        cropButton.rx_tap.flatMap { [weak self] _ in
            return UIImagePickerController.rx_createWithParent(self) { picker in
                picker.sourceType = .PhotoLibrary
                picker.allowsEditing = true
                }.flatMap({ $0.rx_didFinishPickingMediaWithInfo}).take(1)
            }.map({ info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }).bindTo(imageView.rx_image).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
