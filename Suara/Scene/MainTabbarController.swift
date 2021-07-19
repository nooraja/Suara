//
//  MainTabbarController.swift
//  Suara
//
//  Created by Muhammad Noor on 17/07/21.
//

import UIKit

class MainTabbarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabBar.barTintColor = .systemBackground
		tabBar.tintColor = .systemBlue
		tabBar.unselectedItemTintColor = .systemGray
		tabBar.isTranslucent = false
		
		let homeController = createTabBarItem(tabBarTitle: "Home", tabBarImage: "house", selectedImage: "house.fill", viewController: HomeController(mainView: HomeView(), viewModel: HomeViewModel(networkModel: HomeNetworkModel())))
		
		let favoriteController = createTabBarItem(tabBarTitle: "Favorite", tabBarImage: "heart", selectedImage: "heart.fill", viewController: FavoriteController(viewModel: FavoriteViewModel()))
		
		viewControllers = [homeController, favoriteController]
	}
	
	func createTabBarItem(tabBarTitle: String, tabBarImage: String, selectedImage : String, viewController: UIViewController) -> UINavigationController {
		let navCont = UINavigationController(rootViewController: viewController)
		navCont.tabBarItem.title = tabBarTitle
		navCont.tabBarItem.image = UIImage(systemName: tabBarImage)
		navCont.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
		
		// Nav Bar Customisation
		navCont.navigationBar.barTintColor = .systemBackground
		navCont.navigationBar.tintColor = .systemBlue
		navCont.navigationBar.isTranslucent = false
		return navCont
	}
}
