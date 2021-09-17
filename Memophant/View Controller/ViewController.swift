import UIKit


class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var dayStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var goToNewestButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    //MARK: Constants
    let showAddMemoViewSegueIdentifier = "showAddMemoView"
    
    //MARK: Properties
    var memoViewModel = MemoViewModel()
    var showEditDialog = false
    var currentEditingMemo: Memo? = nil
    
    //MARK: Actions
    @IBAction func addMemo(_ sender: Any) {
        showEditDialog = false
        performSegue(withIdentifier: showAddMemoViewSegueIdentifier, sender: self)
    }
    
    @IBAction func back(_ sender: Any) {
        memoViewModel.currentMemoDictionaryKeyIndex += 1
        updateView()
    }
    
    @IBAction func newest(_ sender: Any) {
        memoViewModel.currentMemoDictionaryKeyIndex = 0
        updateView()
    }
    
    @IBAction func forward(_ sender: Any) {
        memoViewModel.currentMemoDictionaryKeyIndex -= 1
        updateView()
    }
    
    //MARK: Superclass methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaultsService.checkOrSetFirstAppStart() && MemoRepository.shared.readMemos.isEmpty) {
            WelcomeMemoRepository.createWelcomeMemos()
        }
        
        updateView(shouldRefreshMemos: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == showAddMemoViewSegueIdentifier {
            let destination = segue.destination as! AddMemoViewController
            destination.viewControllerDelegate = self
            if (showEditDialog) {
                destination.editingMode = true
                destination.currentEditingMemo = currentEditingMemo
            } else {
                destination.editingMode = false
                destination.currentEditingMemo = nil
            }
        }
    }
    
    
    //MARK: View Methods
    private func updateView(shouldRefreshMemos: Bool = false, shouldJumpToFirstDay: Bool = false) {
        
        if (shouldRefreshMemos) {
            refreshMemos(shouldJumpToFirstDay: shouldJumpToFirstDay)
        }
        
        updateButtonEnabledState()
        dayStackView.isHidden = memoViewModel.orderedMemoDictionaryKeys.isEmpty
        showMemosForSelectedMonth()
        
        if (shouldJumpToFirstDay) {
            scrollView.scrollToTop()
        }
        
    }
    
    private func updateButtonEnabledState() {
        backButton.isEnabled = memoViewModel.currentMemoDictionaryKeyIndex < memoViewModel.orderedMemoDictionaryKeys.count - 1
        forwardButton.isEnabled = memoViewModel.currentMemoDictionaryKeyIndex > 0
        goToNewestButton.isEnabled = memoViewModel.currentMemoDictionaryKeyIndex != 0
    }
    
    
    private func refreshMemos(shouldJumpToFirstDay: Bool){
        let memos = MemoRepository.shared.readMemos
        memoViewModel.setMemos(memos: memos, shouldJumpToFirstDay: shouldJumpToFirstDay)
    }
    
    private func showMemosForSelectedMonth() {
        
        guard memoViewModel.orderedMemoDictionaryKeys.count > 0 else {
            return
        }

        let memosForSelectedMonthKey = memoViewModel.orderedMemoDictionaryKeys[memoViewModel.currentMemoDictionaryKeyIndex]
        let memosForSelectedMonth = memoViewModel.memosPerMonth[memosForSelectedMonthKey]
        
        addMemosToStackView(memosForSelectedMonth: memosForSelectedMonth!)
        updateNavbarTitle(month: memosForSelectedMonthKey.month, year: memosForSelectedMonthKey.year)
    }
    
    private func addMemosToStackView(memosForSelectedMonth: [Memo]) {
        dayStackView.removeAllArrangedSubviews()

        //check which entrys should be grouped together
        var memosForCurrentDay: [Memo] =  []
        var currentDay: Int? = nil
        
        memosForSelectedMonth.forEach {memo in
            if (currentDay == nil || (currentDay == memo.day)) {
            } else {
                addDayToStackView(day: currentDay!, memos: memosForCurrentDay)
                memosForCurrentDay.removeAll()
            }
            currentDay = memo.day
            memosForCurrentDay.append(memo)
        }
        
        addDayToStackView(day: currentDay!, memos: memosForCurrentDay)
    }
    
    private func addDayToStackView(day: Int, memos: [Memo]) {
        let dayView = DayView()
        dayView.configureView(day: "\(day)", memos: memos, viewControllerDelegate: self)
        dayStackView.addArrangedSubview(dayView)
    }
    
    private func updateNavbarTitle(month: Int, year: Int) {
        self.title = "\(CalendarService.monthName(monthNumber: month)) \(year)"
    }
    
}

//MARK: Extensions
extension ViewController: AddMemoViewDelegate {
    
    func updateView(shouldJumpToFirstDay: Bool = false) {
        updateView(shouldRefreshMemos: true, shouldJumpToFirstDay: shouldJumpToFirstDay)
    }
    
}

extension ViewController: MemoEntryViewDelegate {
    func editMemo(memo: Memo) {
        showEditDialog = true
        currentEditingMemo = memo
        performSegue(withIdentifier: showAddMemoViewSegueIdentifier, sender: self)
    }
}
