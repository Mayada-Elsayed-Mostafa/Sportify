import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let pagesData: [(String, String, String)] = [
        ("onboarding1", "Explore All Sports", "Browse a wide range of sports with rich visuals and details."),
        ("onboarding2", "Follow Leagues", "Dive into your favorite leagues and stay up-to-date with their events."),
        ("onboarding3", "Track Events & Teams", "Check upcoming and latest matches, and explore team details effortlessly.")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstVC = viewControllerAt(index: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAt(index: Int) -> OnboardingViewController? {
        guard index >= 0 && index < pagesData.count else { return nil }
        let vc = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        vc.imageName = pagesData[index].0
        vc.titleText = pagesData[index].1
        vc.descriptionText = pagesData[index].2
        vc.pageIndex = index
        vc.totalPages = pagesData.count
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingViewController else { return nil }
        return viewControllerAt(index: currentVC.pageIndex - 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? OnboardingViewController else { return nil }
        return viewControllerAt(index: currentVC.pageIndex + 1)
    }
}
