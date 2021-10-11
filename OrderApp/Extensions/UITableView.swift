//
//  UITableView.swift
//  OrderApp
//
//  Created by Majlinda - INNO on 25.6.21.
//

import UIKit
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let nib = UINib(nibName: reuseIdentifier ?? String(describing: T.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        
        return cell
    }
}
