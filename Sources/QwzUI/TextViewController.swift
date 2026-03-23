//
//  TextViewController.swift
//  swift-qwz-ui
//
//  Created by qinwenzhou on 2026/3/22.
//

import UIKit

public class TextViewController: UIViewController {
    public var textView = UITextView()
    
    public var keyboardAccessoryViewController: UIViewController? {
        didSet {
            textView.inputAccessoryView = keyboardAccessoryViewController?.view
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
