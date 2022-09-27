//
//  ViewController.swift
//  RealmTest
//
//  Created by Diana on 26.09.2022.
//

import UIKit
import RealmSwift
import SnapKit

class ViewController: UIViewController {
    
    let realm = try! Realm()
    
    let nameTextField: UITextField = UITextField()
    let ageTextField: UITextField = UITextField()
    let interestsTextField: UITextField = UITextField()
    let button: UIButton = UIButton()
    
    let cornerRadius:CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        
        configureUI()
    }
    
    func configureUI() {
        let verticalStack = UIStackView(arrangedSubviews: [nameTextField, ageTextField, interestsTextField, button])
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.alignment = .center
        
        verticalStack.spacing = 10
        view.addSubview(verticalStack)
        
        setupTextField(textField: nameTextField, placeholder: "Name")
        setupTextField(textField: ageTextField, placeholder: "Age")
        ageTextField.keyboardType = .numberPad
        setupTextField(textField: interestsTextField, placeholder: "Interests")
        
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = cornerRadius
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        
        nameTextField.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width / 2)
        }
        ageTextField.snp.makeConstraints { make in
            make.width.equalTo(nameTextField)
        }
        
        interestsTextField.snp.makeConstraints { make in
            make.width.equalTo(nameTextField)
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(nameTextField)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func saveButtonAction() {
        realm.beginWrite()
        
        let person = Person()
        guard let nameText = nameTextField.text, let ageText = ageTextField.text, let interestsText = interestsTextField.text else {
            print("Empty textfield")
            return
        }
        person.name = nameText
        person.age = Int(ageText) ?? 24
        person.interests = interestsText
        
        realm.add(person)
        try! realm.commitWrite()
        
        fetch()
    }
    
    func fetch() {
        let results = realm.objects(Person.self)
        for result in results {
            let name = result.name
            let age = result.age
            let interests = result.interests
            
            print(name, age, interests)
        }
    }
    
    func setupTextField(textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.layer.cornerRadius = cornerRadius
        textField.backgroundColor = .secondarySystemGroupedBackground
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
    }
}

