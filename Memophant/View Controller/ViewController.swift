import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var dayStackView: UIStackView!
    
    var memosPerMonth: [MonthAndYear: [Memo]] = [:]
    var orderedMemoDictionaryKeys : [MonthAndYear] = []
    var currentMemoDictionaryKeyIndex = 0
    
    var showEditDialog = false
    var currentEditingMemo: Memo? = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "showAddMemoView" {
            
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
    
    @IBAction func addMemo(_ sender: Any) {
        showEditDialog = false

        performSegue(withIdentifier: "showAddMemoView", sender: self)
    }
    
    func editMemo(memo: Memo) {
        showEditDialog = true
        currentEditingMemo = memo
        performSegue(withIdentifier: "showAddMemoView", sender: self)
    }
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var goToNewestButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if (isFirstAppStartEver() && MemoRepository.shared.allMemos.isEmpty) {
            loadDummyMemos()
        }

        updateView(shouldRefreshMemos: true)
    
    }
    
    func isFirstAppStartEver() -> Bool {
        let firstAppStart = UserDefaults.standard.object(forKey: "firstAppStart")
       
        if (firstAppStart == nil) {
            UserDefaults.standard.set(false, forKey: "firstAppStart")
            return true
        }
        
        return false
    }
    
    func refreshMemos(shouldJumpToFirstDay: Bool) {
        let memos = MemoRepository.shared.allMemos
        
        memosPerMonth = splitMemosPerMonth(memos: memos)
        orderedMemoDictionaryKeys = memosPerMonth.keys.sorted { (a,b) in
            
            if a.year > b.year {
                return true
            }
            
            if (a.year == b.year) {
                return a.month > b.month
            }
            
            return false
            
        }
        
        if (shouldJumpToFirstDay || currentMemoDictionaryKeyIndex >= orderedMemoDictionaryKeys.count) {
            currentMemoDictionaryKeyIndex = 0
        }
        
    }
    
    func updateButtonEnabledState() {
        backButton.isEnabled = currentMemoDictionaryKeyIndex < orderedMemoDictionaryKeys.count - 1
        forwardButton.isEnabled = currentMemoDictionaryKeyIndex > 0
        goToNewestButton.isEnabled = currentMemoDictionaryKeyIndex != 0

    }
    
    func updateView(shouldRefreshMemos: Bool = false, shouldJumpToFirstDay: Bool = false) {
        
        if (shouldRefreshMemos) {
            refreshMemos(shouldJumpToFirstDay: shouldJumpToFirstDay)
        }
        
        updateButtonEnabledState()
        dayStackView.isHidden = orderedMemoDictionaryKeys.isEmpty
        
        
        if orderedMemoDictionaryKeys.count == 0 {
            return
        } else {
            
            
            
            dayStackView.removeAllArrangedSubviews()
        
        let memosForSelectedMonthKey = orderedMemoDictionaryKeys[currentMemoDictionaryKeyIndex]
        let memosForSelectedMonth = memosPerMonth[memosForSelectedMonthKey]
        
        //check which entrys should be grouped together
        
        var currentGroupedEntrys: [Memo] =  []
        var currentDay: Int? = nil
        
        
        memosForSelectedMonth!.forEach {memo in
            
            if (currentDay == nil) {
                currentDay = getDayFromMemo(memo: memo)
                currentGroupedEntrys.append(memo)
            } else if (currentDay == getDayFromMemo(memo: memo)) {
                currentDay = getDayFromMemo(memo: memo)
                currentGroupedEntrys.append(memo)
            } else {
                
                //Gruppe hinzufügen
                let dayView = DayView()
                dayView.configureView(day: "\(currentDay!)", memos: currentGroupedEntrys, viewControllerDelegate: self)
                dayStackView.addArrangedSubview(dayView)
                
                currentGroupedEntrys.removeAll()
                
                currentDay = getDayFromMemo(memo: memo)
                currentGroupedEntrys.append(memo)
                
                
            }
            
        
            
            
        }
        
        //Gruppe hinzufügen
        let dayView = DayView()
        dayView.configureView(day: "\(currentDay!)", memos: currentGroupedEntrys, viewControllerDelegate: self)
        dayStackView.addArrangedSubview(dayView)
        
        
        //Set Navbar Title
        
        self.title = "\(monthName(monthNumber: memosForSelectedMonthKey.month)) \(memosForSelectedMonthKey.year)"
            
        }
        
        //Scroll on Top of Scroll View
        
       
        
        
        if (shouldJumpToFirstDay) {
            scrollView.scrollToTop()
        }
        

        
    }
    
    func loadDummyMemos() {
        
        MemoRepository.shared.readDummyMemos().forEach { memo in
            MemoRepository.shared.updateMemo(memo: memo)
        }
         
    }
    
    func splitMemosPerMonth(memos: [Memo]) -> [MonthAndYear: [Memo]]{
        
        var memosPerMonth: [MonthAndYear: [Memo]] = [:]
        
        memos.forEach { memo in
            let monthAndYear = MonthAndYear(month: getMonthFromMemo(memo: memo), year: getYearFromMemo(memo: memo))
            
            if (memosPerMonth[monthAndYear] == nil) {
                memosPerMonth[monthAndYear] = [memo]
            } else {
                memosPerMonth[monthAndYear]!.append(memo)
            }
            
        }
        
        return memosPerMonth
        
    }
    
  
    func getYearFromMemo(memo: Memo) -> Int {
        return memo.date!.get(.year).year!
    }
    
    func getMonthFromMemo(memo: Memo) -> Int{
        return memo.date!.get(.month).month!
    }
    
    func getDayFromMemo(memo: Memo) -> Int {
        return memo.date!.get(.day).day!
    }
    
    
    @IBAction func back(_ sender: Any) {
        currentMemoDictionaryKeyIndex += 1
        updateView()
    }
    
    func monthName(monthNumber: Int) -> String {
        return DateFormatter().monthSymbols[monthNumber - 1]

    }
    
    @IBAction func newest(_ sender: Any) {
        currentMemoDictionaryKeyIndex = 0
        updateView()
    }
    
    @IBAction func forward(_ sender: Any) {
        currentMemoDictionaryKeyIndex -= 1
            updateView()
    }
    
  
    
}

