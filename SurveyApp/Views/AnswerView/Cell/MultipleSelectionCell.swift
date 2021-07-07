//
//  MultipleSelectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/7/21.
//

import UIKit
import SnapKit

class MultipleSelectionCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let selectButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    private func setUpLayout() {
        addSubview(titleLabel)
        addSubview(selectButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(13.0)
        }
        
        selectButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.width.equalTo(24.0)
        }
    }
    
    private func setUpViews() {
        titleLabel.font = UIFont.regular(ofSize: .heading)
        titleLabel.textColor = .white
        
        selectButton.round()
        selectButton.backgroundColor = .clear
        selectButton.setBackgroundImage(Asset.unchecked(), for: .normal)
        selectButton.setBackgroundImage(Asset.checked(), for: .selected)
        selectButton.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
    }
}

extension MultipleSelectionCell {
    
    @objc func didTapSelectButton(_ sender: UIButton) {
        selectButton.isSelected = !sender.isSelected
    }
}
