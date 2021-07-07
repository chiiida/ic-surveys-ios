//
//  MultipleChoiceAnswerView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/7/21.
//

import UIKit
import NimbleExtension

class MultipleChoiceAnswerView: UIView {

    let answers: [SurveyAnswer]

    private let tableView = UITableView()

    init(answers: [SurveyAnswer]) {
        self.answers = answers
        super.init(frame: .zero)
        setUpLayout()
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLayout() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(300.0)
        }
    }

    private func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MultipleSelectionCell.self)

        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = 56.0
        tableView.separatorColor = .white
    }
}

extension MultipleChoiceAnswerView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MultipleSelectionCell.self)
        cell.configure(with: answers[indexPath.item].text)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
}
