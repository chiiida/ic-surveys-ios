//
//  MultipleChoiceAnswerView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/7/21.
//

import UIKit
import NimbleExtension

class MultipleChoiceAnswerView: UIView, AnswerView {

    let answers: [SurveyAnswer]
    
    weak var delegate: AnswerViewDelegate?

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
            $0.leading.equalToSuperview().inset(10.0)
            $0.trailing.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().inset(50.0)
            $0.bottom.lessThanOrEqualToSuperview().inset(20.0)
            $0.height.lessThanOrEqualTo(300.0)
        }
    }

    private func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MultipleSelectionCell.self)

        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = true
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
        cell.delegate = self
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
}

// MARK: - MultipleSelectionCellDelegate

extension MultipleChoiceAnswerView: MultipleSelectionCellDelegate {
    
    func didSelectCell(_ cell: MultipleSelectionCell) {
        let index = tableView.indexPath(for: cell)
        
        if let index = index, cell.isSelected {
            tableView.deselectRow(at: index, animated: false)
        } else {
            tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        }
        
        let selectedAnswers = tableView.indexPathsForSelectedRows?.compactMap {
            return AnswerSubmission(id: answers[$0.row].id, answers: nil)
        } ?? []
        delegate?.didAnswer(answers: selectedAnswers)
    }
}
