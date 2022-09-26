# Task_list
Simple to do list app
Простое приложение по планировке задач.
Для работы необходима бд postgresql (в файле application.yml содержаться настройки работы с бд).
Таблица, необходимая для работы, должна именоваться task и должна содержать следующие столбцы: 
    Long id (id BIGSERIAL PRIMARY KEY)
    LocalDate date (date DATE NOT NULL)
    String description (description TEXT)
    boolean done (done BOOLEAN NOT NULL DEFAULT FALSE)
    
В текущей версии реализовано только добавление задач, изменение статуса на "Выполнено" и их удаление.
Работа через браузер: http://localhost:8080/
