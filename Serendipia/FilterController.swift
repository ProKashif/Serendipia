//
//  FilterController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/3/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

struct Filter {
	let name: String
	var selected: Bool
}

class FilterController: UIViewController {
	var filters = TestFilters().testFilters
	var selectedFilters: [Filter] {
		return filters.filter { $0.selected }
	}
	var filtersSelected: (([Filter]) -> ())?
	
	@IBAction private func applyFiltersTapped() {
		filtersSelected?(selectedFilters)
	}
}

extension FilterController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filters.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "filter", for: indexPath)
		if let cell = cell as? FilterCell {
			cell.configure(filter: filters[indexPath.row])
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		filters[indexPath.row].selected.toggle()
		tableView.cellForRow(at: indexPath)?.accessoryType = filters[indexPath.row].selected ? .checkmark : .none
	}
}

class FilterCell: UITableViewCell {
	func configure(filter: Filter) {
		textLabel?.text = filter.name
		accessoryType = filter.selected ? .checkmark : .none
	}
}
