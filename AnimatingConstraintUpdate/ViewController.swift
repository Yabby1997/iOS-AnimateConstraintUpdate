//
//  ViewController.swift
//  AnimatingConstraintUpdate
//
//  Created by Seunghun Yang on 2022/05/18.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 8
        return view
    }()
    
    private let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let toggle: UISwitch = {
        let view = UISwitch()
        view.isOn = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(toggle)
        toggle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        toggle.addTarget(self, action: #selector(switchDidToggled), for: .valueChanged)
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)
        
        firstView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
        secondView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
    }
    
    @objc private func switchDidToggled(_ sender: UISwitch) {
        toggle.snp.updateConstraints { make in
            make.centerX.equalToSuperview().offset(50)
        }
        
        // If remove layoutIfNeeded on line 74,constraint update of toggle will be animated too.
        self.view.layoutIfNeeded()
        
        if sender.isOn {
            UIView.animate(
                withDuration: 0.25,
                delay: 0.1,
                options: UIView.AnimationOptions.curveEaseIn,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.stackView.snp.updateConstraints { make in
                        make.bottom.equalToSuperview().offset(-16)
                    }
                    self.view.layoutIfNeeded()
                }
            )
        } else {
            UIView.animate(
                withDuration: 0.25,
                delay: 0.1,
                options: UIView.AnimationOptions.curveEaseIn,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.stackView.snp.updateConstraints { make in
                        make.bottom.equalToSuperview().offset(75)
                    }
                    self.view.layoutIfNeeded()
                }
            )
        }
    }
}

