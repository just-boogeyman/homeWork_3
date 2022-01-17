//
//  ViewController.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 09.01.2022.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    // Создание экземпляра - поле имя
    let textFieldName = UITextField().then() {
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    // Создание экземпляра - поле фамилия
    let textFieldSurName = UITextField().then() {
        $0.textAlignment = .center
        $0.textColor = .white
    }
    
    // событие при - editingDidEnd
    @objc func tappedButton() {
    // описание метода
        FullName.shared.userName = textFieldName.text
        FullName.shared.userSurName = textFieldSurName.text
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textFieldName)
        view.addSubview(textFieldSurName)
        prepareView()

    }
    
    // настройка textField
    func prepareView() {
        textFieldName.backgroundColor = UIColor.gray
        textFieldName.text = FullName.shared.userName
        textFieldName.addTarget(self, action: #selector(tappedButton), for: .editingDidEnd)
        textFieldName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        textFieldSurName.backgroundColor = UIColor.gray
        textFieldSurName.text = FullName.shared.userSurName
        textFieldSurName.addTarget(self, action: #selector(tappedButton), for: .editingDidEnd)
        textFieldSurName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
}

