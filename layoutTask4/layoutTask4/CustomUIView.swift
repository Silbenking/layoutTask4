//
//  CustomUIView.swift
//  layoutTask4
//
//  Created by Сергей Сырбу on 13.09.2023.
//

import UIKit

class CustomUIView: UIView {

    private enum Constant {
        static let radiusView: CGFloat = 12
        static let widhtSize: CGFloat = 106
        static let heightSize: CGFloat = 108
        static let imageViewInset: CGFloat = 16
        static let textLabelOffset: CGFloat = 8
        static let textLabelFontSize: CGFloat = 13
    }
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: Constant.textLabelFontSize)
        return label
    }()

    let imageView = UIImageView()
    
    init(text: String, image: UIImage) {
        super.init(frame: .zero)
        configureView()
        setText(text)
        setImage(image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        addSubview(textLabel)
        addSubview(imageView)
        
        self.layer.cornerRadius = Constant.radiusView
        backgroundColor = .white
        
        self.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: Constant.widhtSize, height: Constant.heightSize))
        }
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(Constant.imageViewInset)
        }
        textLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(Constant.textLabelOffset)
        }
    }
    
    private func setText(_ text: String) {
        textLabel.text = text
    }
    
    private func setImage(_ image: UIImage) {
        imageView.image = image
    }
  
}
