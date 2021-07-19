//
//  LoginView.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import UIKit
import GoogleSignIn
import FacebookLogin

protocol LoginViewDelegate where Self: UIViewController {
	
	func whenLoginClicked()
	func whenForgetClicked()
	func whenRegisterClicked()
	func onUserChange()
	func onPasswordChange()
}


class LoginView: UIView {
	
	weak var delegate: LoginViewDelegate?
	
	lazy var titleLoginLabel: UILabel = {
		let label = UILabel(text: "", textColor: .white, textAlignment: .left, numberOfLines: 1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var usernameTextField: IndentedTextField = {
		let textField :IndentedTextField = IndentedTextField(placeholder: "Username", padding: 12, cornerRadius: 5, keyboardType: .emailAddress, backgroundColor: UIColor.white, isSecureTextEntry: false, borderWidth: 1, borderColor: .gray)
		textField.autocapitalizationType = .none
		textField.textColor = .black
		textField.font = .Roboto(.medium, size: 12)
		textField.addTarget(self, action: #selector(self.onUserChange), for: .editingChanged)
		return textField
	}()
	
	lazy var passwordTextField: IndentedTextField = {
		let textField :IndentedTextField = IndentedTextField(placeholder: "Password", padding: 12, cornerRadius: 5, keyboardType: .emailAddress, backgroundColor: UIColor.white, isSecureTextEntry: true ,borderWidth: 1, borderColor: .gray)
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.autocapitalizationType = .none
		textField.textColor = .black
		textField.font = .Roboto(.medium, size: 12)
		textField.addTarget(self, action: #selector(self.onPasswordChange), for: .editingChanged)
		return textField
	}()
	
	lazy var userInputLoginView: UIView = {
		let view: UIView = UIView()
		view.frame = CGRect(x: 100, y: 100, width: 296, height: 320)
		view.backgroundColor = .white
		view.layer.cornerRadius = 16
		
		return view
	}()
	
	lazy var loginButton : UIButton = {
		let button = UIButton()
		button.titleLabel?.font = .Roboto(.bold, size: 14)
		button.setTitle("Signin", for: .normal)
		button.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside)
		return button
	}()
	
	lazy var iconGoogleButton : UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .blue
		button.titleLabel?.font = .Roboto(.medium, size: 12)
		button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
		button.setTitleColor(.white, for: .normal)
		button.setTitle("Sign in with Google", for: .normal)
		button.setImage(UIImage(systemName: "command"), for: .normal)
		button.imageEdgeInsets.right = 30
		return button
	}()
	
	lazy var iconFacebookButton : UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .blue
		button.titleLabel?.font = .Roboto(.medium, size: 12)
		button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
		button.setTitleColor(.white, for: .normal)
		button.setTitle("Sign in with Facebook", for: .normal)
		button.setImage(UIImage(systemName: "command"), for: .normal)
		button.imageEdgeInsets.right = 30
		return button
	}()
	
	override func draw(_ rect: CGRect) {
		
		let isFrameEnough = self.frame.height > 590
		
		let marginTop: CGFloat = isFrameEnough ? 32: 16
		
		let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.spacing = 16
		
		let registerView = UIView()
		
		self.addSubview(titleLoginLabel)
		self.addSubview(userInputLoginView)
		self.addSubview(iconGoogleButton)
		self.addSubview(iconFacebookButton)
		
		userInputLoginView.addSubview(stackView)
		userInputLoginView.addSubview(loginButton)
		userInputLoginView.addSubview(registerView)
		
		titleLoginLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, paddingTop: marginTop, paddingLeft: 32)
		
		userInputLoginView.anchor(top: titleLoginLabel.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: marginTop, paddingLeft: 32,paddingRight: 32)
		
		stackView.anchor(top: userInputLoginView.topAnchor, left: userInputLoginView.leftAnchor, right: userInputLoginView.rightAnchor, paddingTop: 24, paddingLeft: 23, paddingRight: 23)
		
		loginButton.anchor(top: stackView.bottomAnchor, left: userInputLoginView.leftAnchor, right: userInputLoginView.rightAnchor, paddingTop: 24, paddingLeft: 23, paddingRight: 23, height: 48)
		
		registerView.centerXAnchor.constraint(lessThanOrEqualTo: userInputLoginView.centerXAnchor).isActive = true
		registerView.anchor(top: loginButton.bottomAnchor, left: nil, bottom: userInputLoginView.bottomAnchor, right: nil, paddingTop: 32, paddingLeft: 0, paddingBottom: 24, paddingRight: 0)
		
		iconGoogleButton.anchor(top: nil, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingRight: 32, width: nil, height: 48)
		
		iconFacebookButton.anchor(top: iconGoogleButton.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingRight: 32, width: nil, height: 48)
	}
	
	@objc func handleLogin() {
		delegate?.whenLoginClicked()
	}
	
	@objc private func handleForget() {
		delegate?.whenForgetClicked()
	}
	
	@objc private func onUserChange() {
		delegate?.onUserChange()
	}
	
	@objc private func onPasswordChange() {
		delegate?.onPasswordChange()
	}
	
	@objc private func handleRegister() {
		delegate?.whenRegisterClicked()
	}
}
