//
//  MainScreenViewController.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit

protocol MainScreenDisplayLogic: class {
    func displayWeatherByCoordinate(viewModel: MainScreen.DefaultListOfCities.ViewModel)
    func displayList(viewModel: MainScreen.DefaultListOfCities.ViewModel)
}

class MainScreenViewController: UIViewController, MainScreenDisplayLogic {
    
    var interactor: MainScreenBusinessLogic?
    var router: (NSObjectProtocol & MainScreenRoutingLogic & MainScreenDataPassing)?
    
    private var displayData: MainScreen.DefaultListOfCities.ViewModel?
    private var cityByCoordinate: MainScreen.DefaultListOfCities.CityInfo?
    
    @IBOutlet weak var tableViewOfCities: UITableView!
    @IBOutlet weak var infoTextView: CustomTextView!
    @IBOutlet weak var hieghtInfoViewConstraint: NSLayoutConstraint!
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MainScreenConfigurator.shared.configurate(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MainScreenConfigurator.shared.configurate(self)
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestureRecognizer()
        tableViewOfCities.register(UINib(nibName: CityCell.reusableIdentifier, bundle: nil),
                                   forCellReuseIdentifier: CityCell.reusableIdentifier)
        selectRow(0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeSize))
        infoTextView.addGestureRecognizer(gesture)
    }
    
    
    @objc func changeSize() {
        infoTextView.changeHeightConstraintIfExistsWithAnimation(CustomTextView.hieghtAnchorIdentifier)
    }
    
    
    // MARK: Select row
    
    func selectRow(_ atIndex: Int) {
        let request = MainScreen.DefaultListOfCities.Request(indexRow: atIndex, cityByCoordinate: cityByCoordinate)
        interactor?.selectRow(request: request)
    }
    
    func displayList(viewModel: MainScreen.DefaultListOfCities.ViewModel) {
        displayData = viewModel
        DispatchQueue.main.async {
            self.infoTextView.text = viewModel.fullInfo
        }
    }
    
    func displayWeatherByCoordinate(viewModel: MainScreen.DefaultListOfCities.ViewModel) {
        displayData?.cities?.append((viewModel.cities?.first)!)
        cityByCoordinate = displayData?.cities?.last
        DispatchQueue.main.async {
            self.tableViewOfCities.beginUpdates()
            self.tableViewOfCities.insertRows(at: [IndexPath(row: (self.displayData?.cities?.count ?? 0) - 1, section: 0)], with: .automatic)
            self.tableViewOfCities.endUpdates()
        }
    }
}

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData?.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reusableIdentifier, for: indexPath) as? CityCell {
            cell.data = displayData?.cities?[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectRow(indexPath.row)
        
    }
    
    
}
