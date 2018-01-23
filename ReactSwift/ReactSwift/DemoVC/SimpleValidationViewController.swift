//
//  SimpleValidationViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/23.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


let minimalUsernameLength = 5
let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!
    
    @IBOutlet weak var goButton: UIButton!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userNameValid = usernameOutlet.rx
            .text.orEmpty
            .map { (text) -> Bool in
                text.count >= minimalUsernameLength
            }.share(replay: 1, scope: .whileConnected)
        //shareReplay 就是让他们共享这一个源
        
        userNameValid.bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        userNameValid.bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        // 密码是否有效
        let passwordValid = passwordOutlet.rx.text.orEmpty
            // 密码 -> 密码是否有效
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
            
            // 密码是否有效 -> 密码提示语是否隐藏
            passwordValid
                .bind(to: passwordValidOutlet.rx.isHidden)
                .disposed(by: disposeBag)
        
        
        
        let buttonValid = Observable.combineLatest(userNameValid,passwordValid) {
            $0 && $1
        }.share(replay: 1)
        
        buttonValid.bind(to: goButton.rx.isEnabled)
        .disposed(by: disposeBag)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
