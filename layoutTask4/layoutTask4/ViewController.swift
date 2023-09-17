//
//  ViewController.swift
//  layoutTask4
//
//  Created by Сергей Сырбу on 13.09.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    enum Constant {
        static let checkImageInset: CGFloat = 118
        static let nameLabelFontSize: CGFloat = 17
        static let nameLabelOffset: CGFloat = 24
        static let moneyLabelFontSize: CGFloat = 30
        static let moneyLabelOffset: CGFloat = 12
        static let comissionLabelFontSize: CGFloat = 13
        static let comissionLabelOffset: CGFloat = 12
        static let dateLabelFontSize: CGFloat = 13
        static let dateLabelOffset: CGFloat = 4
        static let stackSpacing: CGFloat = 13
        static let stackOffset: CGFloat = 24
        static let operationViewOffset: CGFloat = 34
        static let detailsLabelFontSize: CGFloat = 16
        static let toMainButtonRadius: CGFloat = 12
        static let toMainButtonInset: CGFloat = 52
        static let toMainButtonLFInset: CGFloat = 16
        static let toMainButtonHeight: CGFloat = 52
        static let operationStackSpacing: CGFloat = 12
        static let operationStackOffset: CGFloat = 20
        static let operationStackLeading: CGFloat = 16
    }
    
    
    let checkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "check")
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Aleksander Dmitrievich V."
        label.font = .systemFont(ofSize: Constant.nameLabelFontSize, weight: .bold)
        return label
    }()
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.text = "100$"
        label.font = .systemFont(ofSize: Constant.moneyLabelFontSize, weight: .heavy)
        return label
    }()
    let comissionLabel: UILabel = {
        let label = UILabel()
        label.text = "No commission"
        label.font = .systemFont(ofSize: Constant.comissionLabelFontSize)
        label.textColor = .gray
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Completed, 12 September 16:00"
        label.font = .systemFont(ofSize: Constant.dateLabelFontSize)
        label.textColor = .gray
        return label
    }()
    
    let openView = CustomUIView(text: "Open receipt", image: UIImage(named: "open")!)
    let createView = CustomUIView(text: "Create sample", image: UIImage(named: "create")!)
    let repeatView = CustomUIView(text: "Repeat payment", image: UIImage(named: "repeat")!)
    
    var openViewBool = false
    var createViewBool = false
    var repeatViewBool = false
    
    let operationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "info"), for: .normal)
        return button
    }()
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Operation details"
        label.font = .systemFont(ofSize: Constant.detailsLabelFontSize)
        return label
    }()
    let chevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    let toMainButton: UIButton = {
        let button = UIButton()
        button.setTitle("To Main", for: .normal)
        button.backgroundColor = UIColor(red: 61/255, green: 112/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = Constant.toMainButtonRadius
        return button
    }()
    var countView = 0
    let gestureOpen = UITapGestureRecognizer()
    let gestureCreate = UITapGestureRecognizer()
    let gestureRepeat = UITapGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBehavior()
        openView.addGestureRecognizer(gestureOpen)
        gestureOpen.addTarget(self, action: #selector(openTap))
        createView.addGestureRecognizer(gestureCreate)
        gestureCreate.addTarget(self, action: #selector(createTap))
        repeatView.addGestureRecognizer(gestureRepeat)
        gestureRepeat.addTarget(self, action: #selector(repeatTap))
        setupLayout()
        setupAppearance()
        
    }

    private func setupLayout() {
        view.addSubview(checkImage)
        checkImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(Constant.checkImageInset)
        }
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(checkImage.snp.bottom).offset(Constant.nameLabelOffset)
        }
        view.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(Constant.moneyLabelOffset)
        }
        view.addSubview(comissionLabel)
        comissionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moneyLabel.snp.bottom).offset(Constant.comissionLabelOffset)
        }
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(comissionLabel.snp.bottom).offset(Constant.dateLabelOffset)
        }
        let stackView = UIStackView()
        stackView.addArrangedSubview(openView)
        stackView.addArrangedSubview(createView)
        stackView.addArrangedSubview(repeatView)
        stackView.axis = .horizontal
        stackView.spacing = Constant.stackSpacing
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(Constant.stackOffset)
        }
        view.addSubview(operationView)
        operationView.snp.makeConstraints { make in
            make.left.trailing.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(Constant.operationViewOffset)
            make.bottom.equalToSuperview()
        }
        let operationStackView = UIStackView()
        operationStackView.addArrangedSubview(infoButton)
        let ficView = UIView()
        operationStackView.addArrangedSubview(detailsLabel)
        operationStackView.addArrangedSubview(ficView)
        ficView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        operationStackView.addArrangedSubview(chevronButton)
        operationStackView.axis = .horizontal
        operationStackView.alignment = .fill
        operationStackView.spacing = Constant.operationStackSpacing
        operationView.addSubview(operationStackView)
        operationStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constant.operationStackLeading)
            make.leading.equalToSuperview().inset(Constant.operationStackLeading)
            make.top.equalToSuperview().inset(Constant.operationStackOffset)
        }
        operationView.addSubview(toMainButton)
        toMainButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(Constant.toMainButtonHeight)
            make.leading.trailing.equalToSuperview().inset(Constant.toMainButtonLFInset)
            make.bottom.equalToSuperview().inset(Constant.toMainButtonInset)
        }
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor(red: 243/255, green: 246/255, blue: 250/255, alpha: 1)
    }
    
     func setupBehavior() {
    }
    @objc func openTap() {
//        DispatchQueue.main.async {
            print("\(self.countView)")
            self.countView += 1
            self.openView.textLabel.textColor = .black
            self.openViewBool = true
            if countView == 1 {
               checkImage.image = UIImage(named: "open")
               print("\(countView)")
//            countView -= 1
            } else if countView == 2 {
                checkImage.image = UIImage(named: "check")
        }
    }
    @objc func createTap() {
        createView.textLabel.textColor = .black
        createViewBool = true
        countView += 1
    }
    @objc func repeatTap() {
        repeatView.textLabel.textColor = .black
        repeatViewBool = true
        countView += 1
    }
}

