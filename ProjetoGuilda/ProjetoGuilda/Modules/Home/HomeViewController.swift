//
//  HomeViewController.swift
//  ProjetoGuilda
//
//  Created by Pedro Menezes on 27/10/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Class properties

    private var viewModel: HomeViewModel?
    
    private var loading: UIActivityIndicatorView {
        let loading = UIActivityIndicatorView()
        loading.style = .large
        loading.frame = self.view.frame
        return loading
    }
    
    // MARK: - Lyfe cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TELA INICIAL"
        self.configureTableView()
        self.configureTextfield()
        
        let provider = HomeProvider()
        let viewModel = HomeViewModel(provider: provider)
        viewModel.delegate = self
        self.viewModel = viewModel
    }
    
    // MARK: - Class methods
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCell(CityTableViewCell.className)
    }
    
    private func configureTextfield() {
        self.textField.rightView = UIImageView(image: UIImage.init(systemName: "arrowtriangle.down"))
        self.textField.rightViewMode = .always
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource  = self
        self.textField.inputView = picker
        self.textField.borderStyle = .line
    }

    private func callApi(stateNumber: String) {
        self.toggleLoading(show: true)
        self.viewModel?.callCities(stateNumber: stateNumber)
    }
    
    private func toggleLoading(show: Bool) {
        if(show) {
            self.view.addSubview(self.loading)
            self.loading.startAnimating()
        } else {
            self.loading.removeFromSuperview()
            self.loading.stopAnimating()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.className, for: indexPath) as? CityTableViewCell
        let content = viewModel?.cellContent(for: indexPath.row)
        cell?.passData(title: content ?? "")
        return cell ?? UITableViewCell()
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return STATES.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return STATES[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.callApi(stateNumber: STATES[row].code)
        self.textField.text = STATES[row].text.uppercased()
        self.textField.resignFirstResponder()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func error() {
        self.toggleLoading(show: false)
    }
    
    func success() {
        self.toggleLoading(show: false)
        self.tableView.reloadData()
    }
}
