# ToDo List iOS App

This iOS app is a simple **To-Do List** application built as a test project. It allows users to manage tasks by adding, editing, deleting, and searching through their tasks. The app also integrates with a remote API to fetch tasks, stores them in CoreData, and ensures data persistence across app restarts.

## Features

1. **Task List Management**
    - Display a list of tasks on the main screen.
    - Each task contains:
        - Title
        - Description
        - Creation Date
        - Status (Completed/Not Completed)
    - Add new tasks.
    - Edit existing tasks.
    - Delete tasks.
    - Search for tasks by title or description.

2. **API Integration**
    - Fetch the task list from the `dummyjson` API (https://dummyjson.com/todos) during the first launch.
    - Sync tasks from the API with the local database (CoreData).

3. **Concurrency**
    - Operations like adding, editing, deleting, and searching tasks are performed in the background.

4. **CoreData Integration**
    - Task data is persisted locally using **CoreData**.
    - Data is automatically restored when the app is relaunched.

5. **Unit Tests**
    - Unit tests are written for key components of the application to ensure functionality.

## Architecture

This app follows a **VIPER** architecture, designed with the principles of **Clean Architecture** and **SOLID** in mind, ensuring modularity, scalability, and maintainability.



