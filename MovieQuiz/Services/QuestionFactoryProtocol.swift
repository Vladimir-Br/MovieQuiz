import Foundation
import UIKit

protocol QuestionFactoryProtocol: AnyObject {
    var delegate: QuestionFactoryDelegate? { get set }
    func requestNextQuestion()
    func loadData()
}
