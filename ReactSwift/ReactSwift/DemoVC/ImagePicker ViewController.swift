//
//  ImagePicker ViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/24.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImagePicker_ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var galleryButton: UIButton!
    
       @IBOutlet weak var cropButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cameraButton.rx.tap.asObservable()
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .camera
                    picker.allowsEditing = false
                    }
                    .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                    .take(1)
            }.map { info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        
    }

 

}
