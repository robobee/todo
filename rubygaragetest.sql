/* Create Schema */
CREATE TABLE tasks (id INT PRIMARY KEY IDENTITY(1,1), name VARCHAR(150), status VARCHAR(20), project_id INT)
CREATE TABLE projects (id INT PRIMARY KEY IDENTITY(1,1), name VARCHAR(150))

/* Create Sample Data */
INSERT INTO projects (name)
VALUES 
	 ('Garage')
	,('Work')
	,('Fly To The Moon')
	,('Become The President Of The Universe')
	,('Bake A Cake')
	,('Trip To Barselona')
	,('A Lonely Project')

INSERT INTO tasks (name, status, project_id)
VALUES 
	 ('Open the mock-up in Adobe Fireworks', 'New', 1)
	,('Attentively check the file', 'New', 1)
	,('Write HTML & CSS', 'Completed', 1)
	,('Add Javascript to implement adding / editing / removing for todo items and lists taking into account as more use cases as possible', 'Started', 1)
	,('Finish all the tasks for the week on monday', 'New', 2)
	,('Learn RoR', 'Started', 2)
	,('Croudfund first amateur moon-flight', 'New', 3)
	,('Fly to the moon', 'New', 3)
	,('Return home', 'New', 3)
	,('Return home', 'New', 3)
	,('Become very famous for flying to the moon and back', 'New', 4)
	,('Apply for elections and win', 'New', 4)
	,('Find good recipe online', 'Completed', 5)
	,('Buy and mix all the necessary ingredients', 'Completed', 5)
	,('Preheat oven', 'Completed', 5)
	,('Preheat oven', 'Completed', 5)
	,('Bake a cake for 60 min at 220 degrees', 'Completed', 5)
	,('Buy cheap Wizz-Air tickets', 'Completed', 6)
	,('Book hostel at Booking.com', 'Completed', 6)
	,('Apply for Visa', 'New', 6)
	,('Orphaned task', 'Completed', NULL)
	,('Write HTML & CSS', 'Completed', 5)
	,('Open the mock-up in Adobe Fireworks', 'New', 6)
	,('Write HTML & CSS', 'Completed', 3)
	,('Write HTML & CSS', 'Completed', 4)

/* 1. Get all statuses, not repeating, alphabetically ordered */

SELECT DISTINCT tasks.status
FROM tasks
ORDER BY tasks.status ASC

/* 2. Get the count of all tasks in each project, order by tasks count descending */
 
SELECT p.id, p.name, count(p.id) AS number_of_tasks
FROM tasks t INNER JOIN projects p
	ON t.project_id = p.id
GROUP BY p.id, p.name
ORDER BY count(p.id) DESC
 
/* 3. Get the count of all tasks in each project, order by projects names */

SELECT p.id, p.name, count(p.id) AS number_of_tasks
FROM tasks t INNER JOIN projects p
	ON t.project_id = p.id
GROUP BY p.id, p.name
ORDER BY p.name ASC
 
/* 4. Get the tasks for all projects having the name beginning with !“B” letter */

SELECT t.name AS task_name, p.name AS project_name
FROM tasks t INNER JOIN projects p
	ON t.project_id = p.id
WHERE p.name LIKE 'B%'

/* 5. Get the list of all projects containing the ‘a’ letter in the middle of the name, and show the 
tasks count near each project. Mention that there can exist projects without tasks and 
tasks with project_id=NULL */
 
SELECT p.name AS project_name, count(t.id) AS task_count
FROM tasks t RIGHT JOIN projects p
	ON t.project_id = p.id
WHERE p.name LIKE '%a%'
GROUP BY p.name
 
/* 6. Get the list of tasks with duplicate names. Order alphabetically */

SELECT DISTINCT a.name
FROM tasks a INNER JOIN tasks b
	ON a.name = b.name
	AND a.id <> b.id
ORDER BY a.name ASC

/* 7. Get the list of tasks having several exact matches of both name and status, from the 
project ‘Garage’. Order by matches count */

SELECT tasks.name, count(tasks.id) as matches
FROM tasks
INNER JOIN projects
	ON tasks.project_id = projects.id
WHERE EXISTS (SELECT t.name, t.status, p.id
				FROM tasks t INNER JOIN projects p
				ON t.project_id = p.id
				WHERE p.name = 'Garage'
					AND t.name = tasks.name
					AND t.status = tasks.status
					AND p.id <> projects.id)
GROUP BY tasks.name
ORDER BY matches DESC

/* 8. Get the list of project names having more than !2 tasks in status ‘completed’. Order by 
project_id */

SELECT p.name, count(t.id) as completed_tasks_count
FROM tasks t INNER JOIN projects p
	ON t.project_id = p.id
WHERE t.status = 'Completed'
GROUP BY p.name, t.project_id
HAVING count(t.id) >= 2
ORDER BY t.project_id
