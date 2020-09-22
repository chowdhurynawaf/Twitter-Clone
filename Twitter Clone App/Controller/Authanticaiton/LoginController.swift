//
//  LoginController.swift
//  Twitter Clone App
//
//  Created by as on 9/18/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit
import Firebase


class LoginController : UIViewController {
    
    
    //MARK: - Properties

    private let logoImageView : UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
        
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
    
    private let loginButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    
    }()
    
    private let dontHaveAnyAccountBtn : UIButton = {
        let btn = Utilities().attributedButton("Dont have any account yet? ", "Sign Up")
        btn.addTarget(self, action: #selector(handleDontHaveAnyAccountBtn), for: .touchUpInside)
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
    

    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    
    
    //MARK: - Selectors
    
    
    @objc func handleLogin() {
        guard let email    = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (red, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: { ($0.isKeyWindow)}) else {return}
            guard let tab  = window.rootViewController as? MainTabBarController else {return}
            
            tab.authinticateAndCOnfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleDontHaveAnyAccountBtn() {
        //present(RegistrationController(), animated: true)
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    //MARK: - Helpers
    
    
    func configUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        logoImageView.setDimensions(width: 150, height: 150)
        
        
        let stack = UIStackView(arrangedSubviews: [
            emailContainterView,
            passwordContainterView,
            loginButton
        ])
        view.addSubview(stack)

        stack.anchor(top:logoImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor , paddingLeft: 16,paddingRight: 16)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        
        view.addSubview(dontHaveAnyAccountBtn)
        
        dontHaveAnyAccountBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
    
    }
}

