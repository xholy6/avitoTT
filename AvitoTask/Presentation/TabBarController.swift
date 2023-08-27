//
//  TabBarController.swift
//  AvitoTask
//
//  Created by D on 27.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    private enum TabBarItems {
        case catalog
        case favorites
        case ads
        case messages
        case profile


        var title: String {
            switch self {
            case .catalog:
                return "Поиск"
            case .favorites:
                return "Избранное"
            case .ads:
                return "Объявления"
            case .messages:
                return "Сообщения"
            case .profile:
                return "Профиль"
            }
        }

        var image: UIImage? {
            switch self {
            case .catalog:
                return UIImage(systemName: "bubbles.and.sparkles.fill")
            case .favorites:
                return UIImage(systemName: "heart.fill")
            case .ads:
                return UIImage(systemName: "tablecells.badge.ellipsis")
            case .messages:
                return UIImage(systemName: "message.fill")
            case .profile:
                return UIImage(systemName: "person.fill")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let tabBarItems: [TabBarItems] = [.catalog, .favorites, .ads, .messages, .profile]
        tabBar.tintColor = .aBlue
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white

        viewControllers = tabBarItems.map({ item in
            switch item {
            case .catalog:
                let viewController = CatalogViewController()
                return createNavigationController(vc: viewController)
            case .favorites:
                let viewController = FavoritesViewController()
                return createNavigationController(vc: viewController)
            case .ads:
                let viewController = AdsViewController()
                return createNavigationController(vc: viewController)
            case .messages:
                let viewController = MessagesViewController()
                return createNavigationController(vc: viewController)
            case .profile:
                let viewController = ProfileViewController()
                return createNavigationController(vc: viewController)
            }
        })

        viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = tabBarItems[index].title
            vc.tabBarItem.image = tabBarItems[index].image
        })
    }

    private func createNavigationController(vc: UIViewController) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: vc)
        return navigationVC
    }


}
