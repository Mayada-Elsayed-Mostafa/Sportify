import Foundation

class SportsPresenter {
    weak var view: SportsViewProtocol?
    
    init(view: SportsViewProtocol) {
        self.view = view
    }
    
    func fetchSports() {
        
        let sports = [
            Sport(name: "Football", imageName: "football"),
            Sport(name: "Basketball", imageName: "basketball"),
            Sport(name: "Tennis", imageName: "tennis"),
            Sport(name: "Cricket", imageName: "cricket"),
        ]
        view?.showSports(sports)
    }
}
