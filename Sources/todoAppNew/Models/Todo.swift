import Fluent
import struct Foundation.UUID

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class Todo: Model, @unchecked Sendable {
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "isDone")
    var isDone: Bool

    @Field(key: "timestamp")
    var timestamp: Date

    @Field(key: "deadline")
    var deadline: Date?

    @Field(key: "Priority")
    var priority: String?

    init() { }

    init(id: UUID? = nil, title: String, isDone: Bool = false, timestamp: Date = Date(), deadline: Date? = nil, priority: String? = "Meduim") {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.timestamp = timestamp
        self.deadline = deadline
    }
    
    func toDTO() -> TodoDTO {
        .init(
            id: self.id,
            title: self.$title.value ?? "",
            isDone: self.$isDone.value ?? false,
            timestamp: self.$timestamp.value ?? Date(),
            deadline: self.$deadline.value ?? nil,
            priority: self.$priority.value ?? "Meduim"
        )
    }
    /// Converts the model to a DTO for create
    func ToDoItemCreateDTO() -> TodoDTO {
        .init(
            title: self.$title.value ?? "",
            isDone: self.$isDone.value ?? false,
            deadline: self.$deadline.value ?? nil,
            priority: self.$priority.value ?? "Meduim"
        )
    }
    /// Converts the model to a DTO for update
    func ToDoItemUpdateDTO() -> TodoDTO {
        .init(
            title: self.$title.value ?? "",
            isDone: self.$isDone.value ?? false,
            deadline: self.$deadline.value ?? nil,
            priority: self.$priority.value ?? "Meduim"
        )
    }
    /// Converts the model to a DTO for response
    func TodoItemResponseDTO() -> TodoDTO {
        .init(
            id: self.id,
            title: self.$title.value ?? "",
            isDone: self.$isDone.value ?? false,
            timestamp: self.$timestamp.value ?? Date(),
            deadline: self.$deadline.value ?? nil,
            priority: self.$priority.value ?? "Meduim"
        )
    }
}
