package com.example.task_list_maven.controller;

import com.example.task_list_maven.model.Task;
import com.example.task_list_maven.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Map;

@Controller
public class TaskController {
    @Autowired
    private  TaskRepository taskRepository;

    @GetMapping
    public String main(Map<String, Object> model) {
        Iterable<Task> tasks = taskRepository.findAll();
        model.put("tasks", tasks);
        return "main";
    }

    @PostMapping
    public String add(@RequestParam String date, @RequestParam String description, Map<String, Object> model) {
        LocalDate localDate;
        try {
            localDate = LocalDate.parse(date);
        } catch (Exception e) {
            return "redirect:/";
        }
        if (description.length() == 0)
            return "redirect:/";
        Task task = new Task(taskRepository.count() + 1, localDate, description);
        taskRepository.save(task);
        return "redirect:/";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        taskRepository.deleteById(id);
        return "redirect:/";
    }

    @PostMapping("/tasks")
    public Task create(@RequestBody Task task) {
        return taskRepository.save(task);
    }

    @PostMapping("/done/{id}")
    public String patchMethod(@PathVariable Long id){
        var task = taskRepository.findById(id).get();
        if (task != null && !task.isDone()) {
            task.setDone(true);
            taskRepository.save(task);
        }
        return "redirect:/";
    }
}
