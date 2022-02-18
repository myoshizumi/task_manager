# README



* Ruby version
ruby '3.0.1'
* System dependencies
Rails version             6.0.4.6

# assignment-mk

***Model Name Task***
* Column: name, detail
* Data Type: name: string, datail: text

-----------------------------
**Task**
| Column  |  Data Type   | 
| :---: | :---:| 
|  name   |  string   | 
| detail  |  text   | 
------------------------------
**Herokuへのデプロイ手順**
1. heroku create
2. git add -A
3. git commit -m "init"
4. heroku buildpacks:set heroku/ruby
5. heroku buildpacks:add --index 1 heroku/nodejs
6. **git push heroku step2:main** *Error occured...*
7. bundle lock --add-platform x86_64-linux
8. git add -A
9. git commit -m 'Add platform'
10. git push heroku *step2:main*
11. heroku run rails db:migrate



User 
- Task (*only the useer can see = login system??)

Task

- deadline
- priority
- status 
・ unprocessed
・ work in progress
・ done

1.sort by priority, deadline
2.chosen by the status
3.searched by  the name of the task

Label
- tank will have these lables...


