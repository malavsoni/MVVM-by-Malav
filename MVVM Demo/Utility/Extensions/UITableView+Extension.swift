
//
//  UITableView+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

// MARK: - Reuse TableViewCell and headerFooter
extension UITableView {
    public func registerCell<T: UITableViewCell>(_: T.Type) {
        self.register(T.nibName, forCellReuseIdentifier: T.className)
    }
    
    public func registerClass<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.className)
    }
    
    // MARK: - Reuse TableViewCell
    // Yet Don't Require register TableviewCell if not register than first register and than dequeue
    public func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className) as? T else {
            self.registerCell(T.self)
            guard let cell = dequeueReusableCell(withIdentifier: T.className) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.className)")
            }
            return cell
        }
        return cell
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            self.registerCell(T.self)
            guard let cell = dequeueReusableCell(withIdentifier: T.className) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.className)")
            }
            return cell
        }
        return cell
    }
    
    public func registerHeaderFooterView<T: UIView>(_: T.Type) {
        self.register(T.nibName, forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            self.registerHeaderFooterView(T.self)
            guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.className)")
            }
            return view
        }
        return view
    }
}

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
    static var nibName: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
