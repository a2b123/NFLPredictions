//
//  RegisterController.swift
//  NFLPredictions
//
//  Created by Amar Bhatia on 8/31/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    
    let nflButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "nfl80").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = .systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(textInputHasChanged), for: .editingChanged)
        return tf
    }()
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = .systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(textInputHasChanged), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = .systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(textInputHasChanged), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(nflButton)
        
        _ = nflButton.anchor(view.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 140, heightConstant: 140)
        nflButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInputFields()
        
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        _ = stackView.anchor(nflButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 200)
    }
    
    // MARK: ACTIONS
    
    func signUpButtonPressed() {
        guard let email = emailTextField.text, email.characters.count > 0 else {
            return }
        guard let username = userNameTextField.text, username.characters.count > 0 else {
            return }
        guard let password = passwordTextField.text, password.characters.count > 0 else {
            return }

        
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error: Error?) in
            
            if let err = error {
                print("Failed To Create User:", err)
                return
            }
            
            print("Successfully Created User:", user?.uid ?? "")
            
            guard let uid = user?.uid else { return }
            let usernameValues = ["Username" :  username]
            let values = [uid : usernameValues]
            Database.database().reference().child("Users").updateChildValues(values, withCompletionBlock: { (err, red) in
                
                if let err = err {
                    print("Failed To Save User Info To Database:", err)
                } else {
                    print("Successfully User Info to Database")
                }
            })
            
            
            let layout = UICollectionViewFlowLayout()
            let standingsController = UINavigationController(rootViewController: StandingsController(collectionViewLayout: layout))
            self.present(standingsController, animated: true, completion: nil)
        }
    }
    
    func textInputHasChanged() {
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0 && userNameTextField.text?.characters.count ?? 0 > 0 &&  passwordTextField.text?.characters.count ?? 0 > 0
        if isFormValid {
            signUpButton.isEnabled = true
            // Dark Blue Color
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 200)
        } else {
            signUpButton.isEnabled = false
            // Light Blue Color
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
}

