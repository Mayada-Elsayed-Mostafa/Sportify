import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var imageName: String?
    var titleText: String?
    var descriptionText: String?
    
    var pageIndex: Int = 0
    var totalPages: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: imageName ?? "")
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        
        startButton.isHidden = (pageIndex != totalPages - 1)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        UserDefaults.standard.set(true, forKey: "hasShownOnboarding")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") 

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = tabBarController
                sceneDelegate.window?.makeKeyAndVisible()
            }
    }
}
