//
//  CustomAlertViewController.swift
//  simulation
//
//  Created by WanHsuan on 2023/9/5.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    var correctAnsNum: Int = 0
    var starNum: Int = 0
    var star = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        setupAlertView()
    }
    
    
    
    private func setupAlertView() {
        showStar()
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 10
        
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 280),
            alertView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("返回查看題目", for: .normal)
//        closeButton.backgroundColor = .systemGray4
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        alertView.addSubview(closeButton)
        closeButton.layer.cornerRadius = 10
        closeButton.clipsToBounds = true

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -10),
            closeButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 120),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        
        let titleLabel = UILabel()
        titleLabel.text = star
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        alertView.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10)
        ])
        
        let messageLabel = UILabel()
        messageLabel.text = "答對"+String(correctAnsNum)+"題"
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        alertView.addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10)
        ])
    }
    
    
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func showStar(){
        if starNum == 0{
            star = "☆☆☆"
        }else if starNum == 1{
            star = "★☆☆"
        }else if starNum == 2{
            star = "★★☆"
        }else if starNum == 3{
            star = "★★★"
        }else{
            star = ""
        }
    }
    

    
    
    
}
