//
//  RegistrationController.swift
//  Twitter Clone App
//
//  Created by as on 9/18/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import Firebase



class RegistrationController : UIViewController {
    
    
    //MARK: - Properties
    


    
 
    
    
    let imagePicker = UIImagePickerController()
    var profileImage : UIImage?
    
    private let addPhotoButton : UIButton = {
        
        let btn = UIButton(type: .system)
        btn.contentMode = .scaleAspectFit
        btn.clipsToBounds = true
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handleAddPhotoBtn), for: .touchUpInside)
        return btn
        
    }()
    
    private let emailTextField : UITextField = {
        let tf = Utilities().textFieldConfigure(placeholder: "Email")
        return tf
    }()
    
    private let passwordTextField : UITextField = {
        let tf = Utilities().textFieldConfigure(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField : UITextField = {
        let tf = Utilities().textFieldConfigure(placeholder: "Full Name")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let userNameTextField : UITextField = {
          let tf = Utilities().textFieldConfigure(placeholder: "Username")
          tf.isSecureTextEntry = true
          return tf
      }()
    
    private let signUpButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    
    }()
    
    private let alreadyHaveAnyAccountBtn : UIButton = {
        let btn = Utilities().attributedButton("Already have an account? ", "Sign in")
        btn.addTarget(self, action: #selector(handleHaveAnyAccountBtn), for: .touchUpInside)
        return btn
        
    }()
    

    
    
    private lazy var emailContainterView : UIView = {
        let view = Utilities().inputContainerView(image:#imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField:emailTextField)
        //view.backgroundColor = .red
        return view
    }()
    
    private lazy var passwordContainterView : UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
       // view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var fullNameContainterView : UIView = {
          let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField)
         // view.backgroundColor = .yellow
          return view
      }()
    
    private lazy var userNameContainterView : UIView = {
          let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: userNameTextField)
         // view.backgroundColor = .yellow
          return view
      }()

    
    //MARK: - LifeCycle
    
 override func viewDidLoad() {
     super.viewDidLoad()
     
     configUI()
 }
 
    
    //MARK: - Selectors
    
    
    @objc func handleSignUp() {
        
        print("hell")
        guard let profileImage = profileImage else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullName = fullNameTextField.text else {return}
        guard let userName = userNameTextField.text?.lowercased() else {return}
        

        let credentials = AuthCredential(email: email, password: password, fullName: fullName, userName: userName, profileImage: profileImage)
        
        AuthService.shared.registerUser(credential: credentials) { (err, ref) in
            
            
            guard let window = UIApplication.shared.windows.first(where: { ($0.isKeyWindow)}) else {return}
            guard let tab  = window.rootViewController as? MainTabBarController else {return}
            
            tab.authinticateAndCOnfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
        
        

    }
    
    @objc func handleHaveAnyAccountBtn() {
        print("je")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddPhotoBtn() {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //MARK: - Helpers
    
    
    func configUI() {
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        addPhotoButton.setDimensions(width: 150, height: 150)
        
        
        let stack = UIStackView(arrangedSubviews: [
            emailContainterView,
            passwordContainterView,
            fullNameContainterView,
            userNameContainterView,
            signUpButton
        ])
        view.addSubview(stack)

        stack.anchor(top:addPhotoButton.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor , paddingLeft: 16,paddingRight: 16)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        
        view.addSubview(alreadyHaveAnyAccountBtn)
        
        alreadyHaveAnyAccountBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
    
    }
}

extension RegistrationController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage
        
        addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        addPhotoButton.layer.cornerRadius = 150/2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.clipsToBounds = true
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        
        dismiss(animated: true, completion: nil)
        
    }
}
