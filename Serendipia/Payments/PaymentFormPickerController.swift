//
//  PaymentFormPickerController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/7/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import PureLayout

class PaymentFormPickerController: UIViewController {
	@IBOutlet private weak var tableView: UITableView!
	private let paymentCellId = "paymentCell"
	private let dataSource = TestPayments().testPayments
	
	private lazy var paymentLabel: UILabel = {
		let label = UILabel()
		label.text = "Payment"
		label.font = UIFont.systemFont(ofSize: 36, weight: .medium)
		return label
	}()
	
	private lazy var headerView: UIView = {
		let view = UIView()
		view.frame.size.height = 60
		view.addSubview(paymentLabel)
		paymentLabel.autoPinEdgesToSuperviewMargins()
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		
		tableView.autoPinEdgesToSuperviewMargins()
		
		tableView.tableHeaderView = headerView
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.sectionFooterHeight = 0
		tableView.rowHeight = 60
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: paymentCellId)
		
		title = "serendipia"
	}
}

extension PaymentFormPickerController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return dataSource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: paymentCellId, for: indexPath)
		let payment = dataSource[indexPath.section]
		cell.textLabel?.text = payment.title
		cell.backgroundColor = payment.color
		cell.accessoryView = UIImageView(image: .chevron)
		cell.accessoryView?.frame.size.height = tableView.rowHeight
		cell.accessoryView?.frame.size.width = 40
		cell.accessoryView?.contentMode = .center
		cell.layer.cornerRadius = 15
		cell.accessoryView?.backgroundColor = cell.contentView.backgroundColor
		cell.textLabel?.textColor = .white
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "Select method of payment:"
		default:
			return nil
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return section == 0 ? 40 : 0
	}
	
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		if let view = view as? UITableViewHeaderFooterView {
			view.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
			var headerText = view.textLabel?.text
			headerText = headerText?.capitalized
		}
	}
}
