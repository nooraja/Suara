//
//  LoginController.swift
//  Suara
//
//  Created by Muhammad Noor on 16/07/21.
//

import UIKit

class LoginController: UIViewController {
	
	let mainView: LoginView!
	
	required init(mainView: LoginView, dataSource: LoginViewModel) {
		self.mainView = mainView
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func loadView() {
		super.loadView()
		view = mainView
	}
		
}
