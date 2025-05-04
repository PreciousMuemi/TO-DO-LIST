// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // I'm using a modern version, obviously.

/**
 * @title TodoList
 * @dev This contract is basically my life organized on the blockchain.
 * It's a todo list for a 21-year-old navigating life, code, and vibes.
 */
contract TodoList {

    // 1. Todo Status Enum: Gotta know if it's pending, in progress, or DONE! ✅
    enum TodoStatus {
        Pending,    // Haven't started yet, still processing...
        InProgress, // Grinding! Let's gooo! 
        Completed,  // Nailed it! Done and dusted! 
        Deleted     // Task is gone, reduced to atoms.  (Adding this for frontend delete functionality)
    }

    // 2. Todo Struct: Blueprint for each task in my day.
    struct Todo {
        uint id;            // Unique ID for each task, like its index in the chaos.
        string content;     // The actual task description. Keep it real.
        TodoStatus status;  // Where are we at with this task? Using the enum!
        bool isDeleted;     // Flag to mark if a todo is 'deleted' (since we can't truly remove from storage).
    }

    // 3. Mappings and Arrays: Organizing the mess.
    // Mapping: Quick lookup for a todo by its ID. Like finding a specific TikTok.
    mapping(uint => Todo) private todos;
    // Array: Keeps track of all the todo IDs in order. For when I need to see the whole list.
    uint[] public todoIds; // Making it public so anyone can see the list of IDs.

    // Counter for the next todo ID. Starts at zero because I'm just getting started.
    uint private nextTodoId;

    // 5. Simple Event: Announce when a new task drops!
    event TodoAdded(uint id, string content);
    // Event for status updates (useful for frontend)
    event TodoStatusUpdated(uint id, TodoStatus status);
    // Event for todo content updates
    event TodoContentUpdated(uint id, string newContent);
    // Event for todo deletion
    event TodoDeleted(uint id);


    /**
     * @dev Constructor: Contract created! Let's pre-fill some realistic tasks.
     * This is where the daily grind gets listed.
     */
    constructor() {
        nextTodoId = 0; // Start the ID count.

        // Adding some initial tasks for a typical day:
        _addTodoInternal("07:00 - Alarm goes off. Hit snooze? Maybe once... or twice.");
        _addTodoInternal("07:15 - Okay, ACTUALLY get out of bed. Make it look presentable, mom might check.");
        _addTodoInternal("07:30 - Shower time! Gotta look fresh for the world (or just Zoom).");
        _addTodoInternal("08:00 - Quick breakfast. Cereal? Toast? Whatever's fastest. ");
        _addTodoInternal("08:30 - Commute/Get ready for online classes. Vibe check: ready. ");
        _addTodoInternal("09:00 - Attend Morning Classes. Try not to fall asleep. ");
        _addTodoInternal("12:00 - Lunch break! Refuel time. What's cooking?");
        _addTodoInternal("13:00 - Deep dive into coding. 4 hours minimum grind. Bug hunting season!");
        _addTodoInternal("17:00 - Break time! Scroll TikTok, hydrate, stretch. Recharge.");
        _addTodoInternal("18:00 - Lisk Africa Bootcamp Class! Time to level up those blockchain skills.");
        _addTodoInternal("19:00 - Dinner time. Maybe cook something, maybe order in. Decisions, decisions.");
        _addTodoInternal("20:00 - Learn a NEW skill. Could be a new coding concept, drawing, language... something different!");
        _addTodoInternal("21:00 - Chill time / Screen time. Binge a show, game, or just vibe with friends online. ");
        _addTodoInternal("22:30 - OFF SCREEN time. Put the phone AWAY. Read a book, journal, just exist. ");
        _addTodoInternal("23:00 - Wind down routine. Get ready for bed. Another day done! ");
        _addTodoInternal("23:30 - Sleep. Finally. Zzzz... ");

        // All initial tasks added! Ready to start checking them off.
    }

    /**
     * @dev Internal helper function to add a todo. Used by the constructor and addTodo.
     * @param _content The description of the task.
     */
    function _addTodoInternal(string memory _content) internal {
         // Create the new Todo struct. Starts as Pending and not deleted.
        todos[nextTodoId] = Todo(nextTodoId, _content, TodoStatus.Pending, false);
        // Add the new task's ID to my list of IDs.
        todoIds.push(nextTodoId);
        // Announce the new task!
        emit TodoAdded(nextTodoId, _content);
        // Increment the counter for the next task.
        nextTodoId++;
    }


    /**
     * @dev Add a new task to the list. Public facing function.
     * @param _content The description of the task.
     */
    function addTodo(string memory _content) public {
        _addTodoInternal(_content); // Use the internal helper
    }

    /**
     * @dev Update the status of a task. Did I finish it? Am I working on it?
     * @param _id The ID of the task to update.
     * @param _status The new status (Pending, InProgress, Completed, Deleted).
     */
    function updateStatus(uint _id, TodoStatus _status) public {
        // First, make sure this todo ID actually exists and isn't already marked as deleted.
        require(_id < nextTodoId, "TodoList: Invalid todo ID. Does that task even exist? ");
        require(!todos[_id].isDeleted, "TodoList: Cannot update status of a deleted todo.");

        // Update the status of the task in the mapping.
        todos[_id].status = _status;
        // Emit an event for the status update.
        emit TodoStatusUpdated(_id, _status);
    }

    /**
     * @dev Update the content of a task. Need to rephrase something?
     * @param _id The ID of the task to update.
     * @param _newContent The new description of the task.
     */
    function updateContent(uint _id, string memory _newContent) public {
         // First, make sure this todo ID actually exists and isn't already marked as deleted.
        require(_id < nextTodoId, "TodoList: Invalid todo ID. Does that task even exist? ");
        require(!todos[_id].isDeleted, "TodoList: Cannot update content of a deleted todo.");

        // Update the content of the task.
        todos[_id].content = _newContent;
        // Emit an event for the content update.
        emit TodoContentUpdated(_id, _newContent);
    }


    /**
     * @dev Mark a todo as deleted. On blockchain, we usually mark instead of truly deleting.
     * @param _id The ID of the task to delete.
     */
    function deleteTodo(uint _id) public {
        // First, make sure this todo ID actually exists and isn't already marked as deleted.
        require(_id < nextTodoId, "TodoList: Invalid todo ID. Does that task even exist? ");
        require(!todos[_id].isDeleted, "TodoList: Todo is already deleted.");

        // Mark the todo as deleted.
        todos[_id].isDeleted = true;
        // Optionally, set the status to Deleted as well.
        todos[_id].status = TodoStatus.Deleted;

        // Emit an event for the deletion.
        emit TodoDeleted(_id);

        // Note: To truly remove from the todoIds array, you'd need more complex logic
        // like shifting elements, which is gas-intensive. Marking as deleted is often sufficient.
    }


    /**
     * @dev Get the details of a specific task.
     * @param _id The ID of the task to retrieve.
     * @return id The task ID.
     * @return content The task description.
     * @return status The current status of the task.
     * @return isDeleted Whether the task is marked as deleted.
     */
    function getTodo(uint _id) public view returns (uint id, string memory content, TodoStatus status, bool isDeleted) {
        // Gotta check the ID again! Safety first!
        require(_id < nextTodoId, "TodoList: Invalid todo ID. Seriously, does it exist? ");
        // Get the todo from storage.
        Todo storage todo = todos[_id];
        // Return the details. Using 'memory' for the string!
        return (todo.id, todo.content, todo.status, todo.isDeleted);
    }

    /**
     * @dev Get the total number of tasks in the list (including deleted ones).
     * @return The total count of tasks added.
     */
    function getTotalTodos() public view returns (uint) {
        return nextTodoId; // The counter holds the total number of tasks added.
    }

    /**
     * @dev Get all the todo IDs. Useful for frontends to iterate through tasks.
     * @return An array of all todo IDs.
     */
    function getAllTodoIds() public view returns (uint[] memory) {
        return todoIds; // Returning the array of IDs.
    }

     /**
     * @dev Get all todo items. This iterates through all IDs and fetches each todo.
     * Note: This can be gas-intensive for a very large number of todos.
     * @return An array of all Todo structs.
     */
    function getAllTodos() public view returns (Todo[] memory) {
        // Create a dynamic array in memory to hold the Todo structs.
        // The size is the total number of todos added.
        Todo[] memory allTodos = new Todo[](nextTodoId);

        // Loop through all possible IDs (from 0 up to nextTodoId - 1).
        for (uint i = 0; i < nextTodoId; i++) {
            // Copy the todo struct from storage to the memory array.
            allTodos[i] = todos[i];
        }

        // Return the memory array containing all todos.
        return allTodos;
    }
}
